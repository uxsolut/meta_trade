from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
from models.carteira import Carteira
from models.users import User
from schemas.carteiras import CarteiraResponse, CarteiraCreate
from auth.dependencies import get_current_user

router = APIRouter()

# ---------- GET: Listar carteiras do usuário ----------
@router.get("/carteiras/", response_model=list[CarteiraResponse])
def listar_carteiras(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user)
):
    carteiras = db.query(Carteira).filter(Carteira.id_user == user.id).all()
    return carteiras

# ---------- POST: Criar carteira ----------
@router.post("/carteiras/", response_model=CarteiraResponse, status_code=status.HTTP_201_CREATED)
def criar_carteira(
    dados: CarteiraCreate,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user)
):
    nova_carteira = Carteira(
        nome=dados.nome,
        id_user=user.id
    )
    db.add(nova_carteira)
    db.commit()
    db.refresh(nova_carteira)
    return nova_carteira
