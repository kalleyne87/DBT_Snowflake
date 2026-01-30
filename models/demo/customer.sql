{{
    config
    (
        materialized='table'
    )
}}

with customer_src as 
(
    select 
        customer_id,
        first_name,
        last_name, 
        email,
        phone,
        country,
        created_at,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM {{source('customer', 'CUSTOMER_SRC')}}
)

SELECT * from customer_src