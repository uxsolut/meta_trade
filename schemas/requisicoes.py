from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

class RequisicaoCreate(BaseModel):
    tipo: str
    comentario_ordem: Optional[str] = None
    symbol: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None
    id_robo: Optional[int] = None
    ids_contas: Optional[List[int]] = None  

class Requisicao(BaseModel):
    id: int
    tipo: str
    comentario_ordem: Optional[str] = None
    symbol: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None
    id_robo: Optional[int] = None
    ids_contas: Optional[List[int]] = None  
    criado_em: Optional[datetime] = None

    class Config:
        from_attributes = True
