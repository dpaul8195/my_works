USE first;

SELECT * FROM ipl;

SELECT DISTINCT batter FROM ipl
WHERE batter IN ("V Kohli", "AB de Villiers");

UPDATE ipl
SET batter = "ABD"
WHERE batter = "AB de Villiers";

DELETE FROM ipl
WHERE BattingTeam = "Rajasthan Royals";

SELECT COUNT(*) FROM ipl;

SELECT batter, SUM(batsman_run) AS runs FROM ipl
GROUP BY batter
ORDER BY runs DESC;

SELECT * FROM ipl
WHERE total_run = (
	SELECT MAX(total_run) FROM ipl
);

SELECT CONCAT(CONCAT(batter, "-"), bowler) AS batter_bowler FROM ipl;

SELECT NOW();

SELECT CURDATE();

SELECT * FROM
(SELECT batter, COUNT(*) AS match_num, AVG(batsman_run) FROM ipl
GROUP BY batter) AS sub_ipl
WHERE match_num >= 50;

SELECT COUNT(*) FROM ipl
GROUP BY ID;

SELECT batter, SUM(batsman_run) AS runs_per_match FROM ipl
WHERE ID = 1304113
GROUP BY batter;

SELECT ID, batter, COUNT(*) FROM ipl
GROUP BY ID, batter;

USE first;

SELECT batter, SUM(batsman_run) AS runs FROM ipl
GROUP BY batter
ORDER BY runs DESC
LIMIT 5;

SELECT bowler, SUM(isWicketDelivery) total_wickets FROM ipl
GROUP BY bowler
ORDER BY total_wickets DESC;

SELECT batter, SUM(batsman_run) AS total_runs, COUNT(*) AS balls FROM ipl
GROUP BY batter
ORDER BY total_runs DESC,balls ASC;

SELECT batter, SUM(batsman_run) AS total_runs
FROM ipl
GROUP BY batter;

SELECT COUNT(*) AS total_match FROM
(SELECT DISTINCT ID
FROM ipl
WHERE batter = "WP Saha") AS SAHA;

SELECT bowler, SUM(isWicketDelivery) total_wickets, COUNT(*) AS balls
FROM ipl
WHERE overs >= 16
GROUP BY bowler
ORDER BY total_wickets DESC, balls ASC
LIMIT 5;

SELECT batter, COUNT(DISTINCT bowler) num_bowlers
FROM ipl
WHERE isWicketDelivery = 1
GROUP BY batter
ORDER BY num_bowlers DESC;

SELECT * FROM
(SELECT batter, COUNT(*) AS balls, SUM(batsman_run) AS runs, (SUM(batsman_run) / COUNT(*)) * 100 AS strike_rate
FROM ipl
WHERE bowler = "TA Boult"
GROUP BY batter
ORDER BY strike_rate DESC) AS sub
WHERE runs >=20;

SELECT batter, COUNT(*) AS sixes
FROM ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY sixes DESC;

SELECT overs, COUNT(*) AS balls, SUM(total_run) AS runs
FROM ipl
GROUP BY overs
ORDER BY runs DESC
LIMIT 5;

SELECT * FROM ipl;

SELECT ID, overs, SUM(total_run) AS runs, innings
FROM ipl
GROUP BY ID, overs, innings
ORDER BY runs DESC
LIMIT 5;

SELECT kind, COUNT(*) AS numbers FROM ipl
WHERE kind NOT IN ('NA')
GROUP BY kind
ORDER BY numbers DESC;

USE first;

SELECT bowler, COUNT(*) AS dot_balls
FROM ipl
WHERE batsman_run = 0
GROUP BY bowler
ORDER BY dot_balls DESC;

SELECT bowler, COUNT(*) AS num_times
FROM ipl
WHERE batter = "V Kohli" AND isWicketDelivery = 1
GROUP BY bowler
ORDER BY num_times DESC
LIMIT 5;

SELECT ID, SUM(batsman_run) AS runs, overs, innings
FROM ipl
GROUP BY ID, overs, innings
ORDER BY runs DESC;

SELECT batter, AVG(runs) AS average
FROM
(SELECT ID, batter, SUM(batsman_run) AS runs
FROM ipl
GROUP BY ID, batter) AS T
GROUP BY batter
ORDER BY average DESC;

SELECT *
FROM
(SELECT bowler, SUM(batsman_run) AS runs, COUNT(*) / 6 AS play, SUM(batsman_run) / (COUNT(*) / 6) AS economy
FROM ipl
WHERE overs < 6
GROUP BY bowler
ORDER BY runs) AS T
WHERE play > 20
ORDER BY economy;

