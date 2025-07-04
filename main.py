# main.py
from fastapi import FastAPI
import models
from database import engine
from routers import mercado_financeiro

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Rota principal para testes (GET /)
@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

# Suas rotas já existentes
app.include_router(mercado_financeiro.router)
