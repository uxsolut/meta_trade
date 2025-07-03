# main.py
from fastapi import FastAPI
import models
from database import engine
from routers import mercado_financeiro

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(mercado_financeiro.router)
