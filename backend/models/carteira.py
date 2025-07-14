from sqlalchemy import Column, Integer, Text, ForeignKey
from database import Base
from sqlalchemy.orm import relationship

class Carteira(Base):
    __tablename__ = "carteiras"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(Text, nullable=False)
    id_user = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)

    user = relationship("User", backref="carteiras")
