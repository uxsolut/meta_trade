from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from jose import jwt
from datetime import datetime, timedelta

from database import get_db
import models as models
import schemas as schemas

router = APIRouter(prefix="/users", tags=["Users"])

# Configurações para JWT
SECRET_KEY = "pMXgaxwiXB3UDd32oJepjMp6Yyfb6qCUgqnwY46ihd3f9JdrkRm4Cx7YtVJ4y2Ba"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24  # 24 horas

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# ---------- CRIAR USUÁRIO (com hash de senha) ----------
@router.post("/", response_model=schemas.User)
def criar_user(item: schemas.UserCreate, db: Session = Depends(get_db)):
    if db.query(models.User).filter(models.User.email == item.email).first():
        raise HTTPException(status_code=400, detail="E-mail já cadastrado.")
    hashed_password = get_password_hash(item.senha)
    novo_user = models.User(
        nome=item.nome,
        email=item.email,
        senha=hashed_password,
        cpf=item.cpf,
        id_corretora=item.id_corretora,
    )
    db.add(novo_user)
    db.commit()
    db.refresh(novo_user)
    return novo_user

# ---------- LOGIN (com JWT) ----------
@router.post("/login", response_model=dict)
def login_user(item: schemas.UserLogin, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.email == item.email).first()
    if not user or not verify_password(item.senha, user.senha):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="E-mail ou senha incorretos."
        )
    # Gera o token JWT
    access_token = create_access_token(data={"sub": str(user.id)})
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": {
            "id": user.id,
            "nome": user.nome,
            "email": user.email,
            "cpf": user.cpf,
            "id_corretora": user.id_corretora,
        }
    }
