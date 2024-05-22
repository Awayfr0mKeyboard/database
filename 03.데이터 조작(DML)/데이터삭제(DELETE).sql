-- 데이터삭제(DELETE)

-- 문법
-- DELTE FROM 테이블이름 WHERE 조건식
SELECT * FROM employees;

-- 'Georgi'라는 이름을 가진 사람을 삭제
-- 조건에 맞는 모든 행을 삭제 => 147행 삭제
DELETE FROM employees
WHERE first_name = 'Georgi';

-- 하나의 특정한 행만 삭제하고 싶을 경우 UNIQUE 속성, PRIMARY KEY
-- 고유값을 WHERE 조건 컬럼명으로 지정하여 삭제 => 1행 삭제
DELETE FROM employees
WHERE emp_no = '10002';

-- 조건에 해당하는 상위 N건만 제한적으로 지우고 싶은 경우
DELETE FROM employees
WHERE first_name = 'Jane' LIMIT 10;

-- 다중 조건 삭제
DELETE FROM employees
WHERE first_name = 'Jane' AND last_name = 'Pettey' LIMIT 1;

-- WHERE 조건절 생략되는 경우
-- (주의) 반드시 WHERE 조건절 사용!
DELETE FROM employees;

-- 테이블 내의 데이터 삭제 방법 3가지
-- 1. DROP TABLE
-- 2. DELETE FROM
-- 3. TRUNCATE

-- 대량의 데이터 복사하여 테이블 생성
CREATE TABLE big1 (SELECT * FROM employees.employees);
CREATE TABLE big2 (SELECT * FROM employees.employees);
CREATE TABLE big3 (SELECT * FROM employees.employees);

DROP TABLE big1;			-- DDL, 빠른 속도, 테이블 삭제
DELETE FROM big2;			-- DML, 한 줄씩 데이터 삭제, 트랜젝션 발생, 테이블 존재
TRUNCATE TABLE big3;		-- DDL, 빠른 속도, 테이블 존재






