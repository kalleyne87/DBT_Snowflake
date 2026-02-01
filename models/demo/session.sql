{{
    config
    (
        materialized='table'
    )
}}

with session_src as 
(
    SELECT 
        SESSION_ID,
        USER_ID,
        BROWSER,
        DEVICE_TYPE,
        b.country_name as COUNTRY_NAME,
        b.continent as CONTINENT,
        b.currency as CURRENCY,
        START_TIME,
        END_TIME,
        PAGES_VISITED,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM {{source('session', 'SESSION_SRC')}} a
    LEFT JOIN {{ ref('country_code') }} b
        ON a.COUNTRY_CODE = b.COUNTRY_CODE 
)

SELECT * FROM session_src