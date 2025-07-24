from fastapi import APIRouter, Depends, HTTPException, Path
from sqlalchemy.orm import Session

from database import get_db
from auth.dependencies import get_current_user
from models.aplicacao import Aplicacao as AplicacaoModel
from schemas.aplicacao import Aplicacao, AplicacaoCreate
from models.users import User
from typing import Optional

router = APIRouter(prefix="/aplicacoes", tags=["Aplicacoes"])

# ---------- POST: Criar nova aplicação ----------
@router.post("/", response_model=Aplicacao)
def criar_aplicacao(
    aplicacao: AplicacaoCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    nova = AplicacaoModel(**aplicacao.dict())
    db.add(nova)
    db.commit()
    db.refresh(nova)
    return nova

# ---------- PUT: Atualizar campo id_versao_aplicacao ----------
@router.put("/{id}", response_model=Aplicacao)
def atualizar_aplicacao(
    id: int = Path(...),
    id_versao_aplicacao: Optional[int] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    app = db.query(AplicacaoModel).filter(AplicacaoModel.id == id).first()
    if not app:
        raise HTTPException(status_code=404, detail="Aplicação não encontrada")

    if id_versao_aplicacao is not None:
        app.id_versao_aplicacao = id_versao_aplicacao

    db.commit()
    db.refresh(app)
    return app
