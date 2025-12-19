-- Challenge: Generate a report, using the products and price_changes tables for
-- leadership that returns the product_name, current_price, previous_price, and
-- the difference between the current and previous prices.

SELECT * FROM products;
SELECT * FROM price_changes;

WITH prices AS (SELECT product_id,
                       price AS current_price,
                       LEAD(price) OVER products_desc AS previous_price,
                       ROW_NUMBER() OVER products_desc AS row_number
                FROM price_changes
                WINDOW products_desc AS (PARTITION BY product_id ORDER BY effective_timestamp DESC)
                ORDER BY product_id, effective_timestamp)

SELECT p.product_name,
       pr.current_price,
       pr.previous_price,
       pr.current_price - pr.previous_price AS price_difference
FROM products p
         LEFT JOIN prices pr
                   ON p.product_id = pr.product_id
WHERE pr.row_number = 1
ORDER BY p.product_name;