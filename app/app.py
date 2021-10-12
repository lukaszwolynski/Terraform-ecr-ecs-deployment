from flask import Flask
import requests

#https://pokeapi.co/api/v2/ability/{id or name}/

app = Flask(__name__)

def handleCorrectPokemon(response):
    response = response.json()
    return {"name": response["name"],
            "abilities": response["abilities"],
            "weight": response["weight"],
            "baseExp": response["base_experience"]
            }


@app.route("/<pokemonName>")
def getPokemon(pokemonName):
    pokemonName = pokemonName.lower() #convert all letters to small - requirment of pokemon API
    response = requests.get(f"https://pokeapi.co/api/v2/pokemon/{pokemonName}")

    if response.status_code == 200:
        return handleCorrectPokemon(response)
    else:
        return "Sorry, the pokemon you are looking for doesnt exist"
    #return response.json() #"kurwa" #response


if __name__=="__main__":
    app.run(debug=True, host="0.0.0.0", port="5000")
