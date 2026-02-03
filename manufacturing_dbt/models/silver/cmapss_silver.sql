-- models/silver/cmapss_silver.sql

-- silver layer: cleaned/merged table

{{ config(
    materialized='table'  
) }}

with telemetry as (
    select *
    from {{ ref('stg_cmapss_raw') }}
)

select
    t.engine_id,
    t.cycle,
    t.op_setting_1,
    t.op_setting_2,
    t.op_setting_3,
    t.sensor_1,
    t.sensor_2,
    t.sensor_3,
    t.sensor_4,
    t.sensor_5,
    t.sensor_6,
    t.sensor_7,
    t.sensor_8,
    t.sensor_9,
    t.sensor_10,
    t.sensor_11,
    t.sensor_12,
    t.sensor_13,
    t.sensor_14,
    t.sensor_15,
    t.sensor_16,
    t.sensor_17,
    t.sensor_18,
    t.sensor_19,
    t.sensor_20,
    t.sensor_21
from telemetry t