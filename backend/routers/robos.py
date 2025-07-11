from fastapi import APIRouter, UploadFile, File, Form, Depends, Path, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from typing import List
from io import BytesIO
from schemas.robos import Robos as RobosSchema

from database import get_db
import models as models


router = APIRouter(prefix="/robos", tags=["Robos"])

@router.get("/", response_model=List[RobosSchema])
def listar_robos(db: Session = Depends(get_db)):
    robos = db.query(models.Robos).all()
    return robos

@router.post("/")
async def criar_robo(
    nome: str = Form(...),
    symbol: str = Form(...),
    performance: List[str] = Form(...),  # <- novo campo aqui
    arquivo: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    conteudo = await arquivo.read()

    novo_robo = models.Robos(
        nome=nome,
        symbol=symbol,
        performance=performance,
        arquivo=conteudo
    )

    db.add(novo_robo)
    db.commit()
    db.refresh(novo_robo)

    return {"mensagem": "Robô criado com sucesso", "id": novo_robo.id}


@router.put("/{id}")
async def atualizar_robo(
    id: int = Path(...),
    nome: str = Form(...),
    symbol: str = Form(...),
    performance: List[str] = Form(...),
    arquivo: UploadFile = File(None),  # opcional
    db: Session = Depends(get_db)
):
    robo = db.query(models.Robos).filter(models.Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    robo.nome = nome
    robo.symbol = symbol
    robo.performance = performance

    if arquivo:
        conteudo = await arquivo.read()
        robo.arquivo = conteudo

    db.commit()
    db.refresh(robo)

    return {"mensagem": "Robô atualizado com sucesso", "id": robo.id}


@router.get("/download/{id}")
def download_robo(id: int, db: Session = Depends(get_db)):
    robo = db.query(models.Robos).filter(models.Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    return StreamingResponse(
        BytesIO(robo.arquivo),
        media_type="application/octet-stream",
        headers={"Content-Disposition": f"attachment; filename={robo.nome}.ex5"}
    )


