
USE first;

SELECT * FROM friends;

INSERT friends(Sl_No, Name, Email, Roll, Age, Hostel, Grade)
VALUES(
	NULL, "Nala", "nala@iig.ac.in", 242123002, 22, "Disang", 8.0
);

ALTER TABLE friends
MODIFY Room_No VARCHAR(50) DEFAULT "Unknown";

TRUNCATE TABLE friends;

DESCRIBE friends;

ALTER TABLE friends
DROP CONSTRAINT uq_Room;

SHOW INDEX FROM friends;

INSERT friends(Name, Email, Roll, Age, Hostel, Grade)
VALUES
	("Pradeep", "pd@iitg.ac.in", 242123105, 21, "Siang", 9.0),
    ("Rahul", "rahul@iitg.ac.in", 242123022, 21, "Siang", 10);

SELECT * FROM credit_risk_dataset;

DESCRIBE credit_risk_dataset;

SELECT person_age, person_income, loan_amnt FROM credit_risk_dataset;

SELECT person_age AS age, person_income AS Income, loan_amnt AS LoanAmount
FROM credit_risk_dataset;

SELECT person_income - loan_amnt AS Remaining 
FROM credit_risk_dataset;

SELECT loan_amnt, ROUND(loan_amnt / 1000, 2) AS loan_in_thousand
FROM credit_risk_dataset;

SELECT * FROM credit_risk_dataset;

SELECT DISTINCT(person_home_ownership) AS Ownership
FROM credit_risk_dataset;

SELECT DISTINCT loan_intent, loan_grade
FROM credit_risk_dataset;

SELECT * FROM credit_risk_dataset
WHERE person_age < 25;

SELECT * FROM credit_risk_dataset
WHERE loan_status = 1
AND loan_grade = 'C';

SELECT (loan_amnt / person_income) * 100 AS Loan_Percent_Income, loan_status, loan_percent_income
FROM credit_risk_dataset
WHERE (loan_amnt / person_income) * 100 > 50;

DESCRIBE credit_risk_dataset;

SELECT * FROM credit_risk_dataset
WHERE loan_grade IN ('A', 'B', 'C');

SELECT DISTINCT loan_grade
FROM credit_risk_dataset;

SELECT * FROM credit_risk_dataset
WHERE person_home_ownership != "OWN";

SELECT * FROM credit_risk_dataset
WHERE person_age BETWEEN 25 AND 35;

SELECT loan_grade, AVG(loan_amnt) AS avg_loan FROM credit_risk_dataset
GROUP BY loan_grade
HAVING AVG(loan_amnt) > 8000;

SELECT loan_intent, COUNT(*) AS frequency
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING COUNT(*) > 50;

SELECT loan_grade, SUM(loan_amnt) AS total_amnt
FROM credit_risk_dataset
WHERE person_income > 50000
GROUP BY loan_grade
HAVING SUM(loan_amnt) > 100000;

WITH T AS(
	SELECT * FROM credit_risk_dataset
	WHERE loan_percent_income > 0.40
)
SELECT person_age, loan_amnt, loan_percent_income
FROM T;

WITH T AS(
	SELECT loan_intent, AVG(loan_amnt) AS avg_loan
    FROM credit_risk_dataset
    GROUP BY loan_intent
)
SELECT * FROM T
WHERE avg_loan > 7000;

SELECT * FROM friends;

UPDATE credit_risk_dataset
SET loan_amnt = loan_amnt * 1.05
WHERE loan_grade = 'A';

UPDATE credit_risk_dataset
SET loan_status = 0
WHERE person_income < 20000;

UPDATE credit_risk_dataset
SET cb_person_default_on_file = 'Y'
WHERE loan_percent_income > 0.50;

DELETE FROM credit_risk_dataset
WHERE loan_status = 0 AND loan_amnt < 1000;

DELETE FROM credit_risk_dataset
WHERE person_Emp_length = NULL;

SELECT *
FROM credit_risk_dataset
WHERE loan_amnt = (
	SELECT MAX(loan_amnt)
    FROM credit_risk_dataset
)
LIMIT 1;

SELECT * FROM credit_risk_dataset
WHERE person_income = (
	SELECT MIN(person_income)
    FROM credit_risk_dataset
);

SELECT SUM(loan_amnt) AS total_amnt
FROM credit_risk_dataset
WHERE loan_status = 1;

SELECT COUNT(*) FROM credit_risk_dataset;

WITH T AS (
	SELECT DISTINCT loan_intent
	FROM credit_risk_dataset
)

SELECT COUNT(*) FROM T;

SELECT STD(loan_int_rate) AS sigma, VARIANCE(person_emp_length) AS var
FROM credit_risk_dataset;

SELECT loan_intent, ROUND(AVG(loan_percent_income), 4) AS avg_percent
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING AVG(loan_percent_income) > 0.30;

SELECT *, ABS(loan_amnt - person_income) AS diff
FROM credit_risk_dataset;