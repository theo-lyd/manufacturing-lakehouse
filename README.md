# Manufacturing Analytics Lakehouse

## Overview

This repository implements a **local-first, cloud-portable manufacturing analytics lakehouse** focused on transforming raw industrial telemetry into **reliable, well-defined operational KPIs**.

The project emphasizes **analytics engineering rigor** over tooling novelty: reproducible ingestion, deterministic transformations, data quality enforcement, orchestration, and clear semantic modeling.

It is intentionally designed to be runnable **entirely on a local machine or GitHub Codespaces**, while remaining portable to cloud warehouses such as BigQuery or Snowflake.

---

## Business Objectives

The system answers concrete manufacturing analytics questions:

* How reliable are machines over time? (MTBF, MTTR)
* How efficient is production? (OEE and its components)
* Where are quality losses and scrap occurring?
* What degradation patterns precede failures?

KPI definitions and assumptions are formalized in [`PROJECT_SCOPE.md`](./PROJECT_SCOPE.md).

---

## High-Level Architecture

```
┌────────────┐     ┌────────────┐     ┌──────────────┐     ┌────────────┐
│ CSV Files  │ ──▶ │ Raw Layer  │ ──▶ │ Transform     │ ──▶ │ Analytics  │
│ (Public)   │     │ (Parquet)  │     │ (dbt)        │     │ Marts      │
└────────────┘     └────────────┘     └──────────────┘     └────────────┘
                          ▲                    │
                          │                    ▼
                    Ingestion Logs         Data Quality
                    & Audits               Tests & Docs
```

---

## Repository Structure

```
manufacturing-lakehouse/
├─ data/                     # Raw data files (CSV / Parquet) – gitignored
├─ ingest/                   # Python ingestion scripts
├─ dbt/                      # dbt project (staging → marts)
│  ├─ models/
│  │  ├─ staging/
│  │  ├─ intermediate/
│  │  └─ marts/
│  └─ tests/
├─ notebooks/                # EDA and analytical exploration
├─ infra/                    # Docker Compose, infra helpers
├─ orchestration/            # Prefect or Airflow pipelines
├─ .github/workflows/        # CI pipelines
├─ Makefile                  # Standardized local commands
├─ PROJECT_SCOPE.md
└─ README.md
```

---

## Local Development Principles

* **Reproducible by default** — no manual steps, no hidden state
* **Local-first** — no paid services required
* **Cloud-portable** — storage and SQL patterns mirror cloud warehouses
* **Deterministic transformations** — same input always yields same output

---

## Tooling (Initial)

* Python 3.10+
* DuckDB (local analytical engine)
* PostgreSQL (metadata / audit simulation)
* dbt Core
* Docker & Docker Compose
* Prefect or Apache Airflow (local)
* GitHub Actions (CI)

---

## Standard Commands

All common tasks are exposed via `make` targets:

```bash
make setup        # Create virtualenv / install dependencies
make ingest       # Run ingestion pipelines
make dbt-run      # Execute dbt models
make dbt-test     # Run data quality tests
make docs         # Generate dbt documentation
```

(See `Makefile` for exact definitions.)

---

## Data Sources

Initial implementation uses:

* **NASA C-MAPSS Turbofan Engine Degradation Dataset**

Additional datasets may be added after the core pipeline is stable.

---

## Intended Audience

This repository is designed as **technical evidence** for:

* Analytics Engineer (mid–senior)
* Data Engineer (analytics-focused)
* BI / Analytics Platform roles

The reader is assumed to be technically proficient.

---

## Status

🚧 In active development
