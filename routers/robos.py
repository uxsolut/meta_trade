from fastapi import APIRouter, UploadFile, File, Form, Depends, Path, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from typing import List, Optional
from io import BytesIO

from schemas.robos import Robos as RobosSchema
from models.robos import Robos  
from models.users import User
from models.robos_do_user import RobosDoUser
from auth.dependencies import get_db, get_current_user

import re

def sanitize_filename(nome: str) -> str:
    """Remove caracteres inválidos para nome de arquivo"""
    return re.sub(r'[^a-zA-Z0-9_\-]', '_', nome)

router = APIRouter(prefix="/robos", tags=["Robos"])

# ---------- GET: Listar todos os robôs ----------
@router.get("/", response_model=List[RobosSchema])
def listar_robos(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    robos = db.query(Robos).all()
    return robos

# ---------- GET: Listar robôs disponíveis para uma conta ----------
@router.get("/disponiveis", response_model=List[RobosSchema])
def listar_robos_disponiveis_para_conta(
    conta_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    subquery = (
        db.query(RobosDoUser.id_robo)
        .filter(RobosDoUser.id_conta == conta_id)
        .subquery()
    )

    robos_disponiveis = db.query(Robos).filter(~Robos.id.in_(subquery)).all()
    return robos_disponiveis

# ---------- POST: Criar novo robô ----------
@router.post("/")
async def criar_robo(
    nome: str = Form(...),
    symbol: str = Form(...),
    performance: List[str] = Form(...),
    arquivo: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    conteudo = await arquivo.read()

    novo_robo = Robos(
        nome=nome,
        symbol=symbol,
        performance=performance,
        arquivo=conteudo,
    )

    db.add(novo_robo)
    db.commit()
    db.refresh(novo_robo)

    return {"mensagem": "Robô criado com sucesso", "id": novo_robo.id}

# ---------- PUT: Atualizar robô existente ----------
@router.put("/{id}")
async def atualizar_robo(
    id: int = Path(...),
    nome: Optional[str] = Form(None),
    symbol: Optional[str] = Form(None),
    performance: Optional[List[str]] = Form(None),
    arquivo: Optional[UploadFile] = File(None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    robo = db.query(Robos).filter(Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    if nome is not None:
        robo.nome = nome

    if symbol is not None:
        robo.symbol = symbol

    if performance is not None:
        robo.performance = performance

    if arquivo is not None:
        conteudo = await arquivo.read()
        robo.arquivo = conteudo

    db.commit()
    db.refresh(robo)

    return {"mensagem": "Robô atualizado com sucesso", "id": robo.id}

# ---------- GET: Download do arquivo do robô ----------
@router.get("/download/{id}")
def download_robo(
    id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    robo = db.query(Robos).filter(Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    return StreamingResponse(
        BytesIO(robo.arquivo),
        media_type="application/octet-stream",
        headers={
            "Content-Disposition": f'attachment; filename="arquivo_{sanitize_filename(robo.nome)}.ex5"'
        }
    )

# ---------- DELETE: Remover robô ----------
@router.delete("/{id}", status_code=204)
def deletar_robo(
    id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    robo = db.query(Robos).filter(Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    db.delete(robo)
    db.commit()
