from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
import models
import schemas
from database import get_db

router = APIRouter(prefix="/ordens", tags=["Ordem"])

@router.post("/", response_model=schemas.Ordem)
def criar_ordem(
    item: schemas.OrdemCreate,
    db: Session = Depends(get_db)
):
    # `exclude_unset=True` garante que apenas os campos enviados no payload sejam usados
    nova_ordem = models.Ordem(**item.dict(exclude_unset=True))
    db.add(nova_ordem)
    db.commit()
    db.refresh(nova_ordem)
    return nova_ordem
