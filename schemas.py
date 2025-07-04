# schemas.py
from pydantic import BaseModel

class MercadoFinanceiroCreate(BaseModel):
    comentario_ordem: str
    numero_magico: int | None = None

class MercadoFinanceiro(BaseModel):
    id: int
    comentario_ordem: str
    numero_magico: int | None = None

    class Config:
        from_attributes = True

class RoboBase(BaseModel):
    nome: str
    symbol: str

class RoboCreate(RoboBase):
    pass  # o campo 'arquivo' será enviado como UploadFile via rota (não incluído no schema diretamente)

class Robo(BaseModel):
    id: int
    nome: str
    symbol: str

    class Config:
        from_attributes = True