from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Carteira(Base):
    __tablename__ = "carteiras"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    id_user = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    id_conta = Column(Integer, ForeignKey("contas.id", ondelete="SET NULL"), nullable=True)

    user = relationship("User", back_populates="carteiras")
    conta = relationship("Conta", back_populates="carteiras")
