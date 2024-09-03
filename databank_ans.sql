 -- A. Customer Nodes Exploration
 SELECT * FROM customer_nodes;
 SELECT * FROM regions;
 -- How many unique nodes are there on the Data Bank system?
 SELECT COUNT(DISTINCT NODE_ID) FROM customer_nodes;
 -- What is the number of nodes per region?
 SELECT R.REGION_NAME,COUNT(DISTINCT C.NODE_ID) AS NUMBER_NODES
 FROM customer_nodes C JOIN regions R
 ON C.region_id = R.region_id
 GROUP BY R.region_name;
 -- How many customers are allocated to each region?
 SELECT COUNT(CUSTOMER_ID) AS NO_CST,REGION_ID
 FROM customer_nodes
 GROUP BY REGION_ID
 ORDER by REGION_ID;
 
 -- How many days on average are customers reallocated to a different node?
 
SELECT AVG(DATEDIFF(start_date,end_date))
FROM customer_nodes
WHERE end_date != '9999-12-31';

-- What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
select distinct
	region_id,
	region_name,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diff)
		OVER (PARTITION BY region_name) AS median,
	PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY diff)
		OVER (PARTITION BY region_name) AS percentile_80,
	PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY diff)
		OVER (PARTITION BY region_name) AS percentile_95
from diff_data
order by region_id;

-- What is the unique count and total amount for each transaction type?
select * FROM customer_transactions;

select txn_type,count(txn_type) as unique_cnt,sum(txn_amount) as total_amount
from customer_transactions
group by txn_type;

-- What is the average total historical deposit counts and amounts for all customers?
select
	n.customer_id,
	t.txn_type,
	count(t.txn_type) count,
	avg(t.txn_amount) total_amount
from customer_transactions t
left join customer_nodes n on t.customer_id = n.customer_id
left join regions r on n.region_id = r.region_id
group by n.customer_id, t.txn_type;

