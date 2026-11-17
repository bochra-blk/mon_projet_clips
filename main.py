
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from clips import Environment
import os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount("/static", StaticFiles(directory="static"), name="static")

env = Environment()
env.load("system_auto.clp")
env.reset()
@app.get("/diagnostic-page")
async def diagnostic_page():
    return FileResponse(os.path.join("static", "diagnostic.html"))
@app.get("/")
async def index():
    return FileResponse(os.path.join("static", "index.html"))

@app.get("/result")
async def result_page():
    return FileResponse(os.path.join("static", "result.html"))

@app.get("/explanation")
async def explanation_page():
    return FileResponse(os.path.join("static", "explanation.html"))
@app.get("/api/knowledge")
async def get_knowledge():
    return [
        {
            "nom": "Olivier",
            "image": "/static/images/oliv.png",
            "maladies": [
                {"name": "Xylella fastidiosa", "advice": "Éliminez les arbres infectés."},
                {"name": "Spilocaea oleaginea", "advice": "Appliquez un fongicide."}
            ]
        },
        {
            "nom": "Palmier",
            "image": "/static/images/palm.png",
            "maladies": [
                {"name": "Graphiola phoenicis", "advice": "Détruisez les feuilles infectées."},
                {"name": "Fusariose du collet", "advice": "Traitez le sol."}
            ]
        },
        {
            "nom": "Menthe",
            "image": "/static/images/mint.png",
            "maladies": [
                {"name": "Oïdium", "advice": "Appliquez un fongicide adapté."},
                {"name": "Fusariose", "advice": "Rotation des cultures."}
            ]
        }
    ]
@app.get("/plants")
async def plants_page():
    return FileResponse(os.path.join("static", "plants.html"))
@app.post("/diagnostic")
async def diagnostic(request: Request):
    data = await request.json()
    plant = data.get("plant")
    symptoms = data.get("symptoms", {})

    env.reset()
    env.assert_string(f'(plant (name "{plant}"))')

    for name, value in symptoms.items():
        env.assert_string(f'(symptom (name "{name}") (value "{value}"))')

    env.run()

    for fact in env.facts():
        if fact.template.name == "diagnosis":
            return {
                "disease": fact["disease"],
                "advice": fact["advice"],
                "description": fact["description"],
                "symptoms_desc": fact["symptoms_desc"],
                "reasoning": fact["reasoning"],
                "danger_level": fact["danger_level"]
            }

    return {
        "disease": "Inconnu",
        "advice": "Aucun diagnostic trouvé."
    }
