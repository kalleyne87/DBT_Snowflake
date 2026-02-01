{{
    config
    (
        materialized='table'
    )
}}
select {{ concat_macro('123 street', 'Chicago') }} as address