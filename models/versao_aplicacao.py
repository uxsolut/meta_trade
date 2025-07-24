from sqlalchemy import Column, Integer, Text, LargeBinary, DateTime, ForeignKey, func
from database import Base

class VersaoAplicacao(Base):
    __tablename__ = "versao_aplicacao"

    id = Column(Integer, primary_key=True, index=True)
    descricao = Column(Text, nullable=False)
    arquivo = Column(LargeBinary)
    data_versao = Column(DateTime, server_default=func.current_timestamp())
    id_user = Column(Integer, ForeignKey("users.id"), nullable=False)
    criado_em = Column(DateTime, server_default=func.current_timestamp())
