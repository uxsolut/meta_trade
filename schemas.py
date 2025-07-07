from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime  # ✅ import necessário

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
    conta_meta_trader: Optional[str] = None
    tipo: Optional[str] = None

class Ordem(BaseModel):
    id: int
    comentario_ordem: str
    id_robo_user: Optional[int] = None
    id_user: Optional[int] = None
    numero_unico: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None
    conta_meta_trader: Optional[str] = None
    tipo: Optional[str] = None
    criado_em: Optional[str] = None

    class Config:
        from_attributes = True


# -------------------
# ROBOS
# -------------------

class RobosBase(BaseModel):
    nome: str
    symbol: str

class RobosCreate(RobosBase):
    pass

class Robos(BaseModel):
    id: int
    nome: str
    symbol: str

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
    ligado: Optional[bool] = False
    ativo: Optional[bool] = False
    tem_requisicao: Optional[bool] = False
    id_ordem: Optional[int] = None
    id_carteira: Optional[int] = None
    id_corretora: Optional[int] = None

class RoboDoUser(BaseModel):
    id: int
    id_user: int
    id_robo: int
    ligado: Optional[bool] = False
    ativo: Optional[bool] = False
    tem_requisicao: Optional[bool] = False
    id_ordem: Optional[int] = None
    id_carteira: Optional[int] = None
    id_corretora: Optional[int] = None

    class Config:
        from_attributes = True


# -------------------
# REQUISICOES
# -------------------

class RequisicaoCreate(BaseModel):
    tipo: str
    comentario_ordem: Optional[str] = None
    symbol: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None
    id_robo: Optional[int] = None
    ids_robo_user: Optional[List[int]] = None

class Requisicao(BaseModel):
    id: int
    tipo: str
    comentario_ordem: Optional[str] = None
    symbol: Optional[str] = None
    quantidade: Optional[int] = None
    preco: Optional[float] = None
    id_robo: Optional[int] = None
    ids_robo_user: Optional[List[int]] = None
    criado_em: Optional[datetime] = None  # ✅ ALTERADO PARA datetime

    class Config:
        orm_mode = True  # ✅ NECESSÁRIO PARA DATETIME FUNCIONAR
