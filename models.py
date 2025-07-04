from sqlalchemy import Column, Integer, Text, String, LargeBinary, DateTime, ForeignKey, Numeric
from datetime import datetime
from database import Base

# -------------------
# ORDENS
# -------------------

class Ordem(Base):
    __tablename__ = "ordens"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id"))  # FK atualizada
    id_user = Column(Integer, ForeignKey("users.id"))               # novo campo
    numero_unico = Column(String)
    quantidade = Column(Integer)
    preco = Column(Numeric)

# -------------------
# ROBOS
# -------------------

class Robos(Base):
    __tablename__ = "robos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    numero_magico = Column(Integer)
    arquivo = Column(LargeBinary, nullable=False)
    criado_em = Column(DateTime, default=datetime.utcnow)

# -------------------
# USERS
# -------------------

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    senha = Column(String, nullable=False)
    cpf = Column(String, nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id"), nullable=True)

# -------------------
# ROBOS_DO_USER
# -------------------

class RobosDoUser(Base):
    __tablename__ = "robos_do_user"

    id = Column(Integer, primary_key=True, index=True)
    id_user = Column(Integer, ForeignKey("users.id"), nullable=False)
    id_robo = Column(Integer, ForeignKey("robos.id"), nullable=False)
    id_resultados = Column(Integer, ForeignKey("resultados.id"), nullable=True)
    arquivo_cliente = Column(LargeBinary, nullable=True)
