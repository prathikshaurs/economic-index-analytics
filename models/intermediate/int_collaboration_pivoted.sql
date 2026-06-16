-- Filtering columns
with collaboration as (

    select
        platform,
        geo_id,
        geography,
        cluster_name,
        variable,
        value
    from {{ ref('stg_aei_usage') }}
    where facet = 'collaboration'
      and platform = 'claude_ai'

)

,
-- Pivot
pivoted as (

    select
        platform,
        geo_id,
        geography,
        cluster_name as collaboration_pattern,
        max(case when variable = 'collaboration_count' then value end) as collaboration_count,
        max(case when variable = 'collaboration_pct'   then value end) as collaboration_pct
    from collaboration
    group by
        platform,
        geo_id,
        geography,
        cluster_name

)

select * from pivoted
