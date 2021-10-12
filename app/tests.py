import pytest
import requests
from http import HTTPStatus

def testAllCharactersBig():
    pokemonName = "CHARIZARD"
    response = requests.get(f"http://localhost:5000/{pokemonName}")
    assert response.status_code == HTTPStatus.OK

def testWrongPokemon():
    pokemonName = 'pizda'
    response = requests.get(f"http://localhost:5000/{pokemonName}")
    assert response.text == "Sorry, the pokemon you are looking for doesnt exist"