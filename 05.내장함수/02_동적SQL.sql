-- 쿼리문(SQL문)을 문자열 형태로 저장한 다음 실행 시점에 실행
-- 반복적으로 사용하는 SQL문 성능 향상
-- SQL Injection 공격 방지

-- 1. 쿼리 문장을 준비
prepare 문장이름 from 'sql문장';

-- 2. 쿼리 문장에 필요한 값을 설정 set, using
set @value = 10;

-- 3. 준비된 쿼리 문장을 실행
execute 문장이름 using @value;

-- 4. 준비된 문장 메모리 해제
deallocate prepare 문장이름;


-- 쿼리 문자열 준비 : 향후 입력될 값을 ?로 비워 놓음
set @query = 'select * from emp where deptno = ?';

-- 1. 쿼리 문장 준비
-- prepare statement from 'select * from emp where deptno = ?';
prepare statement from @query;

-- 2. 변수 설정
set @deptno = 20;

-- 3. 문장 실행
execute statement using @deptno;

-- 4. 문장 제거 (메모리 할당 해제)
deallocate prepare statement;

-- 쿼리 문장 준비
set @query = 'select * from emp where deptno = ? and sal > ?';
prepare stmt from @query;
-- 변수 준비
set @deptno = 20;
set @sal = 2500;
-- 실행
execute stmt using @deptno, @sal;			-- ?와 인자 개수를 맞춤
-- 제거
deallocate prepare stmt;
