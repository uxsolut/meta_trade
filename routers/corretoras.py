from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.corretoras import Corretora as CorretoraModel
from schemas.corretoras import Corretora, CorretoraCreate, CorretoraUpdate

router = APIRouter(prefix="/corretoras", tags=["Corretoras"])

# ---------- GET: Listar todas as corretoras ----------
@router.get("/", response_model=List[Corretora])
def listar_corretoras(db: Session = Depends(get_db)):
    return db.query(CorretoraModel).all()

# ---------- POST: Criar nova corretora ----------
@router.post("/", response_model=Corretora)
def criar_corretora(
    corretora: CorretoraCreate,
    db: Session = Depends(get_db)
):
    nova = CorretoraModel(**corretora.dict())
    db.add(nova)
    db.commit()
    db.refresh(nova)
    return nova

# ---------- PUT: Atualizar corretora existente ----------
@router.put("/{corretora_id}", response_model=Corretora)
def atualizar_corretora(
    corretora_id: int,
    corretora_update: CorretoraUpdate,
    db: Session = Depends(get_db)
):
    corretora = db.query(CorretoraModel).filter(CorretoraModel.id == corretora_id).first()
    if not corretora:
        raise HTTPException(status_code=404, detail="Corretora não encontrada")

    for attr, value in corretora_update.dict(exclude_unset=True).items():
        setattr(corretora, attr, value)

    db.commit()
    db.refresh(corretora)
    return corretora

# ---------- DELETE: Excluir corretora ----------
@router.delete("/{corretora_id}")
def deletar_corretora(corretora_id: int, db: Session = Depends(get_db)):
    corretora = db.query(CorretoraModel).filter(CorretoraModel.id == corretora_id).first()
    if not corretora:
        raise HTTPException(status_code=404, detail="Corretora não encontrada")

    db.delete(corretora)
    db.commit()
    return {"detail": "Corretora deletada com sucesso"}
