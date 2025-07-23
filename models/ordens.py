from sqlalchemy import (Column, Integer, Text, ForeignKey, String, Numeric, DateTime)
from database import Base
from sqlalchemy.orm import relationship
from datetime import datetime

class Ordem(Base):
    __tablename__ = "ordens"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id"))
    id_user = Column(Integer, ForeignKey("users.id"))
    numero_unico = Column(String)
    quantidade = Column(Integer)
    preco = Column(Numeric)
    conta_meta_trader = Column(String, nullable=True)
    tipo = Column(String, nullable=True)
    criado_em = Column(DateTime, default=datetime.utcnow)

    # Especifique a FK para RobosDoUser
    robo_user = relationship(
        "RobosDoUser",
        back_populates="ordens",
        foreign_keys=[id_robo_user],     # <---
        lazy="joined"
    )

    user = relationship(
        "User",
        back_populates="ordens",
        lazy="joined"
    )