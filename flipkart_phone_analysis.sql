SELECT * FROM flipkart_smartphone;

/* Return top 10 phones with most percentage discount. */

SELECT * FROM(
SELECT TOP (10) brand, model, original_price, discounted_price,Discount_Given
, ROUND(discounted_price/original_price,2) * 100 AS percent_discount
FROM flipkart_smartphone
ORDER BY Discount_Given DESC)A
ORDER BY percent_discount DESC

/* Return that phones whose discountd price is less than 15000 and having rating above 4.5 */

SELECT * FROM flipkart_smartphone

SELECT brand, model,discounted_price, ratings
FROM flipkart_smartphone
WHERE discounted_price <= 15000 AND ratings >= 4.5

/* Smartphones with less rating and most expensive */
WITH cte
AS
(
SELECT brand, model,MAX(discounted_price) AS expensive_phone, MIN(ratings) AS min_rating
FROM flipkart_smartphone
GROUP BY brand, model)
SELECT * FROM cte
ORDER BY min_rating
--WHERE discounted_price <= 15000 AND ratings >= 4.5

/* Return smartphone with ratings more than or equal to 4.5 having good camera and good battery capacity */

SELECT * FROM flipkart_smartphone

WITH cte1
AS
(
SELECT brand, model
, MAX(ratings) AS max_rating, MAX(rear_camera) AS good_rear, MAX(front_camera) AS good_front
,MAX(battery_capacity) AS max_battery_capacity
FROM flipkart_smartphone
GROUP BY brand, model)
SELECT * FROM cte1
ORDER BY max_rating DESC
-- HAVING MAX(ratings)--, MAX(rear_camera), MAX(front_camera),MAX(battery_capacity)

/* Return top 5 most sold brand phones */

SELECT * FROM flipkart_smartphone

SELECT TOP(5) * FROM
(SELECT brand, COUNT(1) AS units_sold
FROM flipkart_smartphone
GROUP BY brand)A
ORDER BY units_sold DESC

/* Return the smartphone with highest storage */

SELECT * FROM flipkart_smartphone

SELECT TOP (1) model, brand, storage
FROM flipkart_smartphone
ORDER BY storage DESC

/* Return the phone with most number of reviews */
SELECT * FROM flipkart_smartphone

WITH cte2
AS
(
SELECT brand, model, reviews
, RANK() OVER(PARTITION BY brand ORDER BY reviews DESC) AS rnk
FROM flipkart_smartphone)
SELECT * FROM cte2
WHERE rnk = 1
-- ORDER BY reviews DESC