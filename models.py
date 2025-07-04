from sqlalchemy import Column, Integer, Text, String, LargeBinary, DateTime, ForeignKey, Numeric
from datetime import datetime
from database import Base

class Ordem(Base):
    __tablename__ = "ordem"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    id_robo = Column(Integer, ForeignKey("robos.id"))  # substitui numero_magico
    numero_unico = Column(String)
    quantidade = Column(Integer)
    preco = Column(Numeric)
    
class Robos(Base):
    __tablename__ = "robos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    numero_magico = Column(Integer)  # novo campo adicionado
    arquivo = Column(LargeBinary, nullable=False)
    criado_em = Column(DateTime, default=datetime.utcnow)
