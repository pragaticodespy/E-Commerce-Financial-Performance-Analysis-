--discount impact on margin
SELECT
    discount_applied,
    COUNT(order_id)                              AS total_orders,
    ROUND(AVG(CAST(REPLACE(order_value_usd,'$','') AS DECIMAL)), 2)
                                                 AS avg_order_value,
    ROUND(AVG(discount_pct) * 100, 2)            AS avg_discount_pct,
    ROUND(AVG(gross_margin_pct), 2)              AS avg_gross_margin_pct,
    ROUND(SUM(gross_profit_usd), 0)              AS total_gross_profit,
    ROUND(SUM(is_returned) * 100.0/COUNT(order_id), 2)           AS return_rate_pct,
    ROUND(
        SUM(CAST(REPLACE(order_value_usd,'$','') AS DECIMAL)),0
    )                                            AS total_revenue
FROM dbo.transactions
GROUP BY discount_applied
ORDER BY discount_applied;

exec sp_help transactions

select*from transactions