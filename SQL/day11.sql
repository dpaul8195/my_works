USE first;

SELECT * FROM employees;

DROP TABLE employees;

SELECT * FROM department;

DESCRIBE department;

CREATE TABLE Employees(
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    manager_id INT,
    salary INT,
    CONSTRAINT fk_dept 
		FOREIGN KEY(dept_id) 
		REFERENCES department(DeptID)
);
    
DROP TABLE Employees;

ALTER TABLE Employees
DROP CONSTRAINT fk_dept;

ALTER TABLE Employees
ADD CONSTRAINT fk_dept 
	FOREIGN KEY(dept_id) 
		REFERENCES department(DeptID)
		ON UPDATE CASCADE
		ON DELETE SET NULL;

INSERT INTO department
VALUES
	(10, "HR"),
    (20, "Finance"),
    (30, "IT"),
    (40, "Marketing");

INSERT Employees(emp_name, dept_id, manager_id, salary)
VALUES("Alice", 10, NULL, 70000),
	("Bob", 20, 1, 60000), 
	("Charlie", 10, 1, 50000),
    ("Devid", 30, 2, 45000),
    ("Eva", NULL, 2, 40000);

SELECT e.emp_name, d.Department_Name
FROM Employees AS e
JOIN department AS d
ON e.dept_id = d.DeptID;

SELECT * FROM department;

SELECT e.emp_name, Department_Name
FROM Employees AS e
JOIN department AS d
ON e.dept_id = d.DeptID
WHERE d.Department_Name = "IT";

SELECT d.Department_Name, COUNT(*) AS freq
FROM Employees AS e
JOIN department AS d
ON e.dept_id = d.DeptID
GROUP BY d.Department_Name;

SELECT e.emp_name, IFNULL(d.Department_Name, "No Department") AS Department_Names
FROM Employees AS e
LEFT JOIN department AS d
ON e.dept_id = d.DeptID;

SELECT d.Department_Name, COUNT(emp_id) AS Number_of_emp
FROM department AS d
LEFT JOIN Employees AS e
ON d.DeptID = e.dept_id
GROUP BY Department_Name;

SELECT * FROM department;

SELECT * FROM Employees;

SELECT d.Department_Name, IFNULL(e.emp_name, "NO EMPLOYEE")
FROM department AS d
LEFT JOIN Employees AS e
ON d.DeptID = e.dept_id;

SELECT e.emp_name
FROM department AS d
RIGHT JOIN Employees AS e
ON d.DeptID = e.dept_id
WHERE d.DeptID = NULL;

WITH T AS (
	SELECT e.emp_name AS EmpName, d.Department_Name AS DeptName
	FROM Employees AS e
	LEFT JOIN Department AS d
	ON d.DeptID = e.dept_id
	UNION
	SELECT e.emp_name, d.Department_Name
	FROM Employees AS e
	RIGHT JOIN Department AS d
	ON d.DeptID = e.dept_id
)

SELECT * FROM T
WHERE EmpName IS NULL OR DeptName IS NULL;

SELECT e.emp_name, d.Department_Name
FROM Employees AS e
CROSS JOIN Department AS d;

SELECT e.emp_name, e2.emp_name
FROM Employees AS e
CROSS JOIN Employees AS e2
WHERE e.emp_name <> e2.emp_name;

SELECT * FROM employees;

CREATE TABLE Managers(
	manager_id INT PRIMARY KEY,
    manager_name VARCHAR(255) NOT NULL,
    dept_id INT REFERENCES department(DeptID)
);

INSERT INTO Managers(manager_id, manager_name, dept_id)
VALUES
	(1, "Alice", 10),
    (2, "Bob", 20),
    (4, "Devid", 30);

ALTER TABLE Employees
ADD CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES Managers(manager_id);

SELECT e.emp_name, m.manager_name
FROM Employees AS e
JOIN Managers AS m
	ON e.manager_id = m.manager_id;

SELECT * FROM Employees;

SELECT e1.emp_name, e2.manager_id
FROM Employees AS e1
JOIN Employees AS e2
ON e1.manager_id = e2.manager_id;

CREATE TABLE Emp24(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(255) NOT NULL,
    dept_id INT
);

CREATE TABLE Emp25(
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR(255),
    dept_id INT
);

INSERT INTO Emp24
VALUES
	(1, "Alice", 10),
    (2, "Bob", 20),
    (3, "Charlie", 10),
    (4, "Devid", 30);
    
INSERT INTO Emp25
VALUES
	(2, "Bob", 20),
    (3, "Charlie", 10),
    (5, "Eva", 30),
    (6, "Frank", 20);
    
SELECT * FROM Emp24
UNION
SELECT * FROM Emp25;

SELECT * FROM Emp24
UNION ALL
SELECT * FROM Emp25;

SELECT T1.*
FROM Emp24 AS T1
JOIN Emp25 AS T2
ON T1.emp_id = T2.emp_id;

SELECT T1.*
FROM Emp24 AS T1
LEFT JOIN Emp25 AS T2
ON T1.emp_id = T2.emp_id
WHERE T2.emp_id IS NULL;

SELECT emp_id, emp_name
FROM Emp24
EXCEPT
SELECT emp_id, emp_name
FROM Emp25;

SELECT * FROM Emp25
EXCEPT 
SELECT * FROM EMP24;

SELECT * FROM Emp25
WHERE emp_id NOT IN 
	(SELECT emp_id FROM Emp24);
    
SELECT e24.emp_id, e24.emp_name,
       e24.dept_id AS dept_2024,
       e25.dept_id AS dept_2025
FROM Emp24 AS e24
JOIN Emp25 AS e25
  ON e24.emp_id = e25.emp_id
WHERE e24.dept_id <> e25.dept_id;

SELECT * FROM Emp25
EXCEPT 
SELECT * FROM Emp24;

SELECT * FROM Emp24
WHERE emp_id NOT IN
	(SELECT emp_id FROM Emp25)
UNION
SELECT * FROM Emp25
WHERE emp_id NOT IN 
	(SELECT emp_id FROM Emp24);
    
USE resturent;

SELECT * FROM delivery_partner;

SELECT * FROM food;

SELECT * FROM menu;

SELECT * FROM restaurants;

SELECT * FROM `users (1)`;

SELECT m.menu_id, m.f_id, m.price, r.r_name, f.type, d.partner_name
FROM menu AS m
LEFT JOIN
restaurants AS r
ON m.r_id = r.r_id
LEFT JOIN
food AS f
ON f.f_id = m.f_id
LEFT JOIN
delivery_partner AS d
ON d.partner_id = m.r_id;

SELECT m.menu_id, m.price, r.r_name, r.cuisine, f.f_name, f.type, p.partner_name
FROM menu AS m
LEFT JOIN restaurants AS r
ON m.r_id = r.r_id
LEFT JOIN food AS f
ON f.f_id = m.f_id
LEFT JOIN delivery_partner AS p
ON p.partner_id = m.r_id;

SELECT * FROM food
WHERE f_name LIKE "%Pizza%";

SELECT * FROM restaurants
WHERE r_name LIKE "C%";

SELECT * FROM delivery_partner
WHERE partner_name LIKE "S%"
	OR partner_name LIKE "K%";
    
SELECT * FROM food
WHERE type IN ("Veg", "Non-veg");

SELECT * FROM menu
WHERE price IN (100, 200, 300, 450);

SELECT m.*, f.type
FROM menu AS m
LEFT JOIN
food AS f
ON f.f_id = m.f_id
WHERE m.price BETWEEN 100 AND 250
AND f.type = "Veg";

SELECT * FROM delivery_partner
WHERE partner_id NOT IN (1, 3, 5)
	AND partner_name LIKE "%a%";

SELECT * FROM delivery_partner;

SELECT *,
CASE
	WHEN price > 300 THEN "Expansive"
    WHEN price BETWEEN 150 AND 300 THEN "Moderate"
	ELSE "Cheap"
END AS Price_Category
FROM menu;

SELECT *,
CASE
	WHEN cuisine = "Italian" OR cuisine = "American" THEN "Fast Food"
    ELSE "Other"
END AS Restaurant_Type
FROM restaurants;

SELECT * FROM menu;

USE windows;

SELECT * FROM users;

SELECT * FROM orders;

SELECT * FROM order_details;

SELECT o.id, T.amount, T.date, T.partner_id, T.delivery_time, T.delivery_rating, T.restaurant_rating, u.name, r.r_name, f.f_name, f.type, r.cuisine, u.email, u.password, m.price
FROM  orders AS T
LEFT JOIN
users AS u
ON T.user_id = u.user_id
LEFT JOIN
restaurants AS r
ON r.r_id = T.r_id
LEFT JOIN 
order_details AS o
ON o.order_id = T.order_id
LEFT JOIN food AS f
ON f.f_id = o.f_id
LEFT JOIN menu AS m
ON m.f_id = f.f_id;

DROP DATABASE resturent;

USE windows;

SELECT * FROM restaurants;

SELECT r_id, SUM(amount) AS Total_revenue 
FROM orders
GROUP BY r_id;

SELECT T.r_id, SUM(amount) AS Revenue_on_veg
FROM orders AS T
JOIN
order_details AS o
ON o.order_id = T.order_id
JOIN food AS f
ON f.f_id = o.f_id
WHERE f.type = "Veg"
GROUP BY T.r_id;

SELECT T.r_id, COUNT(*) AS total_orders,
SUM(
	CASE
		WHEN f.type = "Non-veg" THEN 1
        ELSE 0
	END
) AS num_of_non_veg_orders
FROM orders AS T
JOIN order_details AS o
	ON T.order_id = o.order_id
JOIN food AS f
	ON o.f_id = f.f_id
GROUP BY r_id;

SELECT f.type, AVG(T.amount)
FROM orders AS T
JOIN order_details AS o
	ON o.order_id = T.order_id
JOIN food AS f
	ON f.f_id = o.f_id
GROUP BY f.type