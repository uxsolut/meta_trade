from pydantic import BaseModel, EmailStr
from typing import Optional

# -------------------
# ORDEM (tabela: ordens)
# -------------------

class OrdemCreate(BaseModel):
    comentario_ordem: str
    id_robo_user: Optional[int] = None
    id_user: Optional[int] = None
    numero_unico: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None

class Ordem(BaseModel):
    id: int
    comentario_ordem: str
    id_robo_user: Optional[int] = None
    id_user: Optional[int] = None
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

# -------------------
# USERS
# -------------------

class UserCreate(BaseModel):
    nome: str
    email: EmailStr
    senha: str
    cpf: Optional[str] = None
    id_corretora: Optional[int] = None

class User(BaseModel):
    id: int
    nome: str
    email: EmailStr
    cpf: Optional[str] = None
    id_corretora: Optional[int] = None

    class Config:
        from_attributes = True

# -------------------
# ROBOS_DO_USER
# -------------------

class RoboDoUserCreate(BaseModel):
    id_user: int
    id_robo: int
    id_resultados: Optional[int] = None
    # O campo `arquivo_cliente` será enviado como UploadFile, não vai no schema diretamente

class RoboDoUser(BaseModel):
    id: int
    id_user: int
    id_robo: int
    id_resultados: Optional[int] = None

    class Config:
        from_attributes = True
