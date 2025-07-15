# backend/models/users.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    senha = Column(String, nullable=False)
    cpf = Column(String, nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id"), nullable=True)

    # Relações existentes
    ordens = relationship("Ordem", back_populates="user")
    robos_do_user = relationship("RobosDoUser", back_populates="user")
    corretora = relationship("Corretora", back_populates="users")

    # Nova relação com carteiras
    carteiras = relationship(
        "Carteira",
        back_populates="user",
        cascade="all, delete-orphan"
    )
