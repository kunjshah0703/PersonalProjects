SELECT * FROM sachin_scores;

--WITH cte1
--AS
--(
--SELECT SUM(Innings)AS no_of_inning
--, DATEPART(year, match_date) AS year_of_inning
--FROM sachin_scores
--GROUP BY match_date)
--SELECT year_of_inning 
--, SUM(no_of_inning) OVER(PARTITION BY year_of_inning ORDER BY year_of_inning ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling_sum_inning
--FROM cte1

--SELECT Innings, YEAR(match_date) FROM sachin_scores

/* Q.1 Find total number of innings in a year played by Sachin */
WITH cte2
AS
(
SELECT Innings, YEAR(match_date) AS innings_year
FROM sachin_scores)
SELECT innings_year
, SUM(CASE WHEN innings_year = '2010' THEN Innings ELSE Innings END) AS no_of_innings_in_that_year
FROM cte2
GROUP BY innings_year

/* Q.2 Number of runs scored vs a opposition in a year */

WITH runs_scored
AS
(
SELECT Runs, Versus, Ground
, DATEPART(year, match_date) AS year
FROM sachin_scores)
SELECT Versus, year
, SUM(CASE WHEN Versus = 'Australia' THEN Runs ELSE Runs END) AS runs_scored_vs_opp
FROM runs_scored
GROUP BY Versus, year
ORDER BY Versus

/* Q.3 Find maximum ducks scored in a particlular year */
WITH cte4
AS
(
SELECT COUNT(Match) AS duck
, DATEPART(year, match_date) AS year
FROM sachin_scores
WHERE Runs = 0
GROUP BY match_date)
, cte5
AS
(
SELECT year, SUM(duck) AS ducks
, ROW_NUMBER() OVER(ORDER BY SUM(duck)) AS rn
FROM cte4
GROUP BY year)
SELECT *
FROM cte5
WHERE rn = 12

/* Q.4 Find the milestone innings ex 1000 runs, 5000 runs, 10000 runs */

SELECT * FROM sachin_scores

WITH runs_rolling
AS
(
SELECT Match, Innings, Runs
, SUM(Runs) OVER(ORDER BY Match ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) As rolling_sum
FROM sachin_scores),
mile_cte
AS
(
SELECT 1 AS milestone_number, 1000 AS milestone_runs
UNION ALL
SELECT 2 AS milestone_number, 5000 AS milestone_runs
UNION ALL
SELECT 3 AS milestone_number, 10000 AS milestone_runs
UNION ALL
SELECT 4 AS milestobe_number, 15000 AS milestone_runs
)
SELECT m.milestone_number, m.milestone_runs, MIN(Match) AS milestone_match, MIN(Innings) AS milestone_innings
FROM mile_cte AS m
INNER JOIN runs_rolling AS r
ON r.rolling_sum > m.milestone_runs
GROUP BY m.milestone_number, m.milestone_runs
ORDER BY m.milestone_number