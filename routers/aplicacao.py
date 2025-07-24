from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from auth.dependencies import get_current_user
from models.aplicacao import Aplicacao as AplicacaoModel
from schemas.aplicacao import Aplicacao, AplicacaoCreate
from models.users import User

router = APIRouter(prefix="/aplicacoes", tags=["Aplicacoes"])

# ---------- GET: Listar todas as aplicações ----------
@router.get("/", response_model=List[Aplicacao])
def listar_aplicacoes(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return db.query(AplicacaoModel).all()

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

# ---------- GET: Buscar por ID ----------
@router.get("/{id}", response_model=Aplicacao)
def obter_aplicacao(
    id: int = Path(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    app = db.query(AplicacaoModel).filter(AplicacaoModel.id == id).first()
    if not app:
        raise HTTPException(status_code=404, detail="Aplicação não encontrada")
    return app

# ---------- DELETE: Remover aplicação ----------
@router.delete("/{id}", status_code=204)
def deletar_aplicacao(
    id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    app = db.query(AplicacaoModel).filter(AplicacaoModel.id == id).first()
    if not app:
        raise HTTPException(status_code=404, detail="Aplicação não encontrada")
    db.delete(app)
    db.commit()
