from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Conta(Base):
    __tablename__ = "contas"

    id = Column(Integer, primary_key=True, index=True)
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id", ondelete="CASCADE"))
    conta_meta_trader = Column(String, nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id", ondelete="SET NULL"))

    robo_user = relationship("RoboDoUser", backref="contas")  # ou robos_do_user, dependendo do nome da classe
    corretora = relationship("Corretora", backref="contas")
    users = relationship("User", backref="conta")  # usuários que usam essa conta
