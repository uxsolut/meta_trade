from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class AplicacaoBase(BaseModel):
    nome: str
    tipo: str
    id_versao_aplicacao: int

class AplicacaoCreate(AplicacaoBase):
    pass

class Aplicacao(AplicacaoBase):
    id: int
    criado_em: Optional[datetime]
    atualizado_em: Optional[datetime]

    class Config:
        from_attributes = True
