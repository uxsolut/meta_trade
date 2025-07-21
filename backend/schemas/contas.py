from pydantic import BaseModel
from typing import Optional

class ContaBase(BaseModel):
    conta_meta_trader: Optional[str] = None
    id_corretora: Optional[int] = None
    nome: Optional[str] = None  # 👈 novo campo para exibir o nome da conta

class ContaCreate(ContaBase):
    pass

class Conta(ContaBase):
    id: int

    class Config:
        orm_mode = True
