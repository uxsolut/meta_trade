from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from models.requisicoes import Requisicao
from models.robos_do_user import RobosDoUser
from models.users import User
from schemas.requisicoes import RequisicaoCreate, Requisicao as RequisicaoSchema
from auth.dependencies import get_db, get_current_user

router = APIRouter(prefix="/requisicoes", tags=["Requisicoes"])

# ---------- POST: Criar nova requisição ----------
@router.post("/", response_model=RequisicaoSchema, status_code=status.HTTP_201_CREATED)
def criar_requisicao(
    requisicao: RequisicaoCreate, 
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if not requisicao.id_robo:
        raise HTTPException(status_code=400, detail="id_robo é obrigatório para criar a requisição com filtro.")

    # Buscar robôs ligados + ativos com o mesmo id_robo
    robos_filtrados = db.query(RobosDoUser).filter(
        RobosDoUser.id_robo == requisicao.id_robo,
        RobosDoUser.ligado == True,
        RobosDoUser.ativo == True
    ).all()

    # Extrair os IDs de contas dos robôs encontrados (caso existam)
    ids_contas = [robo.id_conta for robo in robos_filtrados if robo.id_conta is not None]

    if not ids_contas:
        raise HTTPException(status_code=400, detail="Nenhuma conta vinculada aos robôs filtrados.")

    # Atualizar os robôs para indicar que têm requisição
    for robo in robos_filtrados:
        robo.tem_requisicao = True

    # Criar e salvar a requisição
    nova_requisicao = Requisicao(
        tipo=requisicao.tipo,
        comentario_ordem=requisicao.comentario_ordem,
        symbol=requisicao.symbol,
        quantidade=requisicao.quantidade,
        preco=requisicao.preco,
        id_robo=requisicao.id_robo,
        ids_contas=ids_contas  # ✅ salva os IDs de contas
    )

    db.add(nova_requisicao)
    db.commit()
    db.refresh(nova_requisicao)

    return nova_requisicao

# ---------- GET: Listar todas as requisições ----------
@router.get("/", response_model=List[RequisicaoSchema])
def listar_requisicoes(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return db.query(Requisicao).all()
