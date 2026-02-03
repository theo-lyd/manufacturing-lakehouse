-- models/gold/engine_lifetime.sql

-- Gold layer: analytics-ready table

{{ config(
    materialized='table'
) }}

with silver as (
    select *
    from {{ ref('cmapss_silver') }}
)

select
    engine_id,
    max(cycle) as max_cycle,

    min(op_setting_1) as min_op_setting_1,
    max(op_setting_1) as max_op_setting_1,
    avg(op_setting_1) as avg_op_setting_1,

    min(op_setting_2) as min_op_setting_2,
    max(op_setting_2) as max_op_setting_2,
    avg(op_setting_2) as avg_op_setting_2,

    min(op_setting_3) as min_op_setting_3,
    max(op_setting_3) as max_op_setting_3,
    avg(op_setting_3) as avg_op_setting_3,

    min(sensor_1) as min_sensor_1,
    max(sensor_1) as max_sensor_1,
    avg(sensor_1) as avg_sensor_1,

    min(sensor_2) as min_sensor_2,
    max(sensor_2) as max_sensor_2,
    avg(sensor_2) as avg_sensor_2,

    min(sensor_3) as min_sensor_3,
    max(sensor_3) as max_sensor_3,
    avg(sensor_3) as avg_sensor_3,

    min(sensor_4) as min_sensor_4,
    max(sensor_4) as max_sensor_4,
    avg(sensor_4) as avg_sensor_4,

    min(sensor_5) as min_sensor_5,
    max(sensor_5) as max_sensor_5,
    avg(sensor_5) as avg_sensor_5,

    min(sensor_6) as min_sensor_6,
    max(sensor_6) as max_sensor_6,
    avg(sensor_6) as avg_sensor_6,

    min(sensor_7) as min_sensor_7,
    max(sensor_7) as max_sensor_7,
    avg(sensor_7) as avg_sensor_7,

    min(sensor_8) as min_sensor_8,
    max(sensor_8) as max_sensor_8,
    avg(sensor_8) as avg_sensor_8,

    min(sensor_9) as min_sensor_9,
    max(sensor_9) as max_sensor_9,
    avg(sensor_9) as avg_sensor_9,

    min(sensor_10) as min_sensor_10,
    max(sensor_10) as max_sensor_10,
    avg(sensor_10) as avg_sensor_10,

    min(sensor_11) as min_sensor_11,
    max(sensor_11) as max_sensor_11,
    avg(sensor_11) as avg_sensor_11,

    min(sensor_12) as min_sensor_12,
    max(sensor_12) as max_sensor_12,
    avg(sensor_12) as avg_sensor_12,

    min(sensor_13) as min_sensor_13,
    max(sensor_13) as max_sensor_13,
    avg(sensor_13) as avg_sensor_13,

    min(sensor_14) as min_sensor_14,
    max(sensor_14) as max_sensor_14,
    avg(sensor_14) as avg_sensor_14,

    min(sensor_15) as min_sensor_15,
    max(sensor_15) as max_sensor_15,
    avg(sensor_15) as avg_sensor_15,

    min(sensor_16) as min_sensor_16,
    max(sensor_16) as max_sensor_16,
    avg(sensor_16) as avg_sensor_16,

    min(sensor_17) as min_sensor_17,
    max(sensor_17) as max_sensor_17,
    avg(sensor_17) as avg_sensor_17,

    min(sensor_18) as min_sensor_18,
    max(sensor_18) as max_sensor_18,
    avg(sensor_18) as avg_sensor_18,

    min(sensor_19) as min_sensor_19,
    max(sensor_19) as max_sensor_19,
    avg(sensor_19) as avg_sensor_19,

    min(sensor_20) as min_sensor_20,
    max(sensor_20) as max_sensor_20,
    avg(sensor_20) as avg_sensor_20,

    min(sensor_21) as min_sensor_21,
    max(sensor_21) as max_sensor_21,
    avg(sensor_21) as avg_sensor_21
from silver
group by engine_id