from mysql.connector import connect, Error
import configparser
import logging

def getConnection():
# Returns the connection to the DB
    try:
        config = configparser.ConfigParser()
        config.read('config.ini')
    except:
        logging.critical("Cannot open config.ini file.")
        return None
    else:
        try:
            conn = connect(
                host=config['database']['host'],
                user=config['database']['user'],
                password=config['database']['pass'],
                database=config['database']['db'],
                auth_plugin='mysql_native_password' 
            )         
            
        except Error as e:
            logging.error("Cannot connect to DB.")
            logging.error(e)
            return None

        else:
            return conn

