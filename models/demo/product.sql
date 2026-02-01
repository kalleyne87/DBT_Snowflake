{{
    config
    (
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_keys='PRODUCT_ID'
    )
}}

with products_src as 
(
    select  
        PRODUCT_ID,
        PRODUCT_NAME,
        PRODUCT_PRICE,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
    FROM {{source('products', 'PRODUCT_SRC')}}

    {% if is_incremental() %}
    where CREATED_AT > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

SELECT * FROM products_src