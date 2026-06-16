-- Filter to global task percentages
with task_usage as (

    select
        platform,
        cluster_name,
        value
    from {{ ref('stg_aei_usage') }}
    where facet = 'onet_task'
      and variable = 'onet_task_pct'
      and geography = 'global'

)

select
    platform,
    cluster_name as task_name,
    value        as task_pct
from task_usage
