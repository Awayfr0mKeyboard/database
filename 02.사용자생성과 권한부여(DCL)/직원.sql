-- 직원 2개의 스키마만 권한 부여
-- shopdb : INSERT, UPDATE, DELETE, SELECT
-- employees : SELECT

SHOW DATABASES;					-- 권한이 있는 데이터베이스 외에는 보이지 않음

use employees;					-- 권한이 있는 데이터베이스 접근 가능

SELECT * FROM employees;		-- 권한이 있는 명령(읽기) 사용 가능

DELETE FROM employees;			-- (오류) 권한이 없는 명령 불가

SELECT * FROM sakila.actor;		-- 권한이 없는 스키마는 조회 불가

use shopdb;						-- 권한이 있는 데이터베이스 접근

SELECT * FROM membertbl;		-- SELECT 가능

INSERT INTO membertbl VALUES ('ABC', '에비씨', '부산 남구');		-- INSERT 가능

DELETE FROM membertbl WHERE memberID = 'ABC';					-- DELETE

CREATE TABLE abc (id int);				-- (오류) DDL 권한 없음
DROP TABLE membertbl;					-- (오류) DDL 권한 없음