# gruppo_adapter.py
# Adapter that exports DB query's to the WebAPI resource controller
# 
from db_interface import getConnection

def getGruppo (id):
    connection = getConnection()
    
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Gruppi")
        for gruppi in cursor.fetchall():
            print(gruppi)

