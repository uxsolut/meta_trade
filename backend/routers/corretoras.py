from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.corretoras import Corretora as CorretoraModel
from schemas.corretoras import Corretora

router = APIRouter(prefix="/corretoras", tags=["Corretoras"])

@router.get("/", response_model=List[Corretora])
def listar_corretoras(db: Session = Depends(get_db)):
    return db.query(CorretoraModel).all()
