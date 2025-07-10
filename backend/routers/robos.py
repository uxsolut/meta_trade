from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from io import BytesIO

from database import get_db
import models as models

router = APIRouter(prefix="/robos", tags=["Robos"])

@router.post("/")
async def criar_robo(
    nome: str = Form(...),
    symbol: str = Form(...),
    arquivo: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    conteudo = await arquivo.read()

    novo_robo = models.Robos(
        nome=nome,
        symbol=symbol,
        arquivo=conteudo
    )

    db.add(novo_robo)
    db.commit()
    db.refresh(novo_robo)

    return {"mensagem": "Robô criado com sucesso", "id": novo_robo.id}


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
