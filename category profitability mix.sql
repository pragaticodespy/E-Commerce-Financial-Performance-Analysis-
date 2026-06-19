--- category profitability on product mix

select * from dbo.transactions
SELECT
	product_category,
	COUNT(order_id) as total_orders,
	ROUND(SUM(gross_profit_usd), 0) as gross_profit,
	ROUND(AVG(gross_margin_pct), 2) as avg_gross_margin_pct,
	ROUND(SUM(manufacturing_cost_usd) / SUM(order_value_usd) *100, 1) as avg_mfg_cost_pct_revenue,
	ROUND(AVG(is_returned) * 100, 2) as return_rate_pct
FROM
	dbo.transactions
GROUP BY
	product_category
ORDER BY
	gross_profit DESC
	
SELECT
    product_category,
    ROUND(SUM(gross_profit_usd), 0) AS gross_profit,
    ROUND(AVG(gross_margin_pct), 2) AS avg_gross_margin_pct,
    ROUND(SUM(manufacturing_cost_usd)
          / SUM(order_value_usd) * 100, 1) AS mfg_cost_pct_revenue,
    ROUND(SUM(is_returned) * 100/COUNT(order_id), 1) AS return_rate_pct
FROM
    dbo.transactions
GROUP BY
    product_category
ORDER BY
    gross_profit DESC;