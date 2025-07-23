from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.corretoras import Corretora as CorretoraModel
from schemas.corretoras import Corretora, CorretoraCreate

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
