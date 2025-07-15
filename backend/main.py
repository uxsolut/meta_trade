from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.openapi.utils import get_openapi
from database import engine, Base

from models import corretoras  
from routers import robos, users, robos_do_user, requisicoes, carteiras, ordens  

# Criação das tabelas no banco
Base.metadata.create_all(bind=engine)

app = FastAPI()

# Configuração de CORS (liberar origens)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Em produção, troque para o domínio do seu frontend!
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Rota raiz
@app.get("/")
def read_root():
    return {"mensagem": "API online com sucesso!"}

# Inclusão das rotas
app.include_router(ordens.router)
app.include_router(robos.router)
app.include_router(users.router)          
app.include_router(robos_do_user.router)  
app.include_router(requisicoes.router)
app.include_router(carteiras.router)

# Swagger com suporte a Bearer token
def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title="Meta Trade API",
        version="1.0.0",
        description="Documentação da API da Meta Trade com autenticação JWT",
        routes=app.routes,
    )
    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT",
        }
    }
    openapi_schema["security"] = [{"BearerAuth": []}]
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

# Execução local (útil para desenvolvimento)
import os
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=int(os.environ.get("PORT", 10000)))
