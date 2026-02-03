# src/db/audit.py
from sqlalchemy import text
import datetime

def already_ingested(engine, table, filename, filehash):
    sql = text(f"""
        SELECT 1 FROM {table}
        WHERE filename = :filename
          AND filehash = :filehash
        LIMIT 1
    """)
    with engine.connect() as conn:
        return conn.execute(
            sql,
            {"filename": filename, "filehash": filehash}
        ).first() is not None


def log_ingest(engine, table, filename, filehash):
    sql = text(f"""
        INSERT INTO {table} (filename, filehash, ingested_at)
        VALUES (:filename, :filehash, :ingested_at)
    """)
    with engine.begin() as conn:
        conn.execute(
            sql,
            {
                "filename": filename,
                "filehash": filehash,
                "ingested_at": datetime.datetime.utcnow()
            }
        )