SELECT * FROM students;

SELECT * FROM hostel;

SHOW CREATE TABLE hostel;

ALTER TABLE hostel
DROP CONSTRAINT hostel_ibfk_1;

ALTER TABLE hostel
ADD CONSTRAINT 
foreign_roll FOREIGN KEY(Roll)
REFERENCES students(Roll)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE hostel
ADD gender VARCHAR(20) NOT NULL;

ALTER TABLE hostel
DROP gender;

ALTER TABLE hostel
MODIFY Room INT UNIQUE;

ALTER TABLE hostel
ADD CONSTRAINT unique_name UNIQUE(Name);

ALTER TABLE hostel
DROP CONSTRAINT unique_name;

ALTER TABLE hostel
ADD gender VARCHAR(20)
AFTER Roll;

ALTER TABLE hostel
ADD(
	Age INT,
    Surname VARCHAR(100)
);

ALTER TABLE hostel
ADD Sl INT
FIRST;

SELECT * FROM hostel
WHERE Room IS NULL;

ALTER TABLE hostel
DROP Sl;

ALTER TABLE hostel
ADD COLUMN Sl INT;

ALTER TABLE hostel
DROP Sl,
DROP Surname;

SELECT * FROM students;

SHOW CREATE TABLE students;

INSERT INTO students
VALUES ("Nala", 242123002, "y.anju@iitg.ac.in", "Dhansiri", NULL);

INSERT INTO students
VALUES
("Aritra", 242123103, NULL, DEFAULT, NULL);

INSERT INTO students
VALUES
("Pradeep", 242123106, NULL, DEFAULT, 24),
("Rahul", 242123005, NULL, DEFAULT, 22);

INSERT INTO students
(Name, Roll)
VALUES
("Bihung", 242123006);

SELECT * FROM iris;

SELECT SepalLengthCm, SepalWidthCm FROM iris;

SELECT PetalLengthCm AS Petal_Length, PetalWidthCm AS Petal_Width FROM iris;

SELECT Age + 1 AS Next_aeg FROM Students;

SELECT Species, "Flower" AS Main_Species FROM iris;

SELECT * FROM iris
WHERE Species = "Iris-setosa";

SELECT DISTINCT Species FROM iris;

USE first;

SELECT * FROM smartphones_cleaned_v6;

DROP TABLE smartphones_cleaned_v6;

SELECT * FROM `ipl_ball_by_ball_2008_2022 (1)`;

RENAME TABLE `ipl_ball_by_ball_2008_2022 (1)` TO ipl;

SELECT * FROM ipl;

SELECT * FROM ipl
WHERE batter = "V Kohli";

SELECT SUM(isWicketDelivery) FROM ipl
WHERE bowler = "TA Boult";

SELECT SUM(isWicketDelivery) FROM ipl
WHERE bowler = "TA Boult" 
AND batter = "V Kohli";

SELECT bowler, SUM(batsman_run) AS runs
FROM ipl
WHERE batter = "V Kohli"
GROUP BY bowler
ORDER BY runs DESC;

DROP DATABASE practice;