# import os, sys
# dir_path = os.path.dirname(os.path.realpath(__file__))
# parent_dir_path = os.path.abspath(os.path.join(dir_path, os.pardir))
# sys.path.insert(0, parent_dir_path)

from database.gruppoAdapter import getGruppi, getGruppo, addGruppo, delGruppo
from models.Gruppo import Gruppo

import logging 

logging.basicConfig(level=logging.DEBUG)

g = Gruppo({"Denominazione":"Test1", "UP":50, "ZP":50})

print(g.toJSON())

# TEST AGGIUNGE GRUPPO
nuovo = addGruppo(g)

print(nuovo.toJSON())

if delGruppo(nuovo.IdGruppo):
    print("Eliminato con successo il gruppo %s" % nuovo.IdGruppo)
else:
    print("Non sono riuscito a eliminare")
