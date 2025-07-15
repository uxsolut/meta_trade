from pydantic import BaseModel
from typing import Optional

class ContaBase(BaseModel):
    id_robo_user: int
    conta_meta_trader: Optional[str] = None
    id_corretora: Optional[int] = None

class ContaCreate(ContaBase):
    pass

class Conta(ContaBase):
    id: int

    class Config:
        orm_mode = True
