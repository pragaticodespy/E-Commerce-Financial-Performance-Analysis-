select*from dbo.transactions
---revenue margin by year
SELECT
	year,
	COUNT(order_value_usd) AS total_orders,
	ROUND(SUM(order_value_usd), 0) AS total_revenue,
	ROUND(SUM(gross_profit_usd), 0) as gross_profit,
	ROUND(AVG(gross_margin_pct), 2) as avg_gross_margin_pct,
	ROUND(SUM(total_cogs_usd), 0) as total_cogs
FROM
	dbo.transactions
GROUP BY
	year
ORDER BY
	year;