from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
from models import Requisicao
from schemas import RequisicaoCreate, Requisicao

router = APIRouter(prefix="/requisicoes", tags=["Requisicoes"])

@router.post("/", response_model=Requisicao, status_code=status.HTTP_201_CREATED)
def criar_requisicao(requisicao: RequisicaoCreate, db: Session = Depends(get_db)):
    nova_requisicao = Requisicao(
        tipo=requisicao.tipo,
        comentario_ordem=requisicao.comentario_ordem,
        symbol=requisicao.symbol,
        quantidade=requisicao.quantidade,
        preco=requisicao.preco,
        id_robo=requisicao.id_robo,
        ids_robo_user=requisicao.ids_robo_user
    )
    db.add(nova_requisicao)
    db.commit()
    db.refresh(nova_requisicao)
    return nova_requisicao
