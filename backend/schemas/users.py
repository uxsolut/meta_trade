from pydantic import BaseModel, EmailStr
from typing import Optional

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

class UserLogin(BaseModel):
    email: EmailStr
    senha: str