# models.py
from sqlalchemy import Column, Integer, Text
from database import Base

class MercadoFinanceiro(Base):
    __tablename__ = "mercado_financeiro"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    numero_magico = Column(Integer)
