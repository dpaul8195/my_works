CREATE TABLE Students(
	Name VARCHAR(100),
    Roll INT,
    Email VARCHAR(100)
);

DROP TABLE user;

ALTER TABLE Students
ADD Hostel VARCHAR(100);

ALTER TABLE Students
MODIFY Hostel VARCHAR(20);

TRUNCATE TABLE smartphones_cleaned_v6;

INSERT INTO Students
(Name, Roll, Email, Hostel)
VALUES ("Debu", 242123009, "d.paul@iitg.ac.in", "Siang");

INSERT INTO Students
VALUES("Nala", 242123002, "y.anju@iitg.ac.in", "Dhansiri");

UPDATE Students
SET Name = "Anju"
WHERE Name = "Nala";

DELETE FROM Students
WHERE Name = "Nala";

CREATE DATABASE second;

USE second;

DROP DATABASE second;

USE practice;

INSERT INTO Students
VALUES ("Nala", 242123002, 	NULL, NULL);

SELECT * FROM students;

ALTER TABLE students
MODIFY Name VARCHAR(100) NOT NULL;

ALTER TABLE students
MODIFY Roll INT NOT NULL UNIQUE;

ALTER TABLE students
MODIFY Hostel VARCHAR(20) DEFAULT "Siang";

INSERT INTO students
VALUES("Nala", 242123009, NULL, NULL);

SELECT * FROM students;

INSERT INTO students
VALUES("nala", 242123009, NULL, NULL);

SHOW CREATE TABLE students;

SELECT * FROM students;

INSERT INTO students
VALUES("Aritra", 242123103, NULL, DEFAULT);

ALTER TABLE students
ADD CONSTRAINT unique_roll UNIQUE(Roll);

SELECT * FROM students;

SHOW CREATE TABLE students;

TRUNCATE TABLE students;

ALTER TABLE students
ADD CONSTRAINT unique_name UNIQUE(Name);

INSERT INTO students
VALUES ("Debu", 242123009, "d.paul@iitg.ac.in", DEFAULT);

SELECT * FROM students;

ALTER TABLE students
ADD CONSTRAINT primary_key PRIMARY KEY(Roll, Name);

ALTER TABLE students
ADD CONSTRAINT primary_keys PRIMARY KEY(Name);

ALTER TABLE students
DROP PRIMARY KEY;

CREATE TABLE hostel(
	Roll INT NOT NULL,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Room INT DEFAULT 51
);

INSERT INTO hostel
VALUES (242123009, "Debu", DEFAULT);

ALTER TABLE hostel
ADD CONSTRAINT primary_key PRIMARY KEY(Roll);

ALTER TABLE hostel
ADD CONSTRAINT FOREIGN KEY(Roll) REFERENCES students(Roll);

SELECT * FROM students;

SHOW CREATE TABLE hostel;

ALTER TABLE students
ADD Age INT;

UPDATE students
SET Age = 20 WHERE Age = NULL;

ALTER TABLE students
ADD CONSTRAINT check_age CHECK(Age >= 18);

ALTER TABLE students
DROP CONSTRAINT check_age;

CREATE TABLE friends(
	Sl INT AUTO_INCREMENT,
	Name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(Sl)
);

TRUNCATE TABLE friends;

INSERT INTO friends
(Name) VALUES ("Nala");

INSERT INTO friends
(Name) VALUES ("Aritra");

SELECT * FROM friends