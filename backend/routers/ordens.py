from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from models.ordens import Ordem
from schemas.ordens import OrdemCreate, Ordem as OrdemSchema
from database import get_db

router = APIRouter(prefix="/ordens", tags=["Ordem"])

@router.post("/", response_model=OrdemSchema)
def criar_ordem(
    item: OrdemCreate,
    db: Session = Depends(get_db)
):
    nova_ordem = Ordem(**item.dict(exclude_unset=True))
    db.add(nova_ordem)
    db.commit()
    db.refresh(nova_ordem)
    return nova_ordem
