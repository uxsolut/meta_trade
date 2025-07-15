from pydantic import BaseModel

class CarteiraBase(BaseModel):
    nome: str

class CarteiraCreate(CarteiraBase):
    """
    Apenas o nome vem no corpo do POST.
    """

class Carteira(CarteiraBase):
    id: int
    id_user: int

    class Config:
        orm_mode = True
