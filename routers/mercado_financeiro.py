# routers/mercado_financeiro.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
import models
import schemas
from database import get_db

router = APIRouter(prefix="/mercado_financeiro", tags=["Mercado Financeiro"])

@router.post("/", response_model=schemas.MercadoFinanceiro)
def criar_mercado_financeiro(
    item: schemas.MercadoFinanceiroCreate,
    db: Session = Depends(get_db)
):
    novo_item = models.MercadoFinanceiro(**item.dict())
    db.add(novo_item)
    db.commit()
    db.refresh(novo_item)
    return novo_item
