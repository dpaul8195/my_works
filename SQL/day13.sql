USE part_1;

ALTER TABLE ipl_ball_by_ball_2008_2022 RENAME TO ipl;

DESCRIBE ipl;

SELECT batter, BattingTeam, SUM(batsman_run) / COUNT(DISTINCT(ID)) AS avg_per_team
FROM ipl
GROUP BY batter, BattingTeam
ORDER BY SUM(batsman_run) DESC;

SELECT * FROM ipl;

SELECT batter, COUNT(DISTINCT(ID))
FROM ipl
GROUP BY batter
ORDER BY COUNT(DISTINCT(ID)) DESC;

SELECT batter, BattingTeam,
       SUM(batsman_run) AS total_runs,
       AVG(SUM(batsman_run)) OVER (PARTITION BY BattingTeam) AS avg_runs_per_team
FROM ipl
GROUP BY batter, BattingTeam
ORDER BY total_runs DESC;


SELECT batter, BattingTeam
FROM ipl
GROUP BY batter, BattingTeam;

SELECT AVG(total_run) OVER(PARTITION BY BattingTeam)
FROM ipl;

SELECT * FROM ipl;

SELECT 
    ID,
    innings,
    overs,
    ballnumber,
    batter,
    batsman_run,
    total_run,
    SUM(total_run) OVER (
        ORDER BY ID, innings, overs, ballnumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM ipl;
