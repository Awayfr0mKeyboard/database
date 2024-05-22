-- 사장님 {전역(global) 읽기 권한만 부여됨}
CREATE DATABASE abc;							-- (오류) 데이터베이스 생성 권한 없음

use shopdb;			-- 데이터베이스 접근 가능
DROP TABLE membertbl;							-- (오류) 테이블 삭제 권한 없음

INSERT into membertbl
	VALUE (10, '홍길동', '부산');					-- (오류) INSERT 데이터 삽입 권한 없음
    
SELECT * FROM membertbl;						-- SELECT 권한 존재
SELECT * FROM employees.departments;			-- 전역적인 읽기 권한 존재
