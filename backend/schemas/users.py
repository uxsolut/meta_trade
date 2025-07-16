from pydantic import BaseModel, EmailStr
from typing import Optional

class UserCreate(BaseModel):
    nome: str
    email: EmailStr
    senha: str
    cpf: Optional[str] = None
    id_conta: Optional[int] = None
    tipo_de_user: Optional[str] = None  # Novo campo

class User(BaseModel):
    id: int
    nome: str
    email: EmailStr
    cpf: Optional[str] = None
    id_conta: Optional[int] = None
    tipo_de_user: Optional[str] = None  # Novo campo

    class Config:
        from_attributes = True

class UserLogin(BaseModel):
    email: EmailStr
    senha: str
