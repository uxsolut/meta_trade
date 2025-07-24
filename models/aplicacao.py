from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from database import Base

class Aplicacao(Base):
    __tablename__ = "aplicacao"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String(255), nullable=False)
    tipo = Column(String, nullable=False)
    id_versao_aplicacao = Column(Integer, ForeignKey("versao_aplicacao.id"), nullable=False)
    criado_em = Column(DateTime, server_default=func.current_timestamp())
    atualizado_em = Column(DateTime, server_default=func.current_timestamp(), onupdate=func.current_timestamp())
