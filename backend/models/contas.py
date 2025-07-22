from sqlalchemy import Column, Integer, String, ForeignKey, Numeric
from sqlalchemy.orm import relationship
from database import Base

class Conta(Base):
    __tablename__ = "contas"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=True)
    conta_meta_trader = Column(String, nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id", ondelete="SET NULL"))
    id_carteira = Column(Integer, ForeignKey("carteiras.id", ondelete="SET NULL"))

    margem_total = Column(Numeric, nullable=True)
    margem_disponivel = Column(Numeric, nullable=True)

    corretora = relationship("Corretora", back_populates="contas")
    carteira = relationship("Carteira", back_populates="contas")
    users = relationship("User", backref="conta")
