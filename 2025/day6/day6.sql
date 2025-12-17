-- Challenge: Generate a report that returns the dates and families that have no
-- delivery assigned after December 14th, using the families and
-- deliveries_assigned.
--
-- Each row in the report should be a date and family name that represents the
-- dates in which families don't have a delivery assigned yet.
--
-- Label the columns as unassigned_date and name. Order the results by
-- unassigned_date and name, respectively, both in ascending order.

SELECT * FROM families;
SELECT * FROM deliveries_assigned;

  WITH days AS (SELECT n, MAKE_DATE(2025, 12, n) AS date
                  FROM GENERATE_SERIES(15, 31) AS n),

       family_days AS (SELECT d.date AS date, f.id AS family_id, f.family_name
                         FROM days d,
                              families f)

SELECT fd.date AS unassigned_date, fd.family_name AS name
  FROM family_days fd
           LEFT JOIN deliveries_assigned a
                     ON fd.date = a.gift_date AND fd.family_id = a.family_id
 WHERE a.gift_date IS NULL
 ORDER BY fd.date, fd.family_name;
