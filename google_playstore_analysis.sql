/* Number of apps having category as Communication and installs greater than 100000+ and positive
sentiments*/

SELECT * FROM google_play_apps_review;
SELECT * FROM google_play_user_review;

SELECT COUNT(DISTINCT gp.App) AS no_of_apps, gp.Category, gp.Installs, gu.Sentiment
FROM google_play_apps_review AS gp
LEFT JOIN google_play_user_review AS gu
ON gp.App = gu.App
WHERE gp.Category = 'COMMUNICATION' AND gp.Installs > 100000 AND gu.Sentiment = 'Positive'
GROUP BY gp.Category, gp.Installs, gu.Sentiment;

/* Number of Apps having sold price > 0 and content rating is teen and having negative sentiment */

SELECT gp.App,COUNT(gp.App) AS total_number_of_users, gp.[Content Rating], gp.Price, gu.Sentiment
FROM google_play_apps_review AS gp
INNER JOIN google_play_user_review AS gu
ON gp.App = gu.App
WHERE Price > 0 AND [Content Rating] = 'Teen' AND gu.Sentiment = 'Negative'
GROUP BY gp.App, gp.[Content Rating], gp.Price, gu.Sentiment

/* Find that app which is having rating greater than 4, type is free, reviews greater than 2000 and 
sentiment is positive and current version and genre ?*/

WITH high_review
AS
(
SELECT App, Rating, Reviews, Type, [Current Ver], Genres,
RANK() OVER(ORDER BY Reviews DESC) AS rnk
FROM google_play_apps_review
WHERE Rating > 4 AND Reviews > 2000 AND Type = 'Free'
)
-- SELECT * FROM high_review WHERE rnk < 11
SELECT DISTINCT hr.App,hr.*, gu.Sentiment
FROM high_review AS hr
INNER JOIN google_play_user_review AS gu
ON hr.App = gu.App
WHERE hr.rnk < 11 AND gu.Sentiment = 'Positive';