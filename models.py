#models.py
from sqlalchemy import Column, Integer, Text, String, LargeBinary, DateTime
from datetime import datetime
from database import Base

class MercadoFinanceiro(Base):
    __tablename__ = "mercado_financeiro"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    numero_magico = Column(Integer)

class Robo(Base):
    __tablename__ = "robo"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    arquivo = Column(LargeBinary, nullable=False)  # <- BYTEA no PostgreSQL
    criado_em = Column(DateTime, default=datetime.utcnow)
