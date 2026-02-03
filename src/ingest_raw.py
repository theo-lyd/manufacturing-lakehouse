import os
import hashlib
import pandas as pd
from sqlalchemy import create_engine
from db.bootstrap import ensure_audit_table
from db.audit import already_ingested, log_ingest

# -------------------
# Config
# -------------------
RAW_DIR = "/workspaces/manufacturing-lakehouse/data/raw/cmapss"
AUDIT_TABLE = "raw_ingest_audit"
DB_URL = "postgresql+psycopg2://analytics:analytics123@localhost:5432/manufacturing"

engine = create_engine(DB_URL)

# -------------------
# Helpers
# -------------------
def file_md5(path: str) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()

# -------------------
# Bootstrap
# -------------------
ensure_audit_table(engine, AUDIT_TABLE)

# -------------------
# Ingestion
# -------------------
for fname in sorted(os.listdir(RAW_DIR)):

    fpath = os.path.join(RAW_DIR, fname)
    
    # Ingest RUL files
    if fname.startswith("RUL_"):
        df = pd.read_csv(fpath, header=None, names=["rul"])
        df["engine_id"] = df.index + 1

        df.to_sql(
            "cmapss_rul_raw",
            engine,
            if_exists="replace",
            index=False
        )

        print(f"[OK] Ingested RUL labels: {fname}")
        continue

    if not fname.startswith(("train_", "test_")):
        raise ValueError(f"Unknown file type: {fname}")

    fh = file_md5(fpath)

    if already_ingested(engine, AUDIT_TABLE, fname, fh):
        print(f"[SKIP] {fname}")
        continue

    df = pd.read_csv(fpath, sep=r"\s+", header=None)

    expected_cols = 26
    if df.shape[1] != expected_cols:
        raise ValueError(
            f"{fname}: Expected {expected_cols} columns, got {df.shape[1]}"
        )

    df.columns = (
        ["engine_id", "cycle"]
        + [f"op_setting_{i}" for i in range(1, 4)]
        + [f"sensor_{i}" for i in range(1, 22)]
    )

    df["source_file"] = fname

    df.to_sql(
        "cmapss_raw",
        engine,
        if_exists="append",
        index=False,
        method="multi"
    )

    log_ingest(engine, AUDIT_TABLE, fname, fh)
    print(f"[OK] {fname}")