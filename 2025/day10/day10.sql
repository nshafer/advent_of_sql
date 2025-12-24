-- Clean-up the deliveries table to remove any records where the
-- delivery_location is 'Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse',
-- 'The Vibes'.

-- Move those records to the misdelivered_presents with all the same columns as
-- deliveries plus a flagged_at column with the current time and a reason column
-- with "Invalid delivery location" listed as the reason for each moved record.

-- Make sure your final step shows the misdelivered_presents records that you
-- just moved (i.e. don't include any existing records from the
-- misdelivered_presents table).

SELECT * FROM deliveries;
SELECT * FROM misdelivered_presents;
SELECT COUNT(*) FROM deliveries UNION SELECT COUNT(*) FROM misdelivered_presents;

WITH invalid AS (
    DELETE
        FROM deliveries
            WHERE delivery_location IN ('Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse', 'The Vibes')
            RETURNING *)
INSERT
INTO misdelivered_presents
SELECT *, NOW() AS flagged_at, 'Invalid delivery location' AS reason
FROM invalid
RETURNING *;
