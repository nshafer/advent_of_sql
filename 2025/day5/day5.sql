-- Challenge: Write a query that returns the top 3 artists per user. Order the results by the most played.

SELECT * FROM listening_logs;

SELECT user_name, artist, COUNT(*)
  FROM listening_logs
 GROUP BY user_name, artist
 ORDER BY 1, 3 DESC;

SELECT artist, COUNT(*)
  FROM listening_logs
 WHERE user_name = 'Abigail Hernandez'
 GROUP BY artist
 ORDER BY 2 DESC
 LIMIT 3;

-- Rank results including multiple results for ties
SELECT *
  FROM (SELECT user_name,
               artist,
               COUNT(*) AS count,
               RANK() OVER (
                   PARTITION BY user_name
                   ORDER BY COUNT(*) DESC) AS rank
          FROM listening_logs
         GROUP BY user_name, artist) AS s
 WHERE rank <= 3
 ORDER BY user_name, count DESC;
