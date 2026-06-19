select * from dbo.transactions	



SELECT
	size,
	region,
	product_category,
	COUNT(order_id) as total_returned_orders,
	SUM(CASE WHEN is_returned = 1 THEN CAST(REPLACE(order_value_usd, '$', ' ') AS DECIMAL) ELSE 0 END) as lost_revenue,
	quarter
FROM
	dbo.transactions
WHERE
	is_returned = 1
GROUP BY
	size,
	product_category,
	region,
	quarter
ORDER BY
	product_category DESC,
	total_returned_orders DESC,
	lost_revenue desc

SELECT
    quarter,
    product_category,
    region,
    size,
    COUNT(order_id) AS total_returned_orders,
    SUM(units_ordered) AS total_units_returned,
    -- Revenue impact
    SUM(CAST(REPLACE(order_value_usd, '$', '') AS DECIMAL)) AS lost_revenue_usd,

    -- True cost of returns: you lose revenue AND pay fulfillment twice
    SUM(
        CAST(REPLACE(order_value_usd, '$', '') AS DECIMAL)
        + CAST(fulfillment_cost_usd AS DECIMAL)
    ) AS total_financial_impact_usd,

    -- Margin destroyed
    SUM(CAST(gross_profit_usd AS DECIMAL)) AS gross_profit_wiped_usd,
    ROUND(AVG(CAST(gross_margin_pct AS DECIMAL)), 2) AS avg_margin_pct_on_returned,

    -- Average order value of returns (are high-ticket items being returned?)
    ROUND(
        AVG(CAST(REPLACE(order_value_usd, '$', '') AS DECIMAL))
    , 2) AS avg_returned_order_value_usd

FROM
    dbo.transactions
WHERE
    is_returned = 1
GROUP BY
    quarter,
    product_category,
    region,
    size
ORDER BY
    total_financial_impact_usd DESC