class SC22Model:
    content = dict()

    # Default constructor that puts the result from SQL query inside content attribute
    def __init__(self, ):
        pass

    # Depth attribute helps to correctly indent the JSON to be more readable
    def toJSON(self,depth=1):
        jsonstring = "{\n"
        for key, value in self.content.items():
            if isinstance(value, SC22Model):
                jsonstring += ("  " * (depth)) + key + ": " + value.toJSON(depth+1) + ',\n'
            else:
                if isinstance(value, str):
                    jsonstring += ("  " * (depth)) + key + ": " + '"' + str(value) + '",\n'
                else:
                    jsonstring += ("  " * (depth)) + key + ": " + str(value) + ',\n'
        jsonstring = jsonstring[:-2] + "\n" # Remove trailing comma and newline
        jsonstring += ("  " * (depth-1)) + "}"

        return jsonstring


class Campo(SC22Model):
    pass

class Gruppo(SC22Model):
    def __init__(self):
        pass

    @classmethod
    def buildFromSql(cls):
        pass




c = Campo()
c.content = dict ({"idCampo": 1, "lat": 40.12, "lon": 10.21})

g = Gruppo()
g.content = dict( {"idGruppo": 1, "denominazione": "Parrocchia San Biagio e Savino", "campo": c})


print (g.toJSON())

