from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
import models
import schemas

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/", response_model=schemas.User)
def criar_user(item: schemas.UserCreate, db: Session = Depends(get_db)):
    novo_user = models.User(**item.dict(exclude_unset=True))
    db.add(novo_user)
    db.commit()
    db.refresh(novo_user)
    return novo_user
