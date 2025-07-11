from sqlalchemy import (Column, Integer, String)
from database import Base
from sqlalchemy.orm import relationship

class Corretora(Base):
    __tablename__ = "corretoras"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    cnpj = Column(String, nullable=True)
    telefone = Column(String, nullable=True)
    email = Column(String, nullable=True)

    users = relationship("User", backref="corretora")