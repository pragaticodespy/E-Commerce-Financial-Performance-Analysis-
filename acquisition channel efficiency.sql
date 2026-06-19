--Acquisition Channel Efficiency

SELECT
	acquisition_channel,
	COUNT(order_id) AS total_orders,
	ROUND(AVG(order_value_usd), 0) AS avg_order_value,
	ROUND(SUM(gross_profit_usd), 0) AS total_gross_profit,
	ROUND(AVG(gross_margin_pct), 2) as avg_margin_pct,
	ROUND(SUM(is_returned) * 100 / COUNT(order_id), 3) as return_rate_pct,
	ROUND(SUM(CASE WHEN is_returned = 0 THEN gross_profit_usd ELSE -fulfillment_cost_usd END), 0) as net_profit_after_returns

FROM
	dbo.transactions
GROUP BY
	acquisition_channel
ORDER BY
	net_profit_after_returns DESC;