USE first;

SELECT * FROM credit_risk_dataset;

SELECT * FROM credit_risk_dataset
ORDER BY loan_amnt DESC
LIMIT 5;

SELECT * FROM credit_risk_dataset
ORDER BY person_age
LIMIT 10;

SELECT * FROM credit_risk_dataset
ORDER BY loan_int_rate DESC
LIMIT 3;

SELECT * FROM credit_risk_dataset
ORDER BY loan_grade ASC, loan_amnt DESC;

SELECT * FROM credit_risk_dataset
ORDER BY cb_person_default_on_file DESC, person_income DESC;

SELECT loan_intent, COUNT(*), AVG(loan_amnt), MAX(person_income), AVG(loan_int_rate)
FROM credit_risk_dataset
GROUP BY loan_intent;

SELECT person_home_ownership, AVG(loan_percent_income), AVG(person_age), SUM(loan_amnt)
FROM credit_risk_dataset
GROUP BY person_home_ownership;

WITH T AS (
	SELECT loan_grade, loan_intent, COUNT(*), AVG(loan_int_rate) AS avg_rate, MAX(loan_amnt)
	FROM credit_risk_dataset
	GROUP BY loan_grade, loan_intent
	ORDER BY AVG(loan_int_rate) DESC
)

SELECT loan_grade, MAX(avg_rate)
FROM T
GROUP BY loan_grade
LIMIT 5;
WITH T AS (
	SELECT loan_grade, loan_intent, COUNT(*) AS freq, AVG(loan_int_rate) AS avg_rate, MAX(loan_amnt)
	FROM credit_risk_dataset
    WHERE loan_status = 1
	GROUP BY loan_grade, loan_intent
	ORDER BY AVG(loan_int_rate) DESC
)

SELECT loan_grade, MIN(freq)
FROM T
GROUP BY loan_grade
ORDER BY MIN(freq);

SELECT * FROM credit_risk_dataset;

SELECT person_home_ownership, AVG(loan_amnt)
FROM credit_risk_dataset
WHERE person_home_ownership IN ("RENT", "OWN")
GROUP BY person_home_ownership;

SELECT AVG(person_income)
FROM credit_risk_dataset
WHERE person_home_ownership = "OWN" AND loan_status = 1;

SELECT loan_intent, COUNT(*), AVG(loan_percent_income)
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING COUNT(*) > 100
ORDER BY AVG(loan_percent_income)
LIMIT 3;

SELECT loan_intent, AVG(loan_percent_income) AS avg_loan_percent_income
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY avg_loan_percent_income DESC
LIMIT 3;
