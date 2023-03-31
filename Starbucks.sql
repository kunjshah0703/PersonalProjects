SELECT * FROM drinks_menu
SELECT * FROM nutrition_drinks
SELECT * FROM nutrition_food

/* Return drink name which is having highest amount of protein  */

SELECT Drinks_item, MAX(Protein) AS protein, Calories
FROM nutrition_drinks
GROUP BY Drinks_item, Calories
ORDER BY MAX(Protein) DESC, Calories DESC
-- WHERE Calories = 0

/* Write SQL for food item having max protein and less calorie  */

SELECT Food_item, MIN([ Calories]) AS calories, MAX([ Protein (g)]) AS protein, [ Carb# (g)] 
FROM nutrition_food
GROUP BY Food_item, [ Carb# (g)]
ORDER BY MAX([ Protein (g)]) DESC, MIN([ Calories])

/* Write SQL which returns combo(drink + food) which is having high protein and and high fiber */

WITH high_protein_food_drink
AS
(
SELECT nd.Drinks_item, nf.Food_item
, MAX(nd.Protein) AS nutri_drink_protein
, MAX(nd.[Fiber (g)]) AS nutri_drink_fiber
, MAX(nf.[ Protein (g)]) AS nutri_food_protein
, MAX(nf.[ Fiber (g)]) AS nutri_food_fiber
FROM nutrition_drinks AS nd
INNER JOIN nutrition_food AS nf
ON nd.Calories = nf.[ Calories]
GROUP BY nd.Drinks_item, nf.Food_item)
SELECT Drinks_item, Food_item 
, SUM(nutri_drink_protein) + SUM(nutri_food_protein) AS total_protein
, SUM(nutri_drink_fiber) + SUM(nutri_food_fiber) AS total_fiber
-- , CASE WHEN SUM(nutri_drink_protein) + SUM(nutri_food_protein) > 10 THEN Drinks_item ELSE Food_item END AS prot
FROM high_protein_food_drink
GROUP BY Drinks_item, Food_item
HAVING SUM(nutri_drink_protein) + SUM(nutri_food_protein) > 25 AND SUM(nutri_drink_fiber) + SUM(nutri_food_fiber) > 5
ORDER BY total_fiber DESC

SELECT * FROM drinks_menu

/* Write SQL which returns combo(bev + food) which is having high protein and low trans fat */
SELECT DISTINCT dm.Beverage
, dm.[ Protein (g) ], dm.[Trans Fat (g) ], dm.[Saturated Fat (g)], nf.Food_item, nf.[ Protein (g)]
FROM drinks_menu aS dm
INNER JOIN nutrition_food AS nf
ON dm.Calories = nf.[ Calories]
WHERE dm.Beverage_prep = 'Soymilk' AND dm.[Trans Fat (g) ] < 3 AND dm.[Saturated Fat (g)] < 5
ORDER BY dm.[ Protein (g) ] DESC, nf.[ Protein (g)] DESC