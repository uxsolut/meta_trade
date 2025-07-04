from pydantic import BaseModel
from typing import Optional

# -------------------
# ORDEM (antigo MercadoFinanceiro)
# -------------------

class OrdemCreate(BaseModel):
    comentario_ordem: str
    id_robo: Optional[int] = None
    numero_unico: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None

class Ordem(BaseModel):
    id: int
    comentario_ordem: str
    id_robo: Optional[int] = None
    numero_unico: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None

    class Config:
        from_attributes = True

# -------------------
# ROBOS
# -------------------

class RobosBase(BaseModel):
    nome: str
    symbol: str
    numero_magico: Optional[int] = None

class RobosCreate(RobosBase):
    pass  # 'arquivo' continua sendo enviado como UploadFile, fora do schema

class Robos(BaseModel):
    id: int
    nome: str
    symbol: str
    numero_magico: Optional[int] = None

    class Config:
        from_attributes = True
