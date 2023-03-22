SELECT * FROM video_game_analysis;

/* Q.1 Number of Total Video games developed by a company in a year & total number of video games released in 
a year ? */

SELECT Publisher, COUNT(Name) AS no_of_games_published, Year
FROM video_game_analysis
GROUP By Publisher, Year
ORDER BY Year DESC;

/* Q.2 Which game has a highest score in a particular year */

WITH high_rank
AS
(
SELECT Name, Year, User_Score,
RANK() OVER(PARTITION BY Year ORDER BY Year DESC, User_Score DESC) AS rnk
FROM video_game_analysis
--ORDER BY Year DESC, User_Score DESC
)
SELECT * FROM high_rank WHERE rnk = 1

/* Sum of total shipped in a particular year by a publisher*/

WITH high_profit
AS
(
SELECT Publisher, Year, SUM(Total_Shipped) AS total_profit,
RANK() OVER(PARTITION BY Year ORDER BY Year DESC, SUM(Total_Shipped) DESC) AS rnk
FROM video_game_analysis
GROUP BY Publisher, Year)
SELECT * FROM high_profit WHERE rnk = 1 ORDER BY Year DESC
-- ORDER BY Publisher, Year DESC

--SELECT Publisher, Total_Shipped, Year
--FROM video_game_analysis
--WHERE Publisher = 'Atlus' AND Year = '2020'