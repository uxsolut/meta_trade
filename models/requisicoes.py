from sqlalchemy import (Column, Integer, String, Text, Numeric, ForeignKey, ARRAY, DateTime)
from database import Base
from sqlalchemy.orm import relationship
from datetime import datetime

class Requisicao(Base):
    __tablename__ = "requisicoes"

    id = Column(Integer, primary_key=True, index=True)
    tipo = Column(String, nullable=False)
    comentario_ordem = Column(Text, nullable=True)
    symbol = Column(String, nullable=True)
    quantidade = Column(Integer, nullable=True)
    preco = Column(Numeric(12, 2), nullable=True)

    id_robo = Column(Integer, ForeignKey("robos.id"), nullable=True)
    ids_contas = Column(ARRAY(Integer), nullable=True)  # array de ids, FK lógica

    criado_em = Column(DateTime, default=datetime.utcnow)

    # relacionamento (opcional)
    robo = relationship("Robos")