from typing import Optional
from pydantic import BaseModel
from schemas.contas import Conta  # Ajuste o caminho conforme seu projeto

class CarteiraBase(BaseModel):
    nome: str
    id_conta: Optional[int] = None  # <- Aceita nulo

class CarteiraCreate(CarteiraBase):
    pass

class Carteira(CarteiraBase):
    id: int
    id_user: int
    conta: Optional[Conta] = None  # <- Objeto completo pode ser nulo

    class Config:
        orm_mode = True
