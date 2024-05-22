CREATE SCHEMA insert_db;
use insert_db;

-- 테이블 생성
-- 기존의 스키마를 복사하여 테이블 생성
CREATE TABLE employees
	LIKE employees.employees;
    
DESC employees;		-- 스키마(데이터 구조) 확인

-- INSERT 데이터 삽입
-- 문법
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
-- VALUES (값1, 값2, ...)

-- 1. 컬럼명 모두 명시하여 데이터 삽입
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (1, '2024-05-22', '길동', '홍', 'M', '2024-05-22');
-- 컬럼명의 순서와 삽입할 데이터와 순서를 일치시켜야 함
-- 컬럼(속성)의 데이터 타입과 입력하는 데이터 타입이 일치해야 함
-- 위배 시 도메인 제약조건 위반으로 삽입 불가

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES ('문자열', '날짜아님', '길동', '홍', 'XXX', '2024-05-22');
-- (오류) 테이블 구조의 데이터 타입과 맞지 않는 경우 데이터 삽입 안됨.
-- Error Code: 1366. Incorrect integer value: '문자열' for column 'emp_no' at row 1
-- Error Code: 1292. Incorrect date value: '날짜아님' for column 'birth_date' at row 1

SELECT * FROM employees;		-- 데이터 확인


-- 2. 컬럼명을 명시하지 않고, 데이터를 삽입
INSERT INTO employees
VALUES (2, '2000-01-01', '꺽정', '임', 'M', '2024-05-22');
-- 테이블의 구조와 타입을 정확히 알고 있어야 가능
-- 모든 컬럼의 값을 삽입해야 가능
-- 테이블의 구조가 변경되면 오류가 발생할 수 있음.

SELECT * FROM employees;		-- 데이터 확인


-- 3. 특정 컬럼명만 지정하여서 데이터 삽입
INSERT INTO employees (emp_no, first_name, last_name)
	VALUES (1, '철수', '김');
-- (오류) NOT NULL 제약 조건 위배
-- 필수(PK, NOT NULL) 제약조건을 위배하는 경우 데이터 삽입
-- DEFAULT 제약 조건이 있는 경우 컬럼을 선택하지 않으면 기본값이 삽입
    
DESC employees;


-- 4. 여러 컬럼 동시에 삽입
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (3, '2000-05-22', '관순', '유', 'F', '2024-05-22'),
			(4, '2000-05-22', '사임당', '신', 'F', '2024-05-22');
            
SELECT * FROM employees;		-- 데이터 삽입


-- (대량 데이터 삽입)
-- INSERT INTO ... SELECT .. 문법
-- INSERT INTO 대상 테이블 SELECT * FROM 원본 테이블
-- 1. 데이터 구조가 완전히 일치하는 데이터 삽입 가능
-- 2. (주의점) 중복 데이터가 발생할 경우 제약 조건 위배로 오류
-- 3. 특정 조건을 부여하여 삽입하는 것도 가능

SELECT * FROM employees.employees;		-- 데이터 구조가 동일한 데이터
-- 약 30만 건의 원본 샘플 데이터

INSERT INTO employees
	SELECT * FROM employees.employees;
    
SELECT * FROM employees;