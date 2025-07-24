from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class VersaoAplicacaoBase(BaseModel):
    descricao: str

class VersaoAplicacaoCreate(VersaoAplicacaoBase):
    pass  # upload de arquivo será via `UploadFile`

class VersaoAplicacao(VersaoAplicacaoBase):
    id: int
    data_versao: Optional[datetime]
    criado_em: Optional[datetime]
    id_user: int

    class Config:
        from_attributes = True
