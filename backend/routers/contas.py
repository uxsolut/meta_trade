from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models.contas import Conta as ContaModel
from schemas.contas import Conta, ContaCreate
from typing import List
from models.users import User
from auth.dependencies import get_db, get_current_user

router = APIRouter(prefix="/contas", tags=["Contas"])

@router.post("/", response_model=Conta)
def criar_conta(
    conta: ContaCreate, 
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    nova = ContaModel(**conta.dict())
    db.add(nova)
    db.commit()
    db.refresh(nova)
    return nova

@router.get("/", response_model=List[Conta])
def listar_contas(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return db.query(ContaModel).all()

@router.delete("/{conta_id}")
def deletar_conta(
    conta_id: int, 
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    conta = db.query(ContaModel).filter(ContaModel.id == conta_id).first()
    if not conta:
        raise HTTPException(status_code=404, detail="Conta não encontrada")
    db.delete(conta)
    db.commit()
    return {"mensagem": "Conta deletada com sucesso"}
