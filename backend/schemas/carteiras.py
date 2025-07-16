from pydantic import BaseModel
from typing import Optional
from schemas.contas import Conta  # ⚠️ precisa existir schemas/contas.py com campo 'nome'

class CarteiraBase(BaseModel):
    nome: str
    id_conta: Optional[int] = None

class CarteiraCreate(CarteiraBase):
    """
    Apenas nome e id_conta vêm no corpo do POST.
    """
    pass

class Carteira(CarteiraBase):
    id: int
    id_user: int
    conta: Optional[Conta]  # 👈 conta vinculada (vai permitir acessar nome da conta)

    class Config:
        orm_mode = True
