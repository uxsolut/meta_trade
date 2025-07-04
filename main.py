from fastapi import FastAPI
import models
from database import engine
from routers import ordem, robos, users, robos_do_user  # <- novos imports

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

app.include_router(ordem.router)
app.include_router(robos.router)
app.include_router(users.router)          # <- novo
app.include_router(robos_do_user.router)  # <- novo
