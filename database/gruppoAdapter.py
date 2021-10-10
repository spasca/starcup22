# gruppoAdapter.py
# Adapter that exports DB query's to the WebAPI resource controller
# 

from mysql.connector import Error

from database.db_interface import getConnection
from models.Gruppo import Gruppo
from models.Model import Model, Array

import logging

sql_stmts = {
    'getGruppo': 'SELECT * FROM Gruppo WHERE IdGruppo = %s',
    'getGruppi': 'SELECT * FROM Gruppo',
    'addGruppo': 'INSERT INTO `gruppo`(`Denominazione`, `UP`, `ZP`) VALUES (%s, %s, %s)',
    'delGruppo': 'DELETE FROM `gruppo` WHERE IdGruppo = %s'
}

# Returns the result for the query (a list of tuples): the first is the column heading
def getGruppi () -> Array:
    try:
        conn = getConnection()
        cursor = conn.cursor()
        cursor.execute(sql_stmts["getGruppi"])
        res = [list(cursor.column_names),] # Add the heading tuple

        # ! Note that cursor.fetchall() returns a list of tuples
        for row in cursor.fetchall():
            res.append(row)
        res_gruppi = Gruppo.buildFromQuery(res)
        return res_gruppi
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None

def getGruppo (id: int) -> Gruppo:
    try:
        conn = getConnection()
        cursor = conn.cursor()
        cursor.execute(sql_stmts["getGruppo"] % id)
        
        head = cursor.column_names # Add the heading tuple
        # ! Note that cursor.fetchall() returns a list of tuples
        data = cursor.fetchone()
        
        res_gruppo = Gruppo(head, data) 
        
        return res_gruppo
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None


# Add a group and returns the Gruppo object with the ID created
def addGruppo (g: Gruppo) -> Gruppo:
    try:
        if not isinstance(g, Gruppo):
            return None

        conn = getConnection()
        cursor = conn.cursor()
        
        # Prepare the data for prepared query
        data = (g.Denominazione, g.UP, g.ZP)
        # Executes the query
        cursor.execute(sql_stmts["addGruppo"], data)
        conn.commit()

        g.IdGruppo = cursor.lastrowid

        return g
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None

# Delete a group specifing the ID
def delGruppo (id: int) -> bool:
    try:
        conn = getConnection()
        cursor = conn.cursor()
        cursor.execute(sql_stmts["delGruppo"] % id)
        conn.commit()

        return cursor.rowcount == 1
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None
