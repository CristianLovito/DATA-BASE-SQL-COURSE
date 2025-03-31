
SELECT
    p.product_id,
    SUM(CASE WHEN purchase_date BETWEEN start_date AND end_date THEN units  ELSE 0 END)
     / SUM(CASE WHEN purchase_date BETWEEN start_date AND end_date THEN price  ELSE 0 END) AS avg
    

FROM prices p

LEFT JOIN unitsSold u ON p.product_id = u.product_id

GROUP BY product_id