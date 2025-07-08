from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import models as models
from database import engine
from routers import ordem, robos, users, robos_do_user, requisicoes  # <- novos imports

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Adicione este bloco para liberar CORS para qualquer origem (Ajuste em produção!)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Em produção, troque para o domínio do seu frontend!
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

app.include_router(ordem.router)
app.include_router(robos.router)
app.include_router(users.router)          
app.include_router(robos_do_user.router)  
app.include_router(requisicoes.router)

import os

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=int(os.environ.get("PORT", 10000)))
