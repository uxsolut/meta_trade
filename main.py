from fastapi import FastAPI
import models
from database import engine
from routers import ordem, robos 

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

app.include_router(ordem.router)
app.include_router(robos.router)  # <- nova rota adicionada
