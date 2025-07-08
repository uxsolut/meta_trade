from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
import models as models
import schemas as schemas

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/", response_model=schemas.User)
def criar_user(item: schemas.UserCreate, db: Session = Depends(get_db)):
    novo_user = models.User(**item.dict(exclude_unset=True))
    db.add(novo_user)
    db.commit()
    db.refresh(novo_user)
    return novo_user

@router.post("/login", response_model=schemas.UserLoginResponse)
def login_user(item: schemas.UserLogin, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.email == item.email).first()
    if not user or user.senha != item.senha:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="E-mail ou senha incorretos."
        )
    return schemas.UserLoginResponse(
        id=user.id,
        nome=user.nome,
        email=user.email,
        cpf=user.cpf,
        id_corretora=user.id_corretora,
    )
