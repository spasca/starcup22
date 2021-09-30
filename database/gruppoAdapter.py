# gruppoAdapter.py
# Adapter that exports DB query's to the WebAPI resource controller
# 


from database.db_interface import getConnection

# Returns the result for the query (a list of tuples): the first is the column heading
def getGruppo (id):
    # Enter the context of mysql connection with default config.ini
    with getConnection() as connection:
        # Get cursor to work with DB
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Gruppo WHERE IdGruppo = " + str(id))
            res = list(cursor.column_names) # Add the heading tuple
            # ! Note that cursor.fetchall() returns a list of tuples
            for row in cursor.fetchall():
                res.append(row)
            return res
    return None

# Returns the result for the query (a list of tuples): the first is the column heading
def getGruppi ():
    # Enter the context of mysql connection with default config.ini
    with getConnection() as connection:
        # Get cursor to work with DB
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Gruppo")
            res = list()
            res.append(tuple(cursor.column_names)) # Add the heading tuple
            # ! Note that cursor.fetchall() returns a list of tuples
            for row in cursor.fetchall():
                res.append(row)
            return res
    return None

# Delete the group specified by the ID
def delGruppo (id):
    # Enter the context of mysql connection with default config.ini
    with getConnection() as connection:
        # Get cursor to work with DB
        with connection.cursor() as cursor:
            # Executes the query to delete the element, 
            cursor.execute("DELETE FROM Gruppo WHERE IdGruppo = %s", (id,)) 
            connection.commit()
            if cursor.rowcount == 1:
                return True
            else:
                return False
    return None


# delGruppo
# updGruppo
# addGruppo

