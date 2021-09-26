# gruppo_adapter.py
# Adapter that exports DB query's to the WebAPI resource controller
# 
from db_interface import getConnection


def getGruppo (id):
    # Enter the context of mysql connection with default config.ini
    with getConnection() as connection:
        # Get cursor to work with DB
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Gruppo")
            # ! Note that cursor.fetchall() returns a list of tuples
            for gruppi in cursor.fetchall():
                print(gruppi)
            print(cursor.column_names)

getGruppo(1)