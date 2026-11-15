import json
from pathlib import Path
from flask import abort, jsonify, request
from . import app

data = json.loads((Path(__file__).parent / 'data/pictures.json').read_text())

def find_picture(id):
    return next((picture for picture in data if picture['id'] == id), None)

@app.get('/health')
def health():
    return jsonify(status='OK')

@app.get('/count')
def count():
    return jsonify(length=len(data))

@app.get('/picture')
def get_pictures():
    return jsonify(data)

@app.get('/picture/<int:id>')
def get_picture_by_id(id):
    picture = find_picture(id)
    if picture is None:
        abort(404)
    return jsonify(picture)

@app.post('/picture')
def create_picture():
    picture = request.get_json()
    if not isinstance(picture, dict) or not isinstance(picture.get('id'), int):
        abort(400)
    if find_picture(picture['id']) is not None:
        return jsonify(Message=f"picture with id {picture['id']} already present"), 302
    data.append(picture)
    return jsonify(picture), 201

@app.put('/picture/<int:id>')
def update_picture(id):
    picture = find_picture(id)
    if picture is None:
        abort(404)
    changes = request.get_json()
    if not isinstance(changes, dict) or changes.get('id', id) != id:
        abort(400)
    picture.update(changes)
    return jsonify(picture)

@app.delete('/picture/<int:id>')
def delete_picture(id):
    picture = find_picture(id)
    if picture is None:
        abort(404)
    data.remove(picture)
    return '', 204
