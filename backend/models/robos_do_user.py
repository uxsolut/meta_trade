from sqlalchemy import (Column, Integer, ForeignKey, LargeBinary, Boolean)
from database import Base
from sqlalchemy.orm import relationship

class RobosDoUser(Base):
    __tablename__ = "robos_do_user"

    id = Column(Integer, primary_key=True, index=True)
    id_user = Column(Integer, ForeignKey("users.id"), nullable=False)
    id_robo = Column(Integer, ForeignKey("robos.id"), nullable=False)
    arquivo_cliente = Column(LargeBinary, nullable=True)

    ligado = Column(Boolean, default=False)
    ativo = Column(Boolean, default=False)
    tem_requisicao = Column(Boolean, default=False)

    id_ordem = Column(Integer, ForeignKey("ordens.id"), nullable=True)
    id_carteira = Column(Integer, ForeignKey("carteiras.id"), nullable=True)
    id_conta = Column(Integer, ForeignKey("contas.id"), nullable=True)

    user = relationship("User", back_populates="robos_do_user")
    robo = relationship("Robos", back_populates="robos_do_user")
    
    conta = relationship(
    "Conta",
    back_populates="robo_user",
    foreign_keys=[id_conta]  # ⬅️ ESSENCIAL para resolver a ambiguidade
)

    # Especifique a FK para Ordens
    ordens = relationship(
        "Ordem",
        back_populates="robo_user",
        foreign_keys="[Ordem.id_robo_user]"     # <---
    )