from fastapi import APIRouter, UploadFile, File, Form, Depends, Path, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from typing import List
from io import BytesIO

from schemas.robos import Robos as RobosSchema
from models.robos import Robos  
from models.users import User
from auth.dependencies import get_db, get_current_user

router = APIRouter(prefix="/robos", tags=["Robos"])

# ---------- GET: Listar todos os robôs ----------
@router.get("/", response_model=List[RobosSchema])
def listar_robos(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # ✅ Proteção com JWT
):
    robos = db.query(Robos).all()
    return robos

# ---------- POST: Criar novo robô ----------
@router.post("/")
async def criar_robo(
    nome: str = Form(...),
    symbol: str = Form(...),
    performance: List[str] = Form(...),
    arquivo: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # ✅ Proteção com JWT
):
    conteudo = await arquivo.read()

    novo_robo = Robos(
        nome=nome,
        symbol=symbol,
        performance=performance,
        arquivo=conteudo
    )

    db.add(novo_robo)
    db.commit()
    db.refresh(novo_robo)

    return {"mensagem": "Robô criado com sucesso", "id": novo_robo.id}

# ---------- PUT: Atualizar robô existente ----------
@router.put("/{id}")
async def atualizar_robo(
    id: int = Path(...),
    nome: str = Form(...),
    symbol: str = Form(...),
    performance: List[str] = Form(...),
    arquivo: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # ✅ Proteção com JWT
):
    robo = db.query(Robos).filter(Robos.id == id).first()

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

# ---------- GET: Download do arquivo do robô ----------
@router.get("/download/{id}")
def download_robo(
    id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # ✅ Proteção com JWT
):
    robo = db.query(Robos).filter(Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    return StreamingResponse(
        BytesIO(robo.arquivo),
        media_type="application/octet-stream",
        headers={"Content-Disposition": f"attachment; filename={robo.nome}.ex5"}
    )

# ---------- DELETE: Remover robô ----------
@router.delete("/{id}", status_code=204)
def deletar_robo(
    id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # ✅ Proteção com JWT
):
    robo = db.query(Robos).filter(Robos.id == id).first()

    if not robo:
        raise HTTPException(status_code=404, detail="Robô não encontrado")

    db.delete(robo)
    db.commit()
