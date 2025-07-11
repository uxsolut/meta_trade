from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
from models.requisicoes import Requisicao
from models.robos_do_user import RobosDoUser
from schemas.requisicoes import RequisicaoCreate, Requisicao as RequisicaoSchema

router = APIRouter(prefix="/requisicoes", tags=["Requisicoes"])

@router.post("/", response_model=RequisicaoSchema, status_code=status.HTTP_201_CREATED)
def criar_requisicao(requisicao: RequisicaoCreate, db: Session = Depends(get_db)):
    if not requisicao.id_robo:
        raise HTTPException(status_code=400, detail="id_robo é obrigatório para criar a requisição com filtro.")

    # Buscar robôs válidos com id_robo igual e ligados + ativos
    robos_filtrados = db.query(RobosDoUser).filter(
        RobosDoUser.id_robo == requisicao.id_robo,
        RobosDoUser.ligado == True,
        RobosDoUser.ativo == True
    ).all()

    # Extrair os IDs dos robôs que se qualificam
    ids_robo_user = [robo.id for robo in robos_filtrados]

    # Atualizar o campo tem_requisicao para True nesses robôs
    for robo in robos_filtrados:
        robo.tem_requisicao = True

    # Criar a nova requisição
    nova_requisicao = Requisicao(
        tipo=requisicao.tipo,
        comentario_ordem=requisicao.comentario_ordem,
        symbol=requisicao.symbol,
        quantidade=requisicao.quantidade,
        preco=requisicao.preco,
        id_robo=requisicao.id_robo,
        ids_robo_user=ids_robo_user
    )

    db.add(nova_requisicao)
    db.commit()
    db.refresh(nova_requisicao)

    return nova_requisicao
