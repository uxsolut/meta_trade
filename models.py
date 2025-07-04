from sqlalchemy import Column, Integer, Text, String, LargeBinary, DateTime, ForeignKey, Numeric
from datetime import datetime
from database import Base

class Ordem(Base):
    __tablename__ = "ordens"  # nome da tabela atualizado

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id"))  # FK atualizada
    id_user = Column(Integer, ForeignKey("users.id"))               # novo campo
    numero_unico = Column(String)
    quantidade = Column(Integer)
    preco = Column(Numeric)

class Robos(Base):
    __tablename__ = "robos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    numero_magico = Column(Integer)
    arquivo = Column(LargeBinary, nullable=False)
    criado_em = Column(DateTime, default=datetime.utcnow)
