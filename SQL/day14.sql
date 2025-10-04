USE first;

SELECT * FROM ipl;

DESCRIBE ipl;

SELECT BattingTeam, Batter,
	SUM(Batsman_run),
	SUM(SUM(batsman_run)) OVER(PARTITION BY Batter)
FROM ipl
GROUP BY BattingTeam, Batter;

SELECT BattingTeam, Batter,
	SUM(batsman_run) AS "Total_runs",
    RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS "Team_rank"
FROM ipl
GROUP BY BattingTeam, Batter
ORDER BY BattingTeam, SUM(batsman_run) DESC;

SELECT batter,
	COUNT(*) OVER(PARTITION BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "Ball_faced",
    SUM(batsman_run) OVER(PARTITION BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "Run_scored"
FROM ipl
WHERE batter = "V Kohli";

SELECT * FROM ipl;

SELECT 
    ID,
    batter,
    overs,
    ballnumber,
    COUNT(*) OVER (
        PARTITION BY ID, batter 
        ORDER BY overs, ballnumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Ball_faced,
    SUM(batsman_run) OVER (
        PARTITION BY ID, batter 
        ORDER BY overs, ballnumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Run_scored
FROM ipl
ORDER BY ID, batter, overs, ballnumber;

SELECT * FROM(
	SELECT ID,
		batter,
		SUM(batsman_run) AS "total_runs",
		DENSE_RANK() OVER(PARTITION BY ID ORDER BY SUM(batsman_run) DESC) AS "match_rank"
	FROM ipl
	GROUP BY ID, batter
	ORDER BY ID
) AS t
WHERE t.match_rank < 4;

SELECT 
    ID,
    COUNT(*) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Ball_faced,
    SUM(batsman_run) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Run_scored,
    (SUM(batsman_run) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) * 100.0 / COUNT(*) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) AS Strike_rate
FROM ipl
WHERE batter = 'ABD'
ORDER BY ID;

SELECT *,
	AVG(batsman_run) OVER(PARTITION BY batter, ID ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS "Moving_avg"
FROM ipl;

SELECT *,
	RANK() OVER(ORDER BY t.Total_wickets DESC) AS "Bowler_rank"
FROM(
	SELECT bowler,
		SUM(isWicketDelivery) AS "Total_wickets"
	FROM ipl
	GROUP BY bowler
	ORDER BY SUM(isWicketDelivery) DESC
) AS t;

SELECT ID,
	SUM(total_run) OVER(PARTITION BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "total_runs_till_now"
FROM ipl
WHERE bowler = "YS Chahal";

SELECT *
	-- SUM(total_run) OVER(PARTITION BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "total_runs_till_now"
FROM ipl
WHERE bowler = "YS Chahal"
ORDER BY ID;

SELECT *,
	RANK() OVER(ORDER BY T.Economy) AS "Rank"
FROM(
	SELECT bowler,
		SUM(total_run) AS "Total_runs",
		SUM(total_run) / COUNT(DISTINCT(overs)) AS "Economy"
	FROM ipl
	WHERE ID = 1178429
	GROUP BY bowler
	ORDER BY SUM(total_run)
) AS T;

SELECT ID,
	SUM(isWicketDelivery) AS "Wickets",
    SUM(SUM(isWicketDelivery)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "Career_wickets"
FROM ipl
WHERE bowler = "YS Chahal"
GROUP BY ID;

SELECT *,
	RANK() OVER(ORDER BY t.Bowling_avg) AS "Ranks"
FROM(
	SELECT bowler,
		SUM(isWicketDelivery) AS "Wickets",
		SUM(total_run) AS "Total_runs",
		SUM(total_run) / SUM(isWicketDelivery) AS "Bowling_avg"
	FROM ipl
	GROUP BY bowler
) AS t
WHERE Bowling_avg IS NOT NULL
	AND Wickets > 30;

WITH temp AS(
	SELECT *,
		RANK() OVER(PARTITION BY ID, innings ORDER BY t.Runs DESC) AS "Rank"
	FROM(
		SELECT ID, overs, 
			innings, 
			SUM(total_run) AS "Runs"
		FROM ipl
		GROUP BY ID, overs, innings
		ORDER BY ID, SUM(total_run) DESC
	) AS t
)

SELECT * FROM temp
WHERE temp.rank = 1;

SELECT *,
	SUM(total_run) OVER(PARTITION BY innings ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "Total_runs"
FROM ipl
WHERE ID = 1178429;

SELECT *,
	ROW_NUMBER() OVER(ORDER BY Total DESC) AS "Number"
FROM(
	SELECT ID, 
		innings,
		SUM(total_run) AS "Total"
	FROM ipl
	GROUP BY ID, innings
	ORDER BY ID, innings
) AS t;

SELECT overs,
	SUM(total_run) AS "Runs",
    SUM(total_run) - LAG(SUM(total_run)) OVER() AS "Differences"
FROM ipl
WHERE ID = 1178429
GROUP BY overs;

SELECT overs,
	innings,
	SUM(isWicketDelivery) AS "Wickets",
    SUM(SUM(isWicketDelivery)) OVER(PARTITION BY innings ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "Cum_sum"
FROM ipl
WHERE ID = 1178429
GROUP BY overs, innings;

SELECT * FROM(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY ID) AS rnk
	FROM ipl
	WHERE total_run IN (4, 6)
) AS t
WHERE t.rnk = 1;

SELECT innings,
	CONCAT(Runs, "-", Wickets) AS "Fall_of_wickets"
FROM(
	SELECT *,
		 Wickets - LAG(Wickets) OVER() AS "Wicket"
	FROM(
		SELECT innings,
			SUM(total_run) OVER(PARTITION BY innings) AS "Total_runs",
			SUM(isWicketDelivery) OVER(PARTITION BY innings) AS "Total_wickets",
			SUM(total_run) OVER w AS "Runs",
			SUM(isWicketDelivery) OVER w AS "Wickets"
		FROM ipl
		WHERE ID = 1178429
		WINDOW w AS (PARTITION BY innings ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
	) AS t
) AS temp
WHERE temp.Wicket = 1;

SELECT batter,
	SUM(total_run) AS Runs
FROM ipl
WHERE ID = 1178429
GROUP BY batter;

WITH batter_progress AS (
    SELECT 
        ID,
        batter,
        overs,
        ballnumber,
        SUM(batsman_run) OVER (
            PARTITION BY ID, batter
            ORDER BY overs, ballnumber
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cum_runs,
        COUNT(*) OVER (
            PARTITION BY ID, batter
            ORDER BY overs, ballnumber
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS balls_faced
    FROM ipl
),
first_50 AS (
    SELECT *
    FROM batter_progress
    WHERE cum_runs >= 50
)
SELECT 
    ID,
    batter,
    MIN(balls_faced) AS balls_to_50,
    RANK() OVER (PARTITION BY ID ORDER BY MIN(balls_faced)) AS fastest_50_rank
FROM first_50
GROUP BY ID, batter
ORDER BY ID, fastest_50_rank;
