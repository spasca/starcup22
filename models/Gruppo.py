from models.Model import Array, Model

class Gruppo(Model):
    # Build a single Gruppo resource from the data 
    # of a single SQL query result.
    # dict_data: a dictionary with the query data in the format field: value
    def __init__(self, dict_data):
        
        # !!! WE REALLY DON'T NEED TO DEFINE DEAFULT VALUES HERE
        # # Define deafult values for attributes
        # self.IdGruppo = 0
        # self.Denominazione = ""
        # self.UP = 0
        # self.ZP = 0
        
        # Check and assign the values of the current entry in the query
        for k, v in dict_data.items():
            if k.lower() == "idgruppo":           self.IdGruppo = v
            elif k.lower() == "denominazione":    self.Denominazione = v
            elif k.lower() == "up":               self.UP = v
            elif k.lower() == "zp":               self.ZP = v
