# This fixes import error
import os, sys
dir_path = os.path.dirname(os.path.realpath(__file__))
parent_dir_path = os.path.abspath(os.path.join(dir_path, os.pardir))
sys.path.insert(0, parent_dir_path)

from models.Model import Array, Model

class Gruppo(Model):
    # Build a single Gruppo resource from the data 
    # of a single SQL query result.
    # head: a tuple with the heading of the query
    # data: a tuple with the data corresponding to the heading
    def __init__(self, head, data):
        # Define deafult values for attributes
        self.IdGruppo = 0
        self.Denominazione = ""
        self.UP = 0
        self.ZP = 0
        # Check and assign the values of the current entry in the query
        for i in range(len(head)):
            if head[i] == "IdGruppo":           self.IdGruppo = data[i]
            elif head[i] == "Denominazione":    self.Denominazione = data[i]
            elif head[i] == "UP":               self.UP = data[i]
            elif head[i] == "ZP":               self.ZP = data[i]
