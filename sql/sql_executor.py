import psycopg2

from env_data import DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT


def execute_sql(sql: str):
    """
    Execute SQL query
    :param sql: sql query
    :return: bool
    """
    with psycopg2.connect(dbname=DB_NAME,
                          user=DB_USER,
                          password=DB_PASSWORD,
                          host=DB_HOST,
                          port=DB_PORT) as conn:
        with conn.cursor() as curs:
            curs.execute(sql)
            try:
                return curs.fetchone()
            except psycopg2.ProgrammingError:
                return True
