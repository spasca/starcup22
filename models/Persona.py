from models.Model import Array, Model

class Persona(Model):
    # Build a single Persona resource from the data 
    # of a single SQL query result.
    # dict_data: a dictionary with the query data in the format field: value
    def __init__(self, dict_data):

        # Check and assign the values of the current entry in the query
        for k, v in dict_data.items():
            if k.lower() == "idpersona":       self.IdPersona = v
            elif k.lower() == "nome":          self.Nome = v
            elif k.lower() == "cognome":       self.Cognome = v
            elif k.lower() == "sesso":         self.Sesso = v
            elif k.lower() == "luogonascita":  self.LuogoNascita = v
            elif k.lower() == "datanascita":   self.DataNascita = v
            elif k.lower() == "indirizzo":     self.Indirizzo = v
            elif k.lower() == "email":         self.Email = v
            elif k.lower() == "foto":          self.Foto = v
            elif k.lower() == "documento":     self.Documento = v
            elif k.lower() == "telefono":      self.Telefono = v
            elif k.lower() == "codfiscale":    self.CodFiscale = v
            elif k.lower() == "città":         self.Città = v
            elif k.lower() == "provincia":     self.Provincia = v
            elif k.lower() == "cap":           self.CAP = v
            elif k.lower() == "patentino":     self.Patentino = v 


