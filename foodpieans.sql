SELECT * FROM plans;
SELECT * FROM subscriptions;

-- How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTALCUSTOMER
FROM subscriptions;

-- What is the monthly distribution of trial plan start_date values for our dataset — use the start of the month as the GROUP BY value
SELECT month(START_DATE) AS MONTHS,COUNT(CUSTOMER_ID) AS NUMBER_CUST
FROM subscriptions
GROUP BY MONTHS
ORDER BY MONTHS ASC ;

-- What plan ‘start_date’ values occur after the year 2020 for our dataset? Show the breakdown by count of events for each ‘plan_name’.
SELECT P.PLAN_NAME,P.PLAN_ID,COUNT(*) AS CNT_EVENT
FROM subscriptions S JOIN plans P 
ON S.PLAN_ID = P.PLAN_ID
WHERE S.start_date >= '2021-01-01'
GROUP BY P.PLAN_NAME,P.PLAN_ID
ORDER BY P.PLAN_ID;

-- What is the customer count and percentage of customers who have churned the rounded to 1 decimal place?
SELECT COUNT(*) AS CUST_CHURN,
ROUND(COUNT(*) * 100 / (SELECT  COUNT(DISTINCT CUSTOMER_ID) FROM subscriptions),1) AS PERC_CUST
FROM subscriptions
WHERE plan_id=4;
select * from plans;
select * from subscriptions;
-- How many customers have upgraded to an annual plan in 2020?
select count(*) as totalcust
from plans p join subscriptions s 
on p.plan_id = s.plan_id
where p.plan_id=3 and year(s.start_date) = 2020;

