with task_usage as (

    select
        task_name,
        platform,
        task_pct
    from {{ ref('int_task_usage_by_platform') }}
    where task_name not in ('none', 'not_classified')

),

pivoted as (

    select
        task_name,
        max(case when platform = 'claude_ai' then task_pct end) as claude_ai_pct,
        max(case when platform = 'api'       then task_pct end) as api_pct
    from task_usage
    group by task_name

)

select
    task_name,
    claude_ai_pct,
    api_pct,
    claude_ai_pct - api_pct as difference
from pivoted
where claude_ai_pct is not null
  and api_pct is not null