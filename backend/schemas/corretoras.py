from pydantic import BaseModel
from typing import Optional

class Corretora(BaseModel):
    id: int
    nome: str
    cnpj: Optional[str]
    telefone: Optional[str]
    email: Optional[str]

    class Config:
        orm_mode = True
