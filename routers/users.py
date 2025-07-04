from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import User
import schemas

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/", response_model=schemas.User)
def criar_user(item: schemas.UserCreate, db: Session = Depends(get_db)):
    novo_user = User(**item.dict())  # <- corrigido aqui
    db.add(novo_user)
    db.commit()
    db.refresh(novo_user)
    return novo_user
