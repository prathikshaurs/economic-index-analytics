-- Categorizing each pattern into a mode
with patterns as (

    select
        platform,
        geo_id,
        geography,
        collaboration_pattern,
        collaboration_count,
        collaboration_pct,
        -- Applied AEI augmentation/automation lens: 'directive' = automation
        -- (user delegates), collaborative patterns = augmentation (AI amplifies user)
        -- 'none'/'not_classified' kept but labeled unclassified, excluded from headline ratios downstream
        case
            when collaboration_pattern = 'directive'
                then 'automation'
            when collaboration_pattern in ('learning', 'validation', 'task iteration', 'feedback loop')
                then 'augmentation'
            else 'unclassified'
        end as collaboration_mode
    from {{ ref('int_collaboration_pivoted') }}

)

select
    platform,
    geo_id,
    geography,
    collaboration_mode,
    collaboration_pattern,
    collaboration_count,
    collaboration_pct
from patterns
