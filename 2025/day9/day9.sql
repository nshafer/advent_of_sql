-- Build a report using the orders table that shows the latest order for each
-- customer, along with their requested shipping method, gift wrap choice (as
-- true or false), and the risk flag in separate columns.
--
-- Order the report by the most recent order first so Evergreen Market can reach
-- out to them ASAP.

SELECT * FROM orders;
SELECT COUNT(DISTINCT customer_id) FROM orders;

WITH latest_order AS (SELECT id,
                             customer_id,
                             created_at,
                             order_data,
                             ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_at DESC) AS row_number
                      FROM orders)
SELECT customer_id,
       created_at,
       order_data -> 'shipping' ->> 'method' AS shipping_method,
       (order_data -> 'gift' ->> 'wrapped')::BOOLEAN AS gift_wrapped,
       order_data -> 'risk' ->> 'flag' AS risk_flag,
       order_data
FROM latest_order
WHERE row_number = 1
ORDER BY created_at DESC;
