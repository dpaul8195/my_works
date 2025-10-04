CREATE DATABASE practice;

DROP DATABASE practice;

USE first;

CREATE TABLE friends(
	Name VARCHAR(255) NOT NULL,
    Age INT,
    Roll_No INT PRIMARY KEY
);

TRUNCATE TABLE friends;

DROP TABLE friends;

INSERT friends VALUES(
	"Nala", 22, 002
);

SELECT * FROM friends;

INSERT friends VALUES(
	"Pradeep", 21, 25
);

TRUNCATE TABLE friends;

DROP TABLE friends;

CREATE TABLE friends(
	Sl_No INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Roll INT UNIQUE,
    Age INT CHECK(Age >= 20),
    Hostel VARCHAR(50) DEFAULT "Siang",
    Room_No VARCHAR(50),
    CONSTRAINT uq_room UNIQUE(Room_No)
);

CREATE TABLE Department(
	DeptID INT PRIMARY KEY,
    Department_Name VARCHAR(255)
);

CREATE TABLE Employees(
	EmpID INT PRIMARY KEY,
    Employee_Name VARCHAR(255) NOT NULL,
    Dep_ID INT,
    CONSTRAINT FOREIGN KEY(Dep_ID) REFERENCES Department(DeptID)
);

DROP TABLE Employees;

CREATE TABLE Employees(
	EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255) NOT NULL,
    DepID INT DEFAULT 1,
    CONSTRAINT fk_dep_id FOREIGN KEY(DepID) 
    REFERENCES Department(DeptID)
    ON DELETE SET DEFAULT
    ON UPDATE CASCADE
);

DROP TABLE Employees;

CREATE TABLE Employees(
	EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255) NOT NULL,
    Dep_ID INT REFERENCES Department(DeptID)
		ON DELETE SET NULL
        ON UPDATE RESTRICT
);

SELECT * FROM friends;

ALTER TABLE friends
ADD grade INT;

SELECT * FROM employees;

ALTER TABLE employees
ADD (
	Salary INT NOT NULL,
    Gender VARCHAR(50)
);

ALTER TABLE Employees
ADD Position VARCHAR(255) AFTER Dep_ID;

ALTER TABLE Employees
DROP Gender;

ALTER TABLE Employees
DROP COLUMN Position,
DROP COLUMN Salary;

SELECT * FROM friends;

ALTER TABLE friends
MODIFY Roll VARCHAR(50);

ALTER TABLE friends
MODIFY Hostel VARCHAR(255),
MODIFY grade DECIMAL(10, 2);

ALTER TABLE friends
CHANGE grade Grade INT;

SELECT * FROM employees;

ALTER TABLE employees
ADD CONSTRAINT uq_EmpID UNIQUE(EmpID);

ALTER TABLE employees
DROP CONSTRAINT uq_EmpID;
