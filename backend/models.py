from sqlalchemy import (
    Column,
    Integer,
    Text,
    String,
    LargeBinary,
    DateTime,
    ForeignKey,
    Numeric,
    Boolean,
    Table,
    ARRAY,
)
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
    conta_meta_trader = Column(String, nullable=True)
    tipo = Column(String, nullable=True)
    criado_em = Column(DateTime, default=datetime.utcnow)

    # Especifique a FK para RobosDoUser
    robo_user = relationship(
        "RobosDoUser",
        back_populates="ordens",
        foreign_keys=[id_robo_user],     # <---
        lazy="joined"
    )

    user = relationship(
        "User",
        back_populates="ordens",
        lazy="joined"
    )


# -------------------
# ROBOS
# -------------------

class Robos(Base):
    __tablename__ = "robos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    symbol = Column(String, nullable=False)
    arquivo = Column(LargeBinary, nullable=False)
    criado_em = Column(DateTime, default=datetime.utcnow)

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
    arquivo_cliente = Column(LargeBinary, nullable=True)

    ligado = Column(Boolean, default=False)
    ativo = Column(Boolean, default=False)
    tem_requisicao = Column(Boolean, default=False)

    id_ordem = Column(Integer, ForeignKey("ordens.id"), nullable=True)
    id_carteira = Column(Integer, ForeignKey("carteiras.id"), nullable=True)
    id_corretora = Column(Integer, ForeignKey("corretoras.id"), nullable=True)

    user = relationship("User", back_populates="robos_do_user")
    robo = relationship("Robos", back_populates="robos_do_user")

    # Especifique a FK para Ordens
    ordens = relationship(
        "Ordem",
        back_populates="robo_user",
        foreign_keys="[Ordem.id_robo_user]"     # <---
    )


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

    users = relationship("User", backref="corretora")


# -------------------
# REQUISICOES
# -------------------

class Requisicao(Base):
    __tablename__ = "requisicoes"

    id = Column(Integer, primary_key=True, index=True)
    tipo = Column(String, nullable=False)
    comentario_ordem = Column(Text, nullable=True)
    symbol = Column(String, nullable=True)
    quantidade = Column(Integer, nullable=True)
    preco = Column(Numeric(12, 2), nullable=True)

    id_robo = Column(Integer, ForeignKey("robos.id"), nullable=True)
    ids_robo_user = Column(ARRAY(Integer), nullable=True)  # array de ids, FK lógica

    criado_em = Column(DateTime, default=datetime.utcnow)

    # relacionamento (opcional)
    robo = relationship("Robos")


# -------------------
# CARTEIRA (básico)
# -------------------

class Carteira(Base):
    __tablename__ = "carteiras"
    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String, nullable=False)
    id_user = Column(Integer, ForeignKey("users.id"), nullable=False)
