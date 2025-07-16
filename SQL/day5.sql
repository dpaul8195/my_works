USE first;

SELECT batter, SUM(batsman_run)
FROM ipl
GROUP BY batter
HAVING SUM(batsman_run) >
	(SELECT SUM(batsman_run)
	FROM ipl
	WHERE batter = "V Kohli");
    
SELECT DISTINCT batter
FROM ipl
WHERE bowler IN
	(SELECT DISTINCT bowler
	FROM ipl
    WHERE batter = "V kohli");

SELECT bowler, SUM(batsman_run) AS runs, COUNT(isWicketDelivery) AS wicket, SUM(batsman_run) / COUNT(isWicketDelivery) AS avg_
FROM
	(SELECT *
	FROM ipl
	WHERE overs >= 16) T
GROUP BY bowler
HAVING COUNT(isWicketDelivery) > 10
ORDER BY avg_ DESC;

SELECT ID, overs, SUM(batsman_run) AS runs
FROM ipl
GROUP BY ID, overs;

SELECT batter, COUNT(*) AS times
FROM ipl
WHERE isWicketDelivery = 1
GROUP BY batter;

SELECT batter, 
	(
		SELECT COUNT(*)
        FROM ipl
		WHERE batter = s.batter AND isWicketDelivery = 1
    ) AS times
FROM
	(
		SELECT DISTINCT batter FROM ipl
	) s;
    
SHOW CREATE TABLE movies;

SELECT name, score
FROM movies
WHERE score = (
	SELECT MAX(score)
    FROM movies
);

SELECT name, profit
FROM
(
	SELECT name, gross - budget AS profit
	FROM movies
) T
WHERE profit = (
	SELECT MAX(profit)
    FROM 
    (
	SELECT name, gross - budget AS profit
	FROM movies
	) T
);

SELECT name, gross - budget AS profit
FROM movies
WHERE gross - budget = (
	SELECT MAX(gross - budget)
    FROM movies
);

SELECT name, score
FROM movies
WHERE score >(
	SELECT AVG(score)
    FROM movies
);

SELECT * 
FROM movies
WHERE score = (
	SELECT MAX(score)
    FROM movies
    WHERE year = 2000
);

SELECT *
FROM movies
WHERE score = (
	SELECT MAX(score)
    FROM movies
    WHERE votes > (
		SELECT AVG(votes)
        FROM movies
    )
);

WITH T AS
(
	SELECT director
	FROM movies
	GROUP BY director
	ORDER BY SUM(gross - budget) DESC
	LIMIT 3
)
SELECT *
FROM movies
WHERE director IN (
	SELECT * 
    FROM T
);

WITH T AS
(
	SELECT star, AVG(score)
	FROM movies
	GROUP BY star
	HAVING AVG(score) > 8
)

SELECT *
FROM movies
WHERE votes > 25000 AND star IN(
	SELECT star
    FROM T
);

WITH T AS
(
SELECT year, MAX(gross - budget) AS max_profit
FROM movies
GROUP BY year
)

SELECT *
FROM movies
WHERE (year, (gross - budget)) IN(
	SELECT year, max_profit
    FROM T
);

WITH T AS
(
	SELECT genre, MAX(score) AS max_score
	FROM movies
	WHERE votes > 25000
	GROUP BY genre
)

SELECT *
FROM movies
WHERE (genre, score) IN (
	SELECT genre, max_score
    FROM T
);

SELECT star, director, SUM(gross) AS total_gross
FROM movies
GROUP BY star, director
ORDER BY total_gross DESC
LIMIT 5;

WITH T AS
(
	SELECT genre, AVG(score) AS avg_score
	FROM movies
	GROUP BY genre
)

SELECT m.*, T.avg_score
FROM movies m
JOIN T
ON m.genre = T.genre
WHERE m.score > T.avg_score;

SELECT name, (votes/ 
	(
		SELECT SUM(votes)
		FROM movies
    )
) * 100 AS percentage
FROM movies;

WITH T AS
(
	SELECT genre, ROUND(AVG(score), 2) AS avg_score
	FROM movies
	GROUP BY genre
)

SELECT m.name, m.genre, T.avg_score
FROM movies m
JOIN T
ON m.genre = T.genre;

SELECT genre, AVG(score) AS genre_score
FROM movies
GROUP BY genre
HAVING genre_score > (
	SELECT AVG(score)
    FROM movies
)