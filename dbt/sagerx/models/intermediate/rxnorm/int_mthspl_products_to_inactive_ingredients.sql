-- int_mthspl_products_to_inactive_ingredients.sql

with

substance as (

    select * from {{ ref('stg_rxnorm__mthspl_substances') }}

),

product as (

    select * from {{ ref('stg_rxnorm__mthspl_products') }}

)

select distinct
    concat(lpad(split_part(product.ndc,'-', 1), 5, '0'), lpad(split_part(product.ndc,'-', 2), 4, '0')) as ndc9
    , product.ndc as ndc
    , product.rxcui as product_rxcui
    , product.name as product_name
    , product.tty as product_tty
    , substance.unii as inactive_ingredient_unii
    , substance.rxcui as inactive_ingredient_rxcui
    , substance.name as inactive_ingredient_name
    , substance.tty as inactive_ingredient_tty	
    , product.active as active
    , product.prescribable as prescribable
from datasource.rxnorm_rxnrel rxnrel
inner join substance
    on rxnrel.rxaui1 = substance.rxaui
inner join product
    on rxnrel.rxaui2 = product.rxaui
where rela = 'has_inactive_ingredient'
