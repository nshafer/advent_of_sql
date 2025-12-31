-- Calculate the 7-day rolling average behavior score for each child. Identify
-- any child whose rolling average drops below 0. For those children with a
-- rolling average below 0, return the child_id, child_name, behavior_date (this
-- will be the latest date in the 7-day rolling average), and the calculated
-- 7-day rolling average. Only include results with a behavior_date of December
-- 7, 2025 or later, ensuring that each rolling average is based on a full 7
-- days of data.
--
-- Order the results by behavior_date and then child_name.

SELECT * FROM behavior_logs;

WITH averages AS (SELECT *, AVG(score) OVER w AS rolling_average
                  FROM behavior_logs
                  WINDOW w AS (PARTITION BY child_id ORDER BY behavior_date ROWS 6 PRECEDING)
                  ORDER BY child_id, behavior_date)

SELECT child_id, child_name, behavior_date, rolling_average
FROM averages
WHERE behavior_date >= '2025-12-07'
  AND rolling_average < 0
ORDER BY behavior_date, child_name;