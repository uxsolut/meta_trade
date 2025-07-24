from pydantic import BaseModel
from datetime import datetime
from typing import Optional

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
