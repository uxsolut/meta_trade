from sqlalchemy import Column, Integer, String, LargeBinary, DateTime, ARRAY
from database import Base
from sqlalchemy.orm import relationship
from datetime import datetime

class Robos(Base):
    __tablename__ = "robos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    arquivo = Column(LargeBinary, nullable=False)
    criado_em = Column(DateTime, default=datetime.utcnow)
    performance = Column(ARRAY(String))

    robos_do_user = relationship("RobosDoUser", back_populates="robo")
