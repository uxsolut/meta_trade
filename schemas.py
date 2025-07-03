# schemas.py
from pydantic import BaseModel

class MercadoFinanceiroCreate(BaseModel):
    comentario_ordem: str
    numero_magico: int | None = None

class MercadoFinanceiro(BaseModel):
    id: int
    comentario_ordem: str
    numero_magico: int | None = None

    class Config:
        from_attributes = True
