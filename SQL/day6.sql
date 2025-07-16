USE windows;

SELECT * 
FROM marks;

SELECT branch, AVG(marks)
FROM marks
GROUP BY branch;

SELECT *, 
	AVG(marks) OVER(PARTITION BY branch) AS brach_avg
FROM marks;

SELECT *,
SUM(marks) OVER(ORDER BY marks) AS cum_sum
FROM marks;

SELECT *,
AVG(marks) OVER() AS avg_marks
FROM marks;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch ORDER BY marks DESC) AS roll_no
FROM marks;

SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS ranks
FROM marks;

SELECT *,
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS dense_renks
FROM marks;

SELECT *,
FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS topper_marks
FROM marks;

SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) as last_masks
FROM marks;

SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS lowest_marks
FROM marks;

SELECT *,
NTH_VALUE(marks, 2) OVER(PARTITION BY branch ORDER BY marks
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_marks
FROM marks;

USE first;

SELECT s.name, h.RoomNo
FROM students s
JOIN hostel h
ON s.Roll = h.Roll
WHERE h.RoomType = "Single";

WITH T AS 
(
	SELECT ID, batter
	FROM ipl
	GROUP BY batter, ID
)

SELECT batter, COUNT(*) AS matches
FROM T
GROUP BY batter
HAVING COUNT(*) > 45;

SELECT s.name, h.RoomNo, s.Age
FROM students s
JOIN hostel h
ON s.Roll = h.Roll
WHERE s.age > 
(
	SELECT AVG(Age) AS avg_age
	FROM students
);

USE windows;

SELECT *,
CONCAT(branch, '-', ROW_NUMBER() OVER(PARTITION BY branch ORDER BY marks DESC)) AS RollNo
FROM marks;

SELECT order_id, amount, MONTHNAME(date) AS months,
LAG(amount, 1, 0) OVER() AS prev_amount,
amount - LAG(amount, 1, 0) OVER() AS diff;

SELECT 
  month,
  total,
  LAG(total) OVER (ORDER BY month_number) AS prev_month_total,
  ROUND((total - LAG(total) OVER (ORDER BY month_number)) / total * 100, 2) AS MoM_growth
FROM (
  SELECT 
    MONTHNAME(date) AS month,
    MONTH(date) AS month_number,
    SUM(amount) AS total
  FROM orders
  GROUP BY MONTH(date), MONTHNAME(date)
) AS t;

SELECT month_name, total,
LAG(total) OVER(ORDER BY month_no) AS prev_total,
total - LAG(total) OVER(ORDER BY month_no) AS diff
FROM
(
	SELECT MONTH(date) AS month_no, MONTHNAME(date) AS month_name, SUM(amount) AS total
	FROM orders
	GROUP BY MONTH(date), MONTHNAME(date)
) T;

SELECT month_name, total,
LEAD(total) OVER(ORDER BY total) AS next_total,
total - LEAD(total) OVER(ORDER BY total) AS diff
FROM
(
	SELECT MONTH(date) AS month_num, MONTHNAME(date) AS month_name, SUM(amount) AS total
	FROM orders
	GROUP BY MONTH(date), MONTHNAME(date)
) T;

USE windows;

SELECT *, 
SUM(marks) OVER(ORDER BY student_id)AS cum_sum
FROM marks;

SELECT *,
SUM(marks) OVER(PARTITION BY branch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS branch_cumsum
FROM marks;

SELECT *,
AVG(marks) OVER(PARTITION BY branch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS branch_cumavg
FROM marks;

USE first;

SELECT ID, SUM(batsman_run) AS runs,
SUM(SUM(batsman_run)) OVER w AS crr_runs,
AVG(SUM(batsman_run)) OVER w AS crr_avg
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);

USE windows;

SELECT name, marks, 
SUM(marks) OVER() AS total,
marks / SUM(marks) OVER() * 100 AS percentage
FROM marks;

SELECT *,
NTILE(3) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_no
FROM marks;

SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS topper_group
FROM marks;

SELECT *,
CUME_DIST() OVER(ORDER BY marks DESC) AS cume_dist_
FROM marks;

SELECT *
FROM
(
	SELECT *,
	CUME_DIST() OVER(ORDER BY marks DESC) AS dist
	FROM marks
) t
WHERE dist <= 0.10;

SELECT *,
CASE
	WHEN marks > 90 THEN 'A'
    WHEN marks > 80 THEN 'B'
    WHEN marks > 70 THEN 'C'
    ELSE 'D'
END AS grade
FROM marks;
