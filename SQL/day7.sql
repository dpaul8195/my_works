USE windows;

SELECT *,
AVG(marks) OVER (PARTITION BY branch) AS branch_avg
FROM marks;

SELECT *,
MAX(marks) OVER w AS branch_max,
MIN(marks) OVER w AS branch_min,
ROUND(AVG(marks) OVER w, 2) AS branch_avg
FROM marks
WINDOW w AS (PARTITION BY branch);

SELECT *
FROM
(
	SELECT *,
	AVG(marks) OVER(PARTITION BY branch) AS branch_avg
	FROM marks
) T
WHERE marks > branch_avg;

SELECT *,
ROW_NUMBER() OVER(ORDER BY student_id) AS row_numbers,
RANK() OVER(PARTITION BY branch ORDER BY marks) AS ranks,
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks) AS dense_ranks,
CONCAT(name, '-', ROW_NUMBER() OVER(ORDER BY student_id)) AS roll
FROM marks
ORDER BY student_id;

SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS topper
FROM marks;

SELECT *,
FIRST_VALUE(name) OVER w AS topper,
LAST_VALUE(name) OVER w AS failure,
NTH_VALUE(name, 2) OVER w AS second_topper
FROM marks
WINDOW w AS (PARTITION BY branch
	ORDER BY marks
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
    
SELECT
MONTH(date) AS months,
SUM(amount) AS total,
LAG(SUM(amount), 1, 0) OVER() AS prev_total,
((SUM(amount) - LAG(SUM(amount), 1, 0) OVER()) / SUM(amount)) * 100 AS growth
FROM orders
GROUP BY MONTH(date);

USE first;

SELECT *
FROM 
(
	SELECT batter, BattingTeam, SUM(batsman_run) AS runs,
    DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS ranks
	FROM ipl
	GROUP BY BattingTeam, batter
) T
WHERE ranks <= 5;

SELECT ID, SUM(batsman_run) AS runs,
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_avg,
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS avgerage
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;

SELECT innings, batter, SUM(batsman_run) AS runs,
(SUM(batsman_run) / SUM(SUM(batsman_run)) OVER (PARTITION BY innings)) * 100 AS percentage,
SUM(SUM(batsman_run)) OVER (PARTITION BY innings) AS total_in_match
FROM ipl
WHERE ID = 1178429
GROUP BY batter, innings;

USE windows;

SELECT *,
CASE
	WHEN sections = 1 THEN 'BEST'
    WHEN sections = 2 THEN 'GOOD'
    WHEN sections = 3 THEN 'WORST'
	ELSE 'OUTLIER'
END AS performance
FROM
(
	SELECT *,
	NTILE(3) OVER(ORDER BY marks DESC) AS sections
	FROM marks
    ORDER BY student_id
) t;

SELECT *,
CUME_DIST() OVER(PARTITION BY branch ORDER BY marks) AS cum_dist
FROM marks;

USE first;

SELECT BattingTeam, batter, ranks
FROM
(
	SELECT BattingTeam, batter, SUM(batsman_run) AS runs,
    DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS ranks
	FROM ipl
	GROUP BY BattingTeam, batter
) t
WHERE ranks <= 5;

SELECT
ROW_NUMBER() OVER(ORDER BY ID) AS match_no, runs,
SUM(runs) OVER(ORDER BY ID) AS cum_sum
FROM
(
	SELECT ID, SUM(batsman_run) AS runs
	FROM ipl
	WHERE batter = 'V Kohli'
	GROUP BY ID
) T;

WITH T AS
(
	SELECT bowler, COUNT(*) AS balls
	FROM ipl
	GROUP BY bowler
)

SELECT T.bowler, T.balls, d.dot
FROM
(
	SELECT bowler, COUNT(*) AS dot
	FROM ipl 
	WHERE batsman_run = 0
	GROUP BY bowler
) d
JOIN T
ON T.bowler = d.bowler;

SELECT bowler,
COUNT(*) AS balls,
SUM(CASE WHEN batsman_run = 0 THEN 1 ELSE 0 END) AS dots
FROM ipl
GROUP BY bowler;

SELECT ID, SUM(batsman_run) AS runs,
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID;

SELECT batter, COUNT(*) AS num_matches,
AVG(runs) AS average
FROM
(
	SELECT ID, batter, SUM(batsman_run) AS runs
	FROM ipl
	GROUP BY ID, batter
) t
GROUP BY batter
HAVING COUNT(*) > 20
ORDER BY AVG(runs) DESC;

SELECT *,
NTILE(10) OVER(ORDER BY runs DESC) AS category
FROM
(
	SELECT batter, SUM(batsman_run) AS runs
	FROM ipl
	GROUP BY batter
) T