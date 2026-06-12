-- Purchases per ad platform

select ads.ad_platform,
       count(*) as purchases
from ad_events event
join ads on ads.ad_id = event.ad_id
where event.event_type = 'Purchase'
group by ads.ad_platform
order by purchases desc;
-- This orders the two social media platforms by which one yielded the greater amount of purchases to the least
-- This is useful in order to determine the more successful platform in yielding purchases ONLY
-- However you also need to account for budget allocation and impressions in order to determine which platform is more efficient