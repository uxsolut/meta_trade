from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional

from database import get_db
from models.robos_do_user import RobosDoUser
from schemas.robos_do_user import RoboDoUser

router = APIRouter(prefix="/robos_do_user", tags=["Robôs do Usuário"])

# ---------- POST: Criar robô do user ----------
@router.post("/", response_model=RoboDoUser)
async def criar_robo_do_user(
    id_user: int = Form(...),
    id_robo: int = Form(...),
    ligado: bool = Form(False),
    ativo: bool = Form(False),
    tem_requisicao: bool = Form(False),
    id_ordem: Optional[int] = Form(None),
    id_carteira: Optional[int] = Form(None),
    id_corretora: Optional[int] = Form(None),
    arquivo_cliente: UploadFile = File(None),
    db: Session = Depends(get_db)
):
    conteudo = await arquivo_cliente.read() if arquivo_cliente else None

    novo = RobosDoUser(
        id_user=id_user,
        id_robo=id_robo,
        ligado=ligado,
        ativo=ativo,
        tem_requisicao=tem_requisicao,
        id_ordem=id_ordem,
        id_carteira=id_carteira,
        id_corretora=id_corretora,
        arquivo_cliente=conteudo
    )

    db.add(novo)
    db.commit()
    db.refresh(novo)

    return novo

# ---------- GET: Listar todos os robôs do user ----------
@router.get("/", response_model=List[RoboDoUser])
def listar_robos_do_user(db: Session = Depends(get_db)):
    return db.query(RobosDoUser).all()
