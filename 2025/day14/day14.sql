-- Using the mountain network data, find all possible routes from Jake’s Lift to
-- Maverick, no matter how long or winding, so the group can split up based on
-- how much skiing they want to do.
--
-- Find all the possible routes from Jake's Lift to Maverick. None of the
-- possible routes will take more than 12 connections.

SELECT * FROM mountain_network;
SELECT * FROM mountain_network WHERE from_node = 'Jake''s Lift';
SELECT * FROM mountain_network WHERE from_node = 'Wildwood Lift';
SELECT * FROM mountain_network WHERE from_node = 'Sidewinder';

  WITH RECURSIVE net AS (
      SELECT 'Jake''s Lift' AS path, 'Jake''s Lift' AS last, 1 AS count
       UNION ALL
      SELECT n.path || ' -> ' || m.to_node ||
             CASE WHEN m.node_type = 'Trail' THEN ' (' || m.difficulty || ')' ELSE '' END,
             m.to_node,
             n.count + 1
        FROM net n, mountain_network m
       WHERE n.last = m.from_node
         AND n.count < 12
         AND n.path NOT LIKE '%' || m.to_node || '%'
  )

SELECT *
  FROM net
 WHERE last = 'Maverick';