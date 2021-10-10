from mysql.connector import connect, Error
import configparser
import logging

logging.basicConfig(level=logging.DEBUG)


conn = connect(
                host='localhost',
                user='webapi',
                password='w3bap1',
                database='starcup22',
                auth_plugin='mysql_native_password'
            )        

cursor = conn.cursor()

cursor.execute("SELECT * FROM Gruppo WHERE IdGruppo = " + str(1))

res = list(cursor.column_names) # Add the heading tuple
# ! Note that cursor.fetchall() returns a list of tuples
for row in cursor.fetchall():
    res.append(row)
    print(row)
