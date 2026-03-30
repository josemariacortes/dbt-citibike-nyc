{{ config(materialized='table') }}

WITH _tmp_data AS (
    SELECT *
        -- campos de auditoria
        , NOW() audit_row_insert
        , 'citibikenyc' audit_process_id
    FROM
        {{ ref('enriched_citibikes_trips') }}
)

SELECT *
FROM _tmp_data
