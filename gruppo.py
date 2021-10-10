#   GRUPPO RESOURCE
#   Endpoint:   /gruppo
#       GET 
#
#
#
#

import gruppo from adapters

""" 
Gruppo resource properties:
  IdGruppo = 0
  Denominazione = ""
  UP = 0
  ZP = 0
"""

@app.route("/gruppo", method=["GET"])
def getGruppo():
    # Authentication and/or authorization
    response = Gruppo.buildFromQuery(getGruppi())
    g1 = addGiocatore(Giocatore.fromJSON(txt))
              
    # Error handling

    if not response:
        return "{}"
    return response




@app.route("/gruppo", method=["POST"])


