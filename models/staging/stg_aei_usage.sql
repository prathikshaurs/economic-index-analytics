-- Reading the Claude.ai file (CTE)
with claude_ai as (

    select
        *,
        'claude_ai' as platform
    from read_csv_auto(
        '{{ var("raw_data_dir") }}/{{ var("claude_ai_file") }}'
    )

)

,

-- Reading the API file (CTE)
api as (

    select
        *,
        'api' as platform
    from read_csv_auto(
        '{{ var("raw_data_dir") }}/{{ var("api_file") }}'
    )

)

,
-- unioned CTE- to stack the above 2 sources ("union all" so that duplicates remain)
unioned as (

    select * from claude_ai
    union all
    select * from api

)
-- Cleanup
select
    platform,
    geo_id,
    geography,
    cast(date_start as date)  as date_start,
    cast(date_end   as date)  as date_end,
    platform_and_product,
    facet,
    cast(level as integer)    as level,
    variable,
    cluster_name,
    cast(value as double)     as value
from unioned