from typing import Optional
from pydantic import BaseModel
from .contas import Conta  # se for usado

class Carteira(BaseModel):
    id: int
    nome: str
    id_user: int
    id_conta: Optional[int]  # <- ESSENCIAL
    conta: Optional[Conta]   # <- se você retorna a conta aninhada

    class Config:
        orm_mode = True
