/* Q.1 Count of resturants delivering online orders */
SELECT * FROM zomato_cleaned;

WITH yes AS
(
SELECT COUNT(Online_Orders) AS online_yes
FROM zomato_cleaned
WHERE Online_Orders='Yes'
),
no AS
(
SELECT COUNT(Online_Orders) AS online_no
FROM zomato_cleaned
WHERE Online_Orders='No'
)
SELECT y.*, n.*
FROM yes AS y, no AS n
-- GROUP BY name
-- HAVING COUNT(Online_Orders) = 'Yes'

/* Q.2 Count of resturants allowing table bookings and not having phone number. */
SELECT COUNT(DISTINCT name) AS resto_take_book_table
FROM zomato_cleaned
WHERE Book_Table = 'Yes' AND Phone IS NULL;

SELECT TOP(10) *
FROM zomato_cleaned

/* Q.3 Count of resturants in a location having ratings less than 3 and type of rest which is casual dining.*/
SELECT Name, Rate
FROM zomato_cleaned
WHERE City = 'Church Street' AND Rate <= 3 AND Rest_Type = 'Casual Dining';

/* Q.4 Relationship between resto and rating.*/

SELECT TOP(10) *
FROM zomato_cleaned

SELECT DISTINCT Name, Rate, Approx_Cost
FROM(
SELECT TOP(20) Name, Rate, Approx_Cost
FROM zomato_cleaned
WHERE City = 'Church Street'
ORDER BY Rate DESC, Approx_Cost) A
;

/* Q.5  Number of resto in Church Street which are Pubs and bars, rate > 3 , votes > 200 , cusines is cafe
and location is MG road*/
SELECT TOP(10) *
FROM zomato_cleaned

SELECT DISTINCT Name, Rest_Type, Rate
FROM zomato_cleaned
WHERE Rest_Type = 'Food Court' AND Rate>=4

SELECT DISTINCT Name, Rate, Votes, Cuisines
FROM zomato_cleaned
WHERE City = 'Church Street' AND Location = 'MG road' AND Rate >= 3 AND Votes > 200 AND Cuisines IN ('Cafe')
AND Rest_Type = 'Bar';

/* Q.6 Top rated resto in Bangalore */

WITH high_rank
AS
(
SELECT DISTINCT Name, Rate,
RANK() OVER(ORDER BY Rate DESC) AS rnk
FROM zomato_cleaned)
SELECT * FROM high_rank WHERE rnk = 1

/* Q.7 Types of restos in Bangalore */

SELECT TOP(10) *
FROM zomato_cleaned


--SELECT Rest_Type,COUNT(DISTINCT 1)
--FROM zomato_cleaned
--GROUP BY Rest_Type

SELECT Rest_Type
FROM zomato_cleaned
CROSS APPLY STRING_SPLIT(Rest_Type, ',') AS 




