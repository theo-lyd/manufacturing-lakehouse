{{ config(materialized='table') }}

select
    engine_id,
    min(cycle) as start_cycle,
    max(cycle) as end_cycle,
    max(cycle) - min(cycle) + 1 as lifetime_cycles
from {{ ref('cmapss_silver') }}
group by engine_id