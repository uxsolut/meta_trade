from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import RobosDoUser
from fastapi.responses import JSONResponse

router = APIRouter(prefix="/robos_do_user", tags=["Robôs do Usuário"])

@router.post("/")
async def criar_robo_do_user(
    id_user: int = Form(...),
    id_robo: int = Form(...),
    id_resultados: int = Form(None),
    arquivo_cliente: UploadFile = File(None),
    db: Session = Depends(get_db)
):
    conteudo = await arquivo_cliente.read() if arquivo_cliente else None

    novo = RobosDoUser(
        id_user=id_user,
        id_robo=id_robo,
        id_resultados=id_resultados,
        arquivo_cliente=conteudo
    )

    db.add(novo)
    db.commit()
    db.refresh(novo)

    return JSONResponse(content={"mensagem": "Robô vinculado ao usuário com sucesso", "id": novo.id})
