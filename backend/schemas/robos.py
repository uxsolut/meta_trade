from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

class RobosBase(BaseModel):
    nome: str
    symbol: str
    performance: Optional[List[str]] = None

class RobosCreate(RobosBase):
    arquivo: bytes  
    arquivo_user: bytes  

class Robos(RobosBase):
    id: int
    criado_em: Optional[datetime] = None
    arquivo: bytes
    arquivo_user: bytes

    class Config:
        from_attributes = True
