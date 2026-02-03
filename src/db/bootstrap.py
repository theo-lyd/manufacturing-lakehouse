from sqlalchemy import text

def ensure_audit_table(engine, table_name: str):
    ddl = f"""
    CREATE TABLE IF NOT EXISTS {table_name} (
        filename TEXT NOT NULL,
        filehash TEXT NOT NULL,
        ingested_at TIMESTAMP NOT NULL,
        PRIMARY KEY (filename, filehash)
    );
    """
    with engine.begin() as conn:
        conn.execute(text(ddl))