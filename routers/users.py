from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import Users
import schemas

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/", response_model=schemas.User)
def criar_user(item: schemas.UserCreate, db: Session = Depends(get_db)):
    novo_user = Users(**item.dict())
    db.add(novo_user)
    db.commit()
    db.refresh(novo_user)
    return novo_user
