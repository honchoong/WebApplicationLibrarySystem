import connect, mysql.connector
# establish connection to database
print("import done = establishing connection")
conn = mysql.connector.connect(user=connect.dbuser, \
    password=connect.dbpass, host=connect.dbhost, database=connect.dbname, autocommit=True)
print(f"connection done - {conn}")
with conn:
    cur = conn.cursor()
    cur.execute("Select * FROM Author Where Author.authorid = 1;")
    select_result = cur.fetchall()
    print(f"{select_result[0]}")