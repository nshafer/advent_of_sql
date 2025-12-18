-- Challenge: Get the stewards a list of all the passengers and the cocoa car(s)
-- they can be served from that has at least one of their favorite mixins.

-- Remember only the top three most-stocked cocoa cars remained operational, so
-- the passengers must be served from one of those cars.

SELECT * FROM passengers;

SELECT * FROM cocoa_cars;

  WITH remaining_cars AS (SELECT * FROM cocoa_cars ORDER BY total_stock DESC LIMIT 3)
SELECT p.passenger_name,
       ARRAY_AGG(c.car_id ORDER BY RANDOM()) AS available_cars
  FROM passengers p
           INNER JOIN remaining_cars c
                      ON p.favorite_mixins && c.available_mixins
 GROUP BY p.passenger_name
 ORDER BY p.passenger_name;

