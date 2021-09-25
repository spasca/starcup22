from mysql.connector import connect, Error
import configparser

def getConnection():
# Returns the connection to the DB
    config = configparser.ConfigParser()
    config.read('config.ini')

    try:
        return connect(
            host=config['database']['host'],
            user=config['database']['user'],
            password=config['database']['pass'],
            database=config['database']['db']
        )         

    except Error as e:
        return None

