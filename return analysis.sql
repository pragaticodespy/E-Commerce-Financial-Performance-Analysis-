SELECT
	product_category,
	region,
	acquisition_channel,
	count(order_id) as total_returns,
	sum(units_ordered) as total_units_returned
FROM
	dbo.transactions
WHERE
	is_returned = 1
GROUP BY
	product_category,
	acquisition_channel,
	region
ORDER BY
	product_category DESC


SELECT
	region,
	product_category,
	acquisition_channel,
	COUNT(order_id) as total_returns,
	SUM(units_ordered) as total_units_returned,
	ROUND(AVG(is_returned * 100.0), 2) as return_rate_pct,
	SUM(CASE WHEN is_returned = 1 then CAST(REPLACE(order_value_usd, '$', ' ') AS DECIMAL) ELSE 0 END) as lost_revenue_usd,
	AVG(gross_margin_pct) as margin_erosion
FROM
	dbo.transactions
GROUP BY
	 product_category,
	 acquisition_channel,
	 region
ORDER BY
	return_rate_pct DESC
