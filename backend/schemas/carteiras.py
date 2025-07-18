from typing import Optional, List
from pydantic import BaseModel

class CarteiraBase(BaseModel):
    nome: str
    ids_contas: Optional[List[int]] = None

class CarteiraCreate(CarteiraBase):
    pass

class Carteira(CarteiraBase):
    id: int
    id_user: int

    class Config:
        orm_mode = True
