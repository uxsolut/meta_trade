from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Conta(Base):
    __tablename__ = "contas"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=True)  # Novo campo que você adicionou no banco
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id", ondelete="CASCADE"))
    conta_meta_trader = Column(String, nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id", ondelete="SET NULL"))

    corretora = relationship("Corretora", back_populates="contas")
    users = relationship("User", backref="conta")
    carteiras = relationship("Carteira", back_populates="conta")

    robo_user = relationship(
      "RobosDoUser",
      back_populates="conta",  # deve bater com o nome no outro lado
      foreign_keys="[RobosDoUser.id_conta]"  # define explicitamente a FK
    )
