from pydantic import BaseModel

class CarteiraCreate(BaseModel):
    nome: str

class CarteiraResponse(BaseModel):
    id: int
    nome: str
    id_user: int

    class Config:
        from_attributes = True  
