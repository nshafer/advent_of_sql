-- Using the travel_manifests table, extract the passenger information from the
-- XML data and produce a report that shows all of the departure times for
-- "CARGO" vehicles that have more than 20 passengers booked. Include in the
-- results:
--
--     The vehicle_id
--     The departure_time
--     The total number of passengers on that departure
--     Order the results by departure_time.

SELECT * FROM travel_manifests;

SELECT manifest_id, vehicle_id, departure_time, XPATH('//manifest/passengers/passenger/name', manifest_xml)
FROM travel_manifests
ORDER BY vehicle_id, departure_time;

SELECT vehicle_id, departure_time, COUNT(name)
FROM travel_manifests, XMLTABLE('//manifest/passengers/passenger' PASSING manifest_xml COLUMNS name TEXT)
WHERE vehicle_id LIKE 'CARGO-%'
GROUP BY vehicle_id, departure_time
HAVING COUNT(name) > 20
ORDER BY departure_time, vehicle_id