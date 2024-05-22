-- 데이터 수정(UPDATE)

-- 기본 문법
-- UPDATE 테이블명
-- SET 컬럼명1 = 값1, 컬럼명2 = 값2, ....
-- WHERE 조건식;

USE INSERT_DB;

SELECT * FROM employees;

-- employees 테이블에서 이름이 '길동'인 사람의 생일을 변경
UPDATE employees
SET birth_date = '2000-01-02'
WHERE first_name = '길동';

-- 다중 컬럼 변경
-- employees 테이블에서 직원번호가 2번인 사람의 성과 이름을 변경
UPDATE employees
SET last_name = '전', first_name = '우치'
WHERE emp_no = 2;

-- employees 테이블에서 성별이 여자인 사람의 이름을 'Jane'으로 변경
UPDATE employees
SET first_name = 'Jane'
WHERE gender = 'F';
-- WHERE 조건문 사용 주의점 : 조건에 해당하는 대상이 여러 행(row)일 경우
-- 조건에 해당하는 모든 row의 데이터가 수정된다.
-- WHERE 절에 사용하는 컬럼의 경우 UNIQUE한 값, 또는 PRIMARY KEY일 때
-- 특정한 데이터를 선택하여 계별값을 변경할 수 있음

UPDATE employees
SET hire_date = '2000-01-01';
-- WHERE 절이 생략되는 경우 테이블의 모든 행이 수정
-- (주의) 예상치 않은 데이터 변경을 막기 위해 반드시 WHERE절 사용

-- 다중 조건 사용
UPDATE employees
SET birth_date = '1990-05-22'
WHERE birth_date = '2000-05-22' AND first_name = 'Jane' AND last_name = '유';

SELECT * FROM employees;

-- 범위 조건 사용
-- 2000년 이후 생일인 사람의 고용일을 변경
UPDATE employees
SET hire_date = '2024-05-22'
WHERE birth_date >= '2000-01-01';