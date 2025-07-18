from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional

from models.robos_do_user import RobosDoUser
from schemas.robos_do_user import RoboDoUser
from models.users import User
from auth.dependencies import get_db, get_current_user

router = APIRouter(prefix="/robos_do_user", tags=["Robôs do Usuário"])

# ---------- POST: Criar robô do user ----------
@router.post("/", response_model=RoboDoUser)
async def criar_robo_do_user(
    id_robo: int = Form(...),
    ligado: bool = Form(False),
    ativo: bool = Form(False),
    tem_requisicao: bool = Form(False),
    id_ordem: Optional[int] = Form(None),
    id_carteira: Optional[int] = Form(None),
    id_conta: Optional[int] = Form(None),
    arquivo_cliente: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),  # 🔐 Pega o usuário autenticado via JWT
):
    conteudo = await arquivo_cliente.read() if arquivo_cliente else None

    novo = RobosDoUser(
        id_user=current_user.id,
        id_robo=id_robo,
        ligado=ligado,
        ativo=ativo,
        tem_requisicao=tem_requisicao,
        id_ordem=id_ordem,
        id_carteira=id_carteira,
        id_conta=id_conta,
        arquivo_cliente=conteudo
    )

    db.add(novo)
    db.commit()
    db.refresh(novo)

    return novo

# ---------- GET: Listar todos os robôs do user ou por id_robo_user ----------
@router.get("/", response_model=List[RoboDoUser])
def listar_robos_do_user(
    id_robo_user: Optional[int] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    query = db.query(RobosDoUser).filter(RobosDoUser.id_user == current_user.id)

    if id_robo_user is not None:
        query = query.filter(RobosDoUser.id == id_robo_user)

    return query.all()
