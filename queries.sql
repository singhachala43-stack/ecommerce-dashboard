SELECT * FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_orders_dataset;

SELECT order_status, COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status;

SELECT ROUND(SUM(price + freight_value), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o 
ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';

SELECT 
  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS monthly_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi 
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;

SELECT 
  p.product_category_name,
  COUNT(oi.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p 
ON oi.product_id = p.product_id
JOIN olist_orders_dataset o 
ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


SELECT 
  c.customer_id,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS lifetime_spend,
  CASE 
    WHEN SUM(oi.price + oi.freight_value) > 500 THEN 'High Value'
    WHEN SUM(oi.price + oi.freight_value) BETWEEN 200 AND 500 THEN 'Mid Value'
    ELSE 'Low Value'
  END AS customer_segment
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_id
ORDER BY lifetime_spend DESC
LIMIT 20;









