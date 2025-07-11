from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Carteira, User
from schemas.carteiras import CarteiraResponse
from auth.dependencies import get_current_user

router = APIRouter()

@router.get("/carteiras/", response_model=list[CarteiraResponse])
def listar_carteiras(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user)
):
    carteiras = db.query(Carteira).filter(Carteira.id_user == user.id).all()
    return carteiras
