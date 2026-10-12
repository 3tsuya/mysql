// 第２問
SELECT flight.flightno,
       airline.airlinename
FROM flight
JOIN airline
    ON flight.airline_id = airline.airline_id
WHERE flight.`from` = (
    SELECT airport_id
    FROM airport
    WHERE iata = 'JFK'
);

//第３問
SELECT flight.flightno, 
       departure.name AS departure_airport,
       arrival.name AS arrival_airport
FROM flight
JOIN airport AS departure
    ON flight.`from` = departure.airport_id
JOIN airport AS arrival
    ON flight.`to` = arrival.airport_id;

//第４問
SELECT passenger.passenger_id, 
       passenger.lastname,
       passenger.firstname
From passenger
LEFT JOIN  booking
    ON passenger.passenger_id = booking.passenger_id
WHERE booking.passenger_id IS NULL;

//第5問
SELECT airline.airlinename, 
       COUNT(flight.flightno) AS flight_count
FROM airline
JOIN flight
    ON airline.airline_id = flight.airline_id
GROUP BY airline.airlinename
HAVING COUNT(flight.flightno) > 50;

//第６問
SELECT flight.flightno,
       SUM(booking.price) AS total_sales
FROM booking
JOIN flight
    ON booking.flight_id = flight.flight_id
GROUP BY flight.flightno
ORDER BY total_sales DESC
LIMIT 5;

//第７問
SELECT flight.flightno,
       CASE
           WHEN departure_airport.country = arrival_airport.country
           THEN '国内線'
           ELSE '国際線'
       END AS flight_type
FROM flight
JOIN airport_geo AS departure_airport
    ON flight.`from` = departure_airport.airport_id
JOIN airport_geo AS arrival_airport
    ON flight.`to` = arrival_airport.airport_id;

//第８問
SELECT airline.airlinename,
       AVG(booking.price) AS average_ticket_price
FROM airline
JOIN flight
    ON airline.airline_id = flight.airline_id
JOIN booking
    ON flight.flight_id = booking.flight_id
GROUP BY airline.airlinename
HAVING AVG(booking.price) > 250.00;

//第９問
SELECT DISTINCT airline.airlinename
FROM airline
JOIN flight
    ON airline.airline_id = flight.airline_id
JOIN airport_geo
    ON flight.`from` = airport_geo.airport_id
WHERE airport_geo.country = 'Japan';

//第１０問
SELECT airport_geo.name,
    COUNT(DISTINCT departure.flight_id) AS departure_count,
    COUNT(DISTINCT arrival.flight_id) AS arrival_count
FROM airport_geo
LEFT JOIN flight AS departure
    ON airport_geo.airport_id = departure.`from`
LEFT JOIN flight AS arrival
    ON airport_geo.airport_id = arrival.`to`
GROUP BY airport_geo.airport_id, airport_geo.name;

//第１１問
SELECT airline.airlinename,
       SUM(
           CASE
               WHEN departure_airport.country = arrival_airport.country
               THEN 1
               ELSE 0
           END
       ) AS domestic_count,
       SUM(
           CASE
               WHEN departure_airport.country <> arrival_airport.country
               THEN 1
               ELSE 0
           END
       ) AS international_count
FROM airline
JOIN flight
    ON airline.airline_id = flight.airline_id
JOIN airport_geo AS departure_airport
    ON flight.`from` = departure_airport.airport_id
JOIN airport_geo AS arrival_airport
    ON flight.`to` = arrival_airport.airport_id
GROUP BY airline.airlinename
ORDER BY international_count DESC;


