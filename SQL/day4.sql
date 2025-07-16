USE first;

SELECT *
FROM students;

SELECT *
FROM hostel;

DROP TABLE students;

CREATE TABLE students(
	Name VARCHAR(100) NOT NULL,
    Roll INT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Age INT,
    Hostel VARCHAR(100) DEFAULT "Siang"
);

CREATE TABLE hostel(
	RoomNo INT PRIMARY KEY,
    Roll INT NOT NULL,
    RoomType VARCHAR(100) DEFAULT "Single",
    Gender VARCHAR(100),
    FOREIGN KEY(Roll) REFERENCEs students(Roll)
);

INSERT INTO students (Roll, Name, Email, Age, Hostel) VALUES
(101, 'Aritra', 'arit@iitg.ac.in', 21, 'Siang'),
(102, 'Nala', 'nala@iitg.ac.in', 20, 'Dhansiri'),
(103, 'Rahul', 'rahul@iitg.ac.in', 22, 'Dibang'),
(104, 'Bihung', 'bihu@iitg.ac.in', 20, 'Manas'),
(105, 'Debu', 'debu@iitg.ac.in', 23, 'Dhansiri'),
(106, 'Anju', 'anju@iitg.ac.in', 21, 'Manas'),
(107, 'Mitali', 'mitali@iitg.ac.in', 19, NULL),
(108, 'Pradeep', 'prad@iitg.ac.in', 22, 'Siang');

INSERT INTO students (Roll, Name, Email, Age, Hostel) VALUES
(109, 'Priya', 'priya@iitg.ac.in', 21, 'Kameng'),
(110, 'Raj', 'raj@iitg.ac.in', 20, 'Umiam');

INSERT INTO hostel (RoomNo, Roll, RoomType, Gender) VALUES
(201, 101, 'Double', 'Male'),
(202, 102, 'Single', 'Female'),
(203, 103, 'Double', 'Male'),
(204, 105, 'Triple', 'Male'),
(205, 106, 'Single', 'Female'),
(206, 108, 'Double', 'Male'),
(207, 109, 'Single', 'Female'),
(208, 110, 'Triple', 'Male');

SELECT s.name, h.Gender
FROM students s
INNER JOIN hostel h
ON s.Roll = h.Roll;

SELECT * FROM students;

SELECT s.Name, s.Roll, h.Gender
FROM students s
LEFT JOIN hostel h
ON s.Roll = h.Roll;

SELECT s.Name, s.Roll, h.Gender
FROM students s
RIGHT JOIN hostel h
ON s.Roll = h.Roll;

SELECT s.Name, s.Roll, s.Hostel, h.RoomNo, h.RoomType
FROM students s
LEFT JOIN hostel h
ON s.Roll = h.Roll
UNION
SELECT s.Name, s.Roll, s.Hostel, h.RoomNo, h.RoomType
FROM students s
RIGHT JOIN hostel h
ON s.Roll = h.Roll;

SELECT s.Name, s.Hostel, h.RoomNo
FROM students s
CROSS JOIN hostel h;

SELECT * FROM hostel;

SELECT * FROM students;

SELECT A.Name AS student1, B.Name AS student2
FROM students A
INNER JOIN students B
ON A.Hostel = B.Hostel AND A.Name <> B.Name;

SELECT s.Roll
FROM students s
UNION ALL
SELECT h.Roll
FROM hostel h;

SELECT s.Roll
FROM students s
WHERE s.Roll IN
(SELECT h.Roll
FROM hostel h
);

SELECT s.Roll
FROM students s
LEFT JOIN hostel h
ON s.Roll  = h.Roll
WHERE h.Roll IS Null;

USE first;

SELECT *
FROM students;

SELECT *
FROM hostel;

SELECT s.Name, h.Roll
FROM hostel h
LEFT JOIN students s
ON h.Roll = s.Roll;

CREATE TABLE dept(
	Name VARCHAR(100) NOT NULL,
    Roll INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    CGPA INT NOT NULL
);

INSERT INTO dept
VALUES
("Rahul", 029, "MnC", 9.6),
("Nala", 012, "MnC", 9.0),
("Aritra", 107, "Math", 10);

SELECT *
FROM dept;

ALTER TABLE dept
MODIFY DeptName VARCHAR(100) DEFAULT "Math";

ALTER TABLE dept
MODIFY CGPA FLOAT NOT NULL;

SELECT *
FROM hostel;

SELECT s.Name, h.RoomNo, d.DeptName, s.Roll
FROM students s
LEFT JOIN hostel h
ON s.Roll = h.Roll
LEFT JOIN dept d
ON s.Roll = d.Roll;

SELECT s.Name, s.Roll, d.DeptName
FROM students s
LEFT JOIN dept d
ON s.Roll = d.Roll AND s.Name = d.Name;

SELECT *
FROM ipl
WHERE batter = "V Kohli";

SELECT *
FROM ipl
WHERE batter IN ("V Kohli", "ABD");

SELECT *
FROM ipl
WHERE batter LIKE "V%";

SELECT *
FROM ipl
WHERE total_run BETWEEN 4 AND 6;

SELECT *
FROM
(SELECT batter, COUNT(*) AS match_num, AVG(runs) AS avg_run
FROM
(SELECT ID, batter, SUM(batsman_run) AS runs
FROM ipl
GROUP BY ID, batter) T1
GROUP BY batter
ORDER BY avg_run DESC, match_num ASC) T2
WHERE match_num > 20
LIMIT 5;

SELECT batter, COUNT(DISTINCT bowler) AS nums
FROM
	(SELECT batter, bowler
	FROM ipl
	WHERE isWicketDelivery = 1
	GROUP BY batter, bowler) T
GROUP BY batter
ORDER BY nums DESC
LIMIT 1;

SELECT *
FROM
	(SELECT bowler, COUNT(*) AS balls, (SUM(batsman_run) / COUNT(*)) * 6 AS economy
	FROM ipl
	WHERE overs <= 6
	GROUP BY bowler
	ORDER BY economy DESC) T
WHERE balls > 50;

SELECT *
FROM
	(SELECT batter, bowler, SUM(batsman_run) AS runs, SUM(isWicketDelivery) AS wicket
	FROM ipl
	GROUP BY batter, bowler) T
WHERE runs > 1000 AND wicket > 50;