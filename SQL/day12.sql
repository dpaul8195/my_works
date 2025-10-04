USE first;

SELECT * FROM credit_risk_dataset;

DESCRIBE credit_risk_dataset;

SELECT * FROM credit_risk_dataset
WHERE loan_amnt =( 
	SELECT MAX(loan_amnt)
	FROM credit_risk_dataset
);

SELECT * FROM credit_risk_dataset
WHERE person_income = (
	SELECT MAX(person_income) FROM credit_risk_dataset
);

SELECT COUNT(*) FROM credit_risk_dataset
WHERE loan_int_rate > (
	SELECT AVG(loan_int_rate) FROM credit_risk_dataset
);

SELECT MAX(loan_amnt)
FROM credit_risk_dataset
WHERE person_home_ownership = "RENT";

SELECT MAX(loan_percent_income)
FROM credit_risk_dataset
WHERE person_income > (
	SELECT AVG(person_income) FROM credit_risk_dataset
);

SELECT * FROM credit_risk_dataset
ORDER BY person_income DESC
LIMIT 3;

SELECT * FROM credit_risk_dataset
WHERE loan_amnt > 50000
	AND loan_int_rate < 10;
    
SELECT loan_intent, MAX(loan_amnt)
FROM credit_risk_dataset
GROUP BY loan_intent;

SELECT loan_grade, MAX(loan_int_rate)
FROM credit_risk_dataset
GROUP BY loan_grade;

SELECT * 
FROM credit_risk_dataset AS main
WHERE loan_amnt > (
	SELECT AVG(loan_amnt)
    FROM credit_risk_dataset
    WHERE main.person_home_ownership = person_home_ownership
);

SELECT *
FROM credit_risk_dataset AS main
WHERE main.loan_amnt > (
	SELECT AVG(loan_amnt)
    FROM credit_risk_dataset AS sub
    WHERE sub.loan_grade = main.loan_grade
);

SELECT *, (loan_amnt / sub.total * 100) AS percentage_of_share
FROM credit_risk_dataset
JOIN(
	SELECT SUM(loan_amnt) AS total FROM credit_risk_dataset
) AS sub;

SELECT *, (
	SELECT AVG(loan_amnt)
	FROM credit_risk_dataset AS sub
	WHERE main.loan_grade = sub.loan_grade
) AS avg_grade
FROM credit_risk_dataset AS main;

SELECT loan_intent, AVG(loan_percent_income)
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING AVG(loan_percent_income) > (
	SELECT AVG(loan_percent_income)
    FROM credit_risk_dataset
);

SELECT * 
FROM credit_risk_dataset AS main
WHERE cb_person_cred_hist_length > (
	SELECT AVG(cb_person_cred_hist_length)
	FROM credit_risk_dataset AS sub
	WHERE sub.person_home_ownership = main.person_home_ownership
);

SELECT *
FROM credit_risk_dataset
WHERE loan_status = 0
	AND loan_amnt > (
		SELECT AVG(loan_amnt)
        FROM credit_risk_dataset
        WHERE loan_status = 1
    );

SELECT * FROM credit_risk_dataset
ORDER BY loan_int_rate DESC
LIMIT 5;

SELECT *
FROM credit_risk_dataset AS main
WHERE loan_amnt < (
    SELECT MIN(sub.loan_amnt)
    FROM credit_risk_dataset AS sub
    WHERE sub.loan_grade = main.loan_grade
);

SELECT loan_intent, COUNT(*)
FROM credit_risk_dataset
WHERE loan_amnt > (
	SELECT AVG(loan_amnt)
    FROM credit_risk_dataset
)
GROUP BY loan_intent;

SELECT *
FROM credit_risk_dataset AS main
WHERE person_income > (
	SELECT AVG(person_income)
    FROM credit_risk_dataset AS sub
    WHERE main.loan_intent = sub.loan_intent
);

SELECT MAX(loan_percent_income) FROM credit_risk_dataset
WHERE loan_amnt > (
	SELECT AVG(loan_amnt)
    FROM credit_risk_dataset
)