# personaAdapter.py
# Adapter that exports DB query's to the WebAPI resource controller
# 

from mysql.connector import Error

from database.db_interface import getConnection
from models.Persona import Persona
from models.Model import Model, Array

import logging

sql_stmts = {
    'getPersona': 'SELECT * FROM Persona WHERE IdPersona = %s',
    'getPersone': 'SELECT * FROM Persona',
    'addPersona': """INSERT INTO `Persona`(`Nome`, `Cognome`, `Sesso`, 
                                           `LuogoNascita`, `DataNascita`, `Indirizzo`, 
                                           `Email`, `Foto`, `Documento`, `Telefono`, 
                                           `CodFiscale`, `Città`, `Provincia`, `CAP`, `Patentino`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
    'delPersona': 'DELETE FROM `Persona` WHERE IdPersona = %s'
}

def getPersone () -> Array:
    try:
        conn = getConnection()
        cursor = conn.cursor()
        cursor.execute(sql_stmts["getPersone"])
        res = [list(cursor.column_names),] # Add the heading tuple

        # ! Note that cursor.fetchall() returns a list of tuples
        for row in cursor.fetchall():
            res.append(row)
        res_persone = Persona.buildFromQuery(res)
        return res_persone
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None

def gerPersona (id: int) -> Persona:
    try:
        conn = getConnection()
        cursor = conn.cursor()
        cursor.execute(sql_stmts["getPersona"] % id)
        
        head = cursor.column_names # Add the heading tuple
        # ! Note that cursor.fetchall() returns a list of tuples
        data = cursor.fetchone()
        
        res_persona = Persona(dict(zip(head, data))) 
        
        return res_persona
    except AttributeError as e:
        logging.warning("Connection cannot be established.")
        return None
    except Error as e:
        logging.error(e)
        return None

##WORK IN PROGRESS.....
# Add a group and returns the Gruppo object with the ID created
def addPersona (p: Persona) -> Persona:
    try:
        if not isinstance(p, Persona):
            return None

        conn = getConnection()
        cursor = conn.cursor()
        
        # Prepare the data for prepared query
        data = (p.Nome, )
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
