from fastapi import FastAPI
import models
from database import engine
from routers import mercado_financeiro, robo  # <- adicionado 'robo'

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

app.include_router(mercado_financeiro.router)
app.include_router(robo.router)  # <- nova rota adicionada
