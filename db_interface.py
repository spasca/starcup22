from mysql.connector import connect, Error

# Define DB connection auth data
db_host =   "localhost"
db_uname =  "webapi"
db_upass =  "w3bap1"
db_name =   "starcup22"

def getConnection():
# Returns the connection to the DB
    try:
        with connect(
            host=db_host,
            user=db_uname,
            password=db_upass,
            database=db_name
        ) as conn:
            return conn            

    except Error as e:
        print(e)
        return None

