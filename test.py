import os, sys
dir_path = os.path.dirname(os.path.realpath(__file__))
parent_dir_path = os.path.abspath(os.path.join(dir_path, os.pardir))
sys.path.insert(0, parent_dir_path)

from database.gruppoAdapter import getGruppo, getGruppi
from models.Gruppo import Gruppo

#gr = getGruppo(1)
#print (type(gr))
#grObject = Gruppo(gr)
#print (type(grObject))

gruppi = Gruppo.buildFromQuery(getGruppi())

print (gruppi.toJSON())

# print(gr.toJSON())
