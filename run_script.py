import sqlite3
from sqlite3 import Error


def run_script():
    # reading script file
    with open("query_12.sql", "r") as f:
        sql = f.read()

    # connecting to db, it not exist, db will be created
    with sqlite3.connect("HW_6.db") as conn:
        cur = conn.cursor()
        try:
            cur.execute(sql)
            # fetch all the results to print it in the console
            rows = cur.fetchall()
            for r in rows:
                print(r)
        except Error as e:
            print(e)


if __name__ == "__main__":
    run_script()