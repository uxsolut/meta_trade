# routers/robo.py

from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Robo

router = APIRouter(prefix="/robo", tags=["Robo"])

@router.post("/")
async def criar_robo(
    nome: str = Form(...),
    symbol: str = Form(...),
    arquivo: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    conteudo = await arquivo.read()

    novo_robo = Robo(
        nome=nome,
        symbol=symbol,
        arquivo=conteudo
    )

    db.add(novo_robo)
    db.commit()
    db.refresh(novo_robo)

    return {"mensagem": "Robo criado com sucesso", "id": novo_robo.id}
