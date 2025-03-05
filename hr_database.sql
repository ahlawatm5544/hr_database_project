-- Create HR Database
CREATE DATABASE hr;
USE hr;

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(10,2),
    commission_pct DECIMAL(5,2),
    manager_id INT,
    department_id INT
);

-- Create Jobs Table
CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(100),
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INT
);

-- Create Job History Table
CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    PRIMARY KEY (employee_id, start_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert sample data
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
('J001', 'Software Engineer', 5000, 15000),
('J002', 'Manager', 7000, 20000),
('J003', 'HR Specialist', 4000, 12000);

INSERT INTO departments (department_id, department_name, location_id) VALUES
(1, 'Engineering', 101),
(2, 'Human Resources', 102),
(3, 'Management', 103);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(101, 'Alice', 'Johnson', 'alice.johnson@example.com', '1234567890', '2018-06-15', 'J001', 8000, NULL, 201, 1),
(102, 'Bob', 'Smith', 'bob.smith@example.com', '1234567891', '2016-08-20', 'J002', 12000, NULL, NULL, 3),
(103, 'Charlie', 'Brown', 'charlie.brown@example.com', '1234567892', '2019-03-10', 'J003', 5000, 0.10, 102, 2);

-- Fundamentals of Structured Query Language - 1

-- 1. Retrieve all details of employees.
SELECT * FROM employees;

-- 2. Display the first name, last name, and email of all employees.
SELECT first_name, last_name, email FROM employees;

-- 3. Retrieve the distinct job titles from the jobs table.
SELECT DISTINCT job_title FROM jobs;

-- 4. Find the total number of employees in the company.
SELECT COUNT(*) AS total_employees FROM employees;

-- 5. Retrieve the employees who were hired after January 1, 2015.
SELECT * FROM employees WHERE hire_date > '2015-01-01';

-- Fundamentals of Structured Query Language - 2

-- 6. List all employees who have a salary greater than 5000.
SELECT * FROM employees WHERE salary > 5000;

-- 7. Retrieve employees with job titles containing the word 'Manager.'
SELECT * FROM employees WHERE job_title LIKE '%Manager%';

-- 8. Retrieve all employees whose first name starts with 'A' and ends with 'n.'
SELECT * FROM employees WHERE first_name LIKE 'A%n';

-- 9. Display the employees who do not have a commission.
SELECT * FROM employees WHERE commission_pct IS NULL;

-- 10. Retrieve the top 5 highest-paid employees.
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

-- SQL Functions

-- 11. Find the average salary of all employees.
SELECT AVG(salary) AS average_salary FROM employees;

-- 12. Retrieve the total number of employees working in each department.
SELECT department_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id;

-- 13. Display the employee's first name and the length of their first name.
SELECT first_name, LENGTH(first_name) AS name_length FROM employees;

-- 14. Convert the hire_date of employees to display only the year.
SELECT first_name, last_name, YEAR(hire_date) AS hire_year FROM employees;

-- 15. Retrieve the minimum and maximum salary for each job title.
SELECT job_id, MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM employees GROUP BY job_id;

-- SQL Tables, Joins

-- 16. Retrieve the employee names along with their department names.
SELECT e.first_name, e.last_name, d.department_name FROM employees e 
JOIN departments d ON e.department_id = d.department_id;

-- 17. List the employees along with their job titles and the location of their department.
SELECT e.first_name, e.last_name, j.job_title, d.location_id FROM employees e 
JOIN jobs j ON e.job_id = j.job_id 
JOIN departments d ON e.department_id = d.department_id;

-- 18. Retrieve the department names along with the count of employees in each department.
SELECT d.department_name, COUNT(e.employee_id) AS employee_count FROM departments d 
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;

-- 19. Find employees who have the same job as their manager.
SELECT e.first_name, e.last_name FROM employees e 
JOIN employees m ON e.manager_id = m.employee_id WHERE e.job_id = m.job_id;

-- 20. Display the names of employees who worked in different jobs in the past (use job_history).
SELECT e.first_name, e.last_name FROM employees e 
JOIN job_history jh ON e.employee_id = jh.employee_id GROUP BY e.first_name, e.last_name HAVING COUNT(jh.job_id) > 1;
