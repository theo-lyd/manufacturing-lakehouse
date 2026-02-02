# Manufacturing Analytics Lakehouse — Project Scope

## 1. Problem Statement

Modern manufacturing environments generate large volumes of time-series sensor data, maintenance logs, and quality outcomes. However, these datasets are often siloed, poorly modeled, and difficult to transform into **reliable operational KPIs** for decision-making.

This project builds a **local-first, cloud-portable manufacturing analytics lakehouse** that ingests public industrial datasets and transforms them into **production-grade analytical models** suitable for reliability engineering, operations analytics, and maintenance optimization.

The goal is not dashboard aesthetics, but **analytics engineering rigor**: reproducibility, correctness, data quality, orchestration, and clear KPI semantics.

---

## 2. Business Questions This System Answers

The system is explicitly designed to answer the following operational questions:

1. **Equipment Reliability**

   * How often do machines fail?
   * What is the mean time between failures (MTBF)?
   * How long does it take to repair failures (MTTR)?

2. **Operational Efficiency**

   * What is the Overall Equipment Effectiveness (OEE) per machine and time window?
   * Which factors (availability, performance, quality) drive OEE degradation?

3. **Quality & Waste**

   * What is the scrap rate over time?
   * Are defects correlated with specific sensor patterns or operating regimes?

4. **Predictive Signals (Foundational)**

   * Are there leading indicators in sensor telemetry preceding failures?
   * Can degradation trends be surfaced consistently for downstream ML use?

---

## 3. Core KPIs (Formal Definitions)

### 3.1 Overall Equipment Effectiveness (OEE)

OEE is defined as:

> **OEE = Availability × Performance × Quality**

* **Availability** = (Planned Production Time − Downtime) / Planned Production Time
* **Performance** = Actual Output / Theoretical Maximum Output
* **Quality** = Good Units / Total Units Produced

All three components will be materialized explicitly to avoid opaque metrics.

---

### 3.2 Mean Time Between Failures (MTBF)

> **MTBF = Total Operating Time / Number of Failures**

Computed per equipment unit over a defined observation window, based on inferred or labeled failure events.

---

### 3.3 Mean Time To Repair (MTTR)

> **MTTR = Total Downtime Due to Failures / Number of Failures**

Downtime windows are derived from maintenance or failure intervals.

---

### 3.4 Scrap Rate

> **Scrap Rate = Scrap Units / Total Units Produced**

Where explicit scrap labels exist; otherwise approximated via defect indicators.

---

## 4. Data Sources (Initial Scope)

The initial implementation focuses on **public, static datasets**:

* **NASA C-MAPSS Turbofan Engine Degradation**

  * Multivariate time-series sensor telemetry
  * Failure labels and remaining useful life (RUL)

Additional datasets may be added later, but **only after the core pipeline is stable**.

---

## 5. Architectural Scope

### Included

* Batch ingestion (CSV → Parquet)
* Raw, staging, intermediate, and mart layers
* dbt-based transformations with tests and documentation
* Local orchestration (Prefect or Airflow)
* CI-based validation of transformations

### Explicitly Excluded (Non-Goals)

* Real-time streaming (Kafka, Kinesis)
* Online inference or ML model serving
* Production BI deployment
* Complex access control or multi-tenant security

These exclusions are intentional to maintain focus on analytics engineering fundamentals.

---

## 6. Design Principles

1. **Local-first, cloud-portable** — every component must run locally without paid services.
2. **Reproducibility over speed** — deterministic pipelines are prioritized over performance hacks.
3. **Explicit semantics** — KPI logic and assumptions are documented and testable.
4. **Production realism** — ingestion auditing, incremental models, and CI are mandatory.

---

## 7. Success Criteria

The project is considered successful when:

* A new developer can clone the repository and reproduce all results locally.
* KPIs are traceable from raw data to final marts.
* Data quality issues are detected automatically.
* The system can be reasonably migrated to a cloud warehouse with minimal refactoring.
