from sqlalchemy import Column, Integer, Text, String, LargeBinary, DateTime, ForeignKey, Numeric
from sqlalchemy.orm import relationship
from datetime import datetime
from database import Base

# -------------------
# ORDENS
# -------------------

class Ordem(Base):
    __tablename__ = "ordens"

    id = Column(Integer, primary_key=True, index=True)
    comentario_ordem = Column(Text, nullable=False)
    id_robo_user = Column(Integer, ForeignKey("robos_do_user.id"))
    id_user = Column(Integer, ForeignKey("users.id"))
    numero_unico = Column(String)
    quantidade = Column(Integer)
    preco = Column(Numeric)

    # relacionamentos (opcional, mas útil)
    robo_user = relationship("RobosDoUser", back_populates="ordens", lazy="joined")
    user = relationship("User", back_populates="ordens", lazy="joined")


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

    # relacionamento reverso (opcional)
    robos_do_user = relationship("RobosDoUser", back_populates="robo")


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

    # relacionamentos (opcional)
    ordens = relationship("Ordem", back_populates="user")
    robos_do_user = relationship("RobosDoUser", back_populates="user")


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

    # relacionamentos (opcional)
    user = relationship("User", back_populates="robos_do_user")
    robo = relationship("Robos", back_populates="robos_do_user")
    ordens = relationship("Ordem", back_populates="robo_user")


# -------------------
# CORRETORAS
# -------------------

class Corretora(Base):
    __tablename__ = "corretoras"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    cnpj = Column(String, nullable=True)
    telefone = Column(String, nullable=True)
    email = Column(String, nullable=True)

    # relacionamento reverso (opcional)
    users = relationship("User", backref="corretora")
