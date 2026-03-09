-- SQL Business Analysis
-- SQL dialect: PostgreSQL

-- 1. Monthly revenue trend
SELECT DATE_TRUNC('month', CAST(order_date AS DATE)) AS month,
       ROUND(SUM(revenue), 2) AS total_revenue
FROM orders
GROUP BY 1
ORDER BY 1;

-- 2. Top customer segments by revenue
SELECT c.segment,
       ROUND(SUM(o.revenue), 2) AS total_revenue,
       COUNT(DISTINCT o.customer_id) AS customers
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 2 DESC;

-- 3. Product category performance
SELECT p.category,
       SUM(o.quantity) AS units_sold,
       ROUND(SUM(o.revenue), 2) AS revenue,
       ROUND(AVG(o.discount_pct), 2) AS avg_discount
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY 1
ORDER BY 3 DESC;

-- 4. Customer lifetime value
SELECT o.customer_id,
       ROUND(SUM(o.revenue), 2) AS lifetime_value,
       COUNT(*) AS orders_count
FROM orders o
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
