from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from auth.dependencies import get_current_user
from models.aplicacao import Aplicacao as AplicacaoModel
from schemas.aplicacao import Aplicacao, AplicacaoCreate
from models.users import User

router = APIRouter(prefix="/aplicacoes", tags=["Aplicacoes"])

# ---------- POST: Criar nova aplicação ----------
@router.post("/", response_model=Aplicacao)
def criar_aplicacao(
    aplicacao: AplicacaoCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    nova = AplicacaoModel(**aplicacao.dict())
    db.add(nova)
    db.commit()
    db.refresh(nova)
    return nova
