#import di api.py

from flask import Flask, abort, request, Response
app = Flask(__name__)

import json

from database.gruppoAdapter import getGruppi, getGruppo, addGruppo, delGruppo
from models.Gruppo import Gruppo

#app = Flask(__name__)



#import vecchi

#from flask import Flask
#from flask import request
import os







@app.route("/")
def hello():
    with open("login_page.html", "r", encoding='utf-8') as f:
        return f.read()

@app.route("/login_confirm", methods=['POST'])
def print_login_data():
    data = request.form.to_dict()
    return str(data)+"   CODE: 4"


"""
if __name__ == "__main__":
    app.run(host='0.0.0.0')
from flask import Flask, abort, request, Response
app = Flask(__name__)

import json

from database.gruppoAdapter import getGruppi, getGruppo, addGruppo, delGruppo
from models.Gruppo import Gruppo

@app.route('/hello')
def hello():
 return 'Hello, World!'

## GET /gruppi
@app.route('/gruppi', methods=['GET'])
def api_getGruppi():
    g = getGruppi()

    if g: return g.toJSON()
    else: abort(Response(json.dumps({"Message": "Cannot read gruppi!"}), 404))
    
## GET /gruppi/<id>
@app.route('/gruppi/<int:id>', methods=['GET'])
def api_getGruppo(id):
    g = getGruppo(id)

    if g:  return g.toJSON()
    else:  abort(Response(json.dumps({"Message": "Cannot read gruppo!"}), 404))

##NON FUNZIONA A DOVERE
## POST /gruppi/
@app.route('/gruppi/', methods=['POST'])
def api_addGruppo():
    posted = request.json
    g = Gruppo(posted)
    print (g.toJSON())

    if g:
        new = addGruppo(g)
        if new:
            return new.toJSON()
        else:
            abort(Response(json.dumps({"Message": "Cannot add gruppo!"}), 404))
    else:
        abort(Response(json.dumps({"Message": "Request not properly formed!"}), >

## NON FUNZIONA A DOVERE
## DEL /gruppi/<int:id>
@app.route('/gruppi/<int:id>', methods=['DELETE'])
def api_delGruppo(id):
    if delGruppo(id): abort(204)
    else: abort(404)

if __name__ == '__main__':
 app.run(debug=True)

"""
