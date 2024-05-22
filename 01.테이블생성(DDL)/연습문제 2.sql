DROP SCHEMA IF EXISTS exercise;
CREATE SCHEMA IF NOT EXISTS exercise;
USE exercise;

CREATE TABLE departments (
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(255) UNIQUE,
    location VARCHAR(255)
);

CREATE TABLE employees (
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    salary INT NOT NULL CHECK(salary > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
		ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE projects (
	project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(255) UNIQUE,
    start_date DATE DEFAULT (CURRENT_DATE),
    end_date DATE CHECK(end_date IS NULL OR end_date > start_date)
);

CREATE TABLE assignments (
	assignments_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);