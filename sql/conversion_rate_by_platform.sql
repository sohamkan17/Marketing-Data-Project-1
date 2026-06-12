-- Conversion rate by platform: purchases as a % of impressions

select
    ads.ad_platform,
    sum(case when events.event_type = 'Impression' then 1 else 0 end) as impressions,
    sum(case when events.event_type = 'Purchase'   then 1 else 0 end) as purchases,
    round(
        100.0 * sum(case when events.event_type = 'Purchase' then 1 else 0 end) 
        / nullif(sum(case when events.event_type = 'Impression' then 1 else 0 end), 0) 
    , 2) as conversion_pct
from ad_events events
join ads on ads.ad_id = events.ad_id
where events.event_type in ('Impression', 'Purchase')   
group by ads.ad_platform 
having sum(case when events.event_type = 'Impression' then 1 else 0 end) > 100  
order by conversion_pct desc;

-- We can see how many impressions are converted into purchases and see which ad platform is more successful
-- There is only roughly a 0.04 difference between the two making the two platforms almost equally as effective