from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import relationship
from database import Base

class Carteira(Base):
    __tablename__ = "carteiras"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    id_user = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)

    ids_contas = Column(ARRAY(Integer), nullable=True)  # ✅ nova lista de contas vinculadas

    user = relationship("User", back_populates="carteiras")
