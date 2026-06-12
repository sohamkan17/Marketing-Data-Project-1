-- Cost per purchase by campaign

select campaign.name,
       campaign.total_budget,
       count(*) as purchases,
       round(campaign.total_budget * 1.0 / count(*), 2) as cost_per_purchase
from campaigns campaign
    join ads        on ads.campaign_id = campaign.campaign_id
    join ad_events event  on event.ad_id = ads.ad_id
where event.event_type = 'Purchase' 
    group by campaign.name, campaign.total_budget
order by cost_per_purchase asc; 
-- This can be used to see which campaigns were successful and unsuccessful 
-- We can see the total budget for each campaign and see where something was less effective and costly
-- Next step would be to allocate the advertisement investments accordingly to generate more purchases per total ad spending
-- In this data we can see "Campaign 42 Summer" had the least cost per purchase ($118.18)...
-- "Campaign 35 Launch" showing a significant jump for cost per purchase ($6511.53) - investigate