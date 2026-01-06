-- They remember this happened once before, but the exact steps are fuzzy:
--
--     “When we moved the incoming records into the system table, some columns
--     just… appeared. It was magical.”
--
--     “The system kept throwing errors until we figured out how to handle
--     duplicates. Whatever you do the records already in system_dispatches must
--     take precedence.”
--
--     “To get the phrase, we had to find the most recent dispatch per system
--     but only from the primary source.”
--
--     “Once we had the phrase, Santa entered it into the sleigh… and liftoff
--     was perfect.”
--
-- Reconstruct the final confirmation phrase to text Santa based on the elves’
-- hazy recollection of how they solved this problem before.
--
-- Your final result should include the marker_letter for each system, using
-- only the most recent dispatch from a primary source. Once the correct
-- dispatch has been identified for every system, combine the results and order
-- them by dispatched_at in ascending order to reveal the confirmation phrase.
--
-- The sleigh won’t launch without it.

SELECT * FROM incoming_dispatches ORDER BY system_id, dispatched_at;
SELECT * FROM system_dispatches ORDER BY system_id, dispatched_at;

-- Process incoming dispatches
  WITH incoming AS (
      DELETE FROM incoming_dispatches
          RETURNING system_id, dispatched_at, payload
  )

INSERT
  INTO system_dispatches
      (system_id, dispatched_at, payload)
SELECT *
  FROM incoming
    ON CONFLICT DO NOTHING;

-- Generate the confirmation phrase
  WITH latest_systems AS (
      SELECT system_id,
             dispatched_at,
             marker_letter,
             ROW_NUMBER() OVER (PARTITION BY system_id ORDER BY dispatched_at DESC) AS num
        FROM system_dispatches
       WHERE payload ->> 'source' = 'primary'
  )

SELECT STRING_AGG(marker_letter, '' ORDER BY dispatched_at)
  FROM latest_systems
 WHERE num = 1
 GROUP BY num;