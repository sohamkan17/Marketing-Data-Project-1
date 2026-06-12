-- Customer segmentation by purchase Recency & Frequency

With purchases as (
  select user_id,
         max(timestamp) as last_purchase,
         count(*)       as freq
  from ad_events
  where event_type = 'Purchase'
  group by user_id
)
select user_id,
       last_purchase,
       freq,
       ntile(4) over (order by last_purchase desc) as recency_quartile, -- 1 = most recent , 4 = most stale
       ntile(4) over (order by freq desc)          as frequency_quartile -- 1 = most frequency, 4 = least frequent
from purchases
    order by freq desc, last_purchase desc;

-- High-frequency recent buyers (quartile 1 on both) are the strongest targets for re-engagement spend
-- stale low-frequency users are lower priority.
