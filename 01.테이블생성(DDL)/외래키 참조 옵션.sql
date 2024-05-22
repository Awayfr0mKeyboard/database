-- 외래키 참조 옵션
USE test_db;

-- 기존 테이블 삭제
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 외래키 참조 관계에서 테이블 생성 순서
-- 1:N 관계에서 1부터 먼저 만들고 N을 만들어야 함.
-- N 테이블 쪽이 1을 참조하는 외래키 옵션을 가지기 때문

-- 부서 테이블 생성 (1)
CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- 직원 테이블 생성 (N)
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

SELECT * FROM employees;
SELECT * FROM departments;
-- 기본 : 부서의 수정 가능, 삭제 불가능 (참조 무결성 위배)


-- 1. CASCADE 옵션
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- 직원 테이블 생성 (N)
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
	ON DELETE CASCADE		-- CASCADE 옵션 추가
);

SELECT * FROM departments;
SELECT * FROM employees;

-- 부서 테이블 (참조되는 테이블(1))의 데이터가 삭제될 때
-- 해당 테이블을 참조하는 테이블(직원 테이블)의 모든 참조 데이터가 연쇄적으로 삭제됨
INSERT INTO departments VALUES ('1', '인사과');
INSERT INTO employees VALUES ('1', '홍길동', '1');
DELETE FROM departments WHERE (`department_id` = '1');


-- 2. SET NULL
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- 직원 테이블 생성 (N)
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
	ON DELETE SET NULL		-- SET NULL 옵션 추가
);

SELECT * FROM departments;
SELECT * FROM employees;

DESC employees;

-- 데이터 삽입
INSERT INTO departments VALUES ('1', '인사과');
INSERT INTO employees VALUES ('1', '홍길동', '1');

-- 데이터 삭제
DELETE FROM departments WHERE (`department_id` = '1');
-- 부서 테이블(참조되는 테이블(1))의 데이터가 삭제될 때
-- 해당 테이블을 참조하는 테이블(직원 테이블(N))의 모든 참조 데이터의 참조 컬럼(부서ID)이 NULL로 설정됨


-- 3. NO ACTION
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- 직원 테이블 생성 (N)
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
	ON DELETE NO ACTION		-- NO ACTION 옵션 추가
);

SELECT * FROM departments;
SELECT * FROM employees;

DESC employees;

-- 데이터 삽입
INSERT INTO departments VALUES ('1', '인사과');
INSERT INTO employees VALUES ('1', '홍길동', '1');

-- 데이터 삭제
DELETE FROM departments WHERE (`department_id` = '1');
-- 해당 테이블을 참조하는 테이블(직원 테이블(N))의 데이터가 있을 경우
-- 부서 테이블(참조되는 테이블(1))의 데이터가 삭제를 거부(NO ACTION)한다.