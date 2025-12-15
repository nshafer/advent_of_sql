-- Using the official_shifts and last_minute_signups tables, create a combined
-- de-duplicated volunteer list.
--
-- Ensure the list has standardized role labels of Stage Setup, Cocoa Station,
-- Parking Support, Choir Assistant, Snow Shoveling, Handwarmer Handout.
--
-- Make sure that the timeslot formats follow John's official shifts format.

SELECT * FROM official_shifts ORDER BY volunteer_name;
SELECT * FROM last_minute_signups ORDER BY volunteer_name;

  WITH merged AS
           (SELECT COALESCE(o.volunteer_name, l.volunteer_name) AS volunteer,
                   COALESCE(o.role, l.assigned_task)            AS role,
                   COALESCE(o.shift_time, l.time_slot)          AS shift
              FROM official_shifts o
                       FULL JOIN last_minute_signups l USING (volunteer_name)
             ORDER BY volunteer)

SELECT DISTINCT volunteer,
                CASE
                    WHEN role ILIKE '%stage%' THEN 'Stage Setup'
                    WHEN role ILIKE '%cocoa%' THEN 'Cocoa Station'
                    WHEN role ILIKE '%park%' THEN 'Parking Support'
                    WHEN role ILIKE '%choir%' THEN 'Choir Assistant'
                    WHEN role ILIKE '%shovel%' THEN 'Snow Shoveling'
                    WHEN role ILIKE '%hand%' THEN 'Handwarmer Handout'
                    WHEN TRUE THEN CONCAT('UNCAUGHT_ROLE: ', role)
                    END AS role,
                CASE
                    WHEN shift ILIKE '10%am%' THEN '10:00 AM'
                    WHEN shift ILIKE 'noon' THEN '12:00 PM'
                    WHEN shift ILIKE '12%pm%' THEN '12:00 PM'
                    WHEN shift ILIKE '2%pm%' THEN '2:00 PM'
                    WHEN TRUE THEN CONCAT('UNCAUGHT_SHIFT_TIME: ', shift)
                    END AS shift
  FROM merged
 ORDER BY volunteer


