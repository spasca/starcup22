# Starcup 2022 Standard Model for Resource Object

class Model:
    # Default constructor
    def __init__(self):
        pass

    # Depth attribute helps to correctly indent the JSON to be more readable
    def toJSON(self,depth=1):
        jsonstring = "{\n"
        for key, value in vars(self).items():
            if isinstance(value, Model):
                jsonstring += ("  " * (depth)) + key + ": " + value.toJSON(depth+1) + ',\n'
            else:
                if isinstance(value, str):
                    jsonstring += ("  " * (depth)) + key + ": " + '"' + str(value) + '",\n'
                else:
                    jsonstring += ("  " * (depth)) + key + ": " + str(value) + ',\n'
        jsonstring = jsonstring[:-2] + "\n" # Remove trailing comma and newline
        jsonstring += ("  " * (depth-1)) + "}"

        return jsonstring

    # Polimorphic constructor of a single or a multiple resource
    # Uses polimorphically the __init__ constructor of the relative class
    # Returns a list with one or more objects
    @classmethod
    def buildFromQuery(cls, query):
        # Query must be at least a list of 2 tuples: heading ad one row of data
        if len(query) < 2:
            raise Exception()
        # If there's just one entry (note: the first tuple of the query is the heading!) so query is a list of 2 tuples
        if len(query) == 2:
            return cls(query[0], query[1])
        # If there's more than one rows in the result (note: the first tuple of the query is the heading!)
        elif len(query) > 2:
            resultArray = list()
            for i in range(len(query)-1):
                resultArray.append(cls(query[0], query.pop(1)))
            return Array(resultArray)

class Array:
    # Depth attribute helps to correctly indent the JSON to be more readable
    def toJSON(self,depth=1):
        jsonstring = "[\n"
        for item in self.content:
            if isinstance(item, Model):
                jsonstring += ("  " * (depth)) + item.toJSON(depth+1) + ',\n'
        jsonstring = jsonstring[:-2] + "\n" # Remove trailing comma and newline
        jsonstring += ("  " * (depth-1)) + "]"

        return jsonstring

    def __init__(self, list):
        self.content = list