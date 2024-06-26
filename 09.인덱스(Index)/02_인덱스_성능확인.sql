use employees;
select * from employees;		-- 300024 건의 데이터를 가진 테이블

use index_db;
select count(*) from employees.employees;		-- 300024건

-- 무작위 순으로 테이블 복사
create table emp
	select * from employees.employees
		order by rand();

select * from emp;		-- 직원 정보가 랜덤한 순서로 정렬됨
show table status;		-- 테이블의 상태 확인
show index from emp;	-- 인덱스가 존재하지 않음

select * from emp;		-- 약 30만 건의 데이터 조회
-- 테이블 조회 후 Excution Plan 확인
-- Full Table Scan 수행 (테이블 전체를 조회)
-- 쿼리 비용 : 30208.15

select * from emp where emp_no=100000;		-- 1건의 데이터 조회
-- 테이블 조회 후 Excution Plan 확인
-- Full Table Scan 수행
-- 쿼리 비용 : 30208.15

-- `EXPLAIN 쿼리` 쿼리 실행 계획을 반환
-- rows 컬럼(조회할 것으로 예상되는 행의 수)  
explain select * from emp where emp_no=100000;


-- 테이블에 기본 키를 추가 => 자동 인덱스 생성
alter table emp add primary key (emp_no);
show index from emp;			-- 기본키 인덱스 추가 확인
select * from emp;				-- 기본 키를 기준으로 행이 물리적으로 정렬됨

/*
	클러스터 인덱스 : MySQL에서는 기본 키를 기준으로 클러스터 인덱스 자동 생성
		- 테이블 당 단 하나만 존재
        - 물리적 데이터베이스가 인덱스를 기준으로 정렬되어 저장
	보조 인덱스
		- 하나의 테이블에 여러 보조 인덱스가 존재 가능
        - 물리적 DB가 인덱스를 기준으로 정렬되지 않음 (순서가 변경되지 않음)
*/
select * from emp where emp_no = 100000;
-- 조회 후 Execution Plan을 확인하면 쿼리 비용 : 1.00
-- 쿼리 행 수는 Single Row (1 row)
explain select * from emp where emp_no = 100000;

-- 인덱스가 없는 다른 컬럼 기준으로 조회했을 경우 이전에 Full Table Scan
select * from emp where first_name = 'Hiroyasu';
explain select * from emp where first_name = 'Hiroyasu';

-- 단 한 건의 데이터를 찾을 때도 여전히 Full Table Scan
select * from emp
	where first_name = 'Hiroyasu' and last_name ='Wursthorn';

-- 보조 인덱스 생성 (기준 컬럼 : first_name)
create index idx_first_name on emp(first_name);

-- 인덱스 생성 후 조회 -> 결과 행 수 만큼 인덱스를 통해 검색
-- 시간, 비용, 쿼리 행 수(239행)가 대폭 줄어듦
select * from emp where first_name = 'Hiroyasu';		-- 239 건
explain select * from emp where first_name = 'Hiroyasu';

-- first_name(인덱스 존재)과 last_name(인덱스 없음) 기준으로 쿼리할 경우
-- 인덱스가 있는 컬럼의 결과만큼 쿼리 비용(239행)이 발생함
select * from emp
	where first_name = 'Hiroyasu' and last_name ='Wursthorn';
    
-- 두 컬럼 복합으로 인덱스 생성
create index idx_name on emp(first_name, last_name);

-- Excution Plan을 확인하면 1행 만에 쿼리
select * from emp
	where first_name = 'Hiroyasu' and last_name ='Wursthorn';
explain select * from emp
	where first_name = 'Hiroyasu' and last_name ='Wursthorn';
    
-- 인덱스 삭제
drop index idx_first_name on emp;
drop index idx_name on emp;

show index from emp;

/*
	- 인덱스를 잘못 사용할 경우 오히려 성능이 저하될 수 있으므로 주의
		1. 데이터 삽입, 삭제, 수정 시 작업마다 실제 DB + 모든 인덱스를 수정해야 함
        2. 인덱스는 추가적인 디스크 공간을 사용 (불필요한 인덱스는 지양)
	- 인덱스를 생성해야 하는 경우
		1. 인덱스는 열(컬럼) 단위로 생성
        2. WHERE절에서 사용되는 컬럼에 인덱스를 생성
        3. WHERE절에서 '자주' 사용되는 컬럼에 인덱스를 생성
        4. JOIN에 자주 사용되는 컬럼에는 인덱스를 생성
        5. 자주 변경이 발생하는 컬럼에는 인덱스를 피하는 것이 좋음
*/