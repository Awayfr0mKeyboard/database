/*
- 트랜젝션 : DBMS에서 데이터를 다루는 논리적 작업 단위

- 동시다발적으로 발생하는 다수의 작업을 안전하고, 독립적으로 처리하기 위한 단위
- 트랜젝션 내의 연산은 모두 성공하거나 모두 실패해야 함. (All or Nothing)

- 트랜젝션의 성질 (ACID)
	1. 원자성(Atomicity) : 더 이상 쪼개지지 않는 하나의 단위 (All or Nothing)
    2. 일관성(Consistency) : 트랜젝션 완료되면 DB는 일관된 상태를 유지 (무결성)
    3. 고립성(Isolation) : 각 트랜젝션은 다른 트랜젝션에 영향을 주지않고 독립적으로 수행
    4. 지속성(Durability) : 트랜젝션이 완료되면 결과가 영구적으로 반영
    
- 트랜젝션 제어 언어 (TCL)
	- START TRANSACTION : 트랜젝션의 시작을 알림
    - COMMIT : 트랜젝션 내 모든 연산을 확정 및 변경사항 영구 반영
    - ROLLBACK : 트랜젝션 내 모든 연산을 취소 및 이전 상태로 복구
    - SAVEPOINT : 트랜젝션 내 특정 중간지점을 설정
    - ROLLBACK TO SAVEPOINT : 설정한 지점으로 롤백(복구)
*/

DROP SCHEMA IF EXISTS tcl_db;
create schema tcl_db;
use tcl_db;

-- 테이블 생성
create table accounts (
	id int AUTO_INCREMENT primary key,				-- 계좌 ID
    name varchar(255) not null,						-- 이름
    balance  bigint not null default 0				-- 잔고
);

-- 데이터 삽입
insert into accounts (name, balance)
values ('홍길동', 100000), ('전우치', 200000);

-- 데이터 확인
select * from accounts;

-- 은행 계좌 거래 트랜젝션 시작
start transaction;

-- 1. 인출 (홍길동 -5만 원)
update accounts set balance = balance - 50000
	where name = '홍길동';
    
select * from accounts;			-- 커밋이 이루어지지 않은 부분 완료 상태 (홍길동 -5만 원)

-- 2. 입금 (전우치 +5만 원)
update accounts set balance = balance + 50000
	where name = '전우치';
    
select * from accounts;

-- 모든 변경사항을 확정 (트랜젝션 종료)
commit;

select * from accounts;

-- 트랜젝션이 시작되고, 커밋이 완료되지 않은 상태에서 세션이 종료되면 트랜젝션 시작 전으로 롤백

-- ROLLBACK
select * from accounts;

start transaction;

-- 1. 인출 (홍길동 -10만 원)
update accounts set balance = balance - 100000
	where name = '홍길동';
    
-- 2. 입금 (전우치 +10만 원)
update accounts set balance = balance + 100000
	where name = '전우치';

-- 데이터 확인 : 문제 발생 (금액이 0 이하로 떨어짐)
select * from accounts;

-- 트랜젝션 시작 이전으로 복구
rollback;

select * from accounts;
/* ROLLBACK 실행 시
	- 트랜젝션(START TRANSACTION) 이후 실행된 모든 SQL문 취소
    - 트랜젝션이 종료
*/


-- SAVEPOINT

start transaction;

-- 첫 번째 거래
-- 1. 인출 (홍길동 -5만 원)
update accounts set balance = balance - 50000
	where name = '홍길동';
    
-- 2. 입금 (전우치 +5만 원)
update accounts set balance = balance + 50000
	where name = '전우치';

select * from accounts;			-- (홍길동 0 / 전우치 30)

savepoint p1;			-- 첫 번째 거래 이후 중간 지점을 설정 (P1은 저장점 이름)

-- 두 번째 거래
-- 1. 인출 (홍길동 -5만 원)
update accounts set balance = balance - 50000
	where name = '홍길동';
    
-- 2. 입금 (전우치 +5만 원)
update accounts set balance = balance + 50000
	where name = '전우치';
    
select * from accounts;			-- 오류 확인 (홍길동 -5만)

-- 첫 번째 거래 지점까지 롤백하기	(트랜젝션을 종료하지 않음)
rollback to p1;

select * from accounts;			-- (홍길동 0 / 전우치 30)

commit;		-- 변경사항 반영 + 트랜젝션 종료


-- scott DB 예시
use scott;
start transaction;		-- 1. 트랜젝션 시작
savepoint p1;			-- 2. 저장점 설정 (처음 상태)
insert into emp			-- 3. 데이터 삽입
	values (9999, 'TCL_TEST', null, null, null, null, null, null);
savepoint p2;			-- 4. 저장점 설정 (직원 데이터 삽입)
update emp				-- 5. 급여 인상
	set sal=1000 where empno = 9999;
rollback to p2;			-- 6. 급여 인상 전으로 복구
rollback to p1;			-- 7. 직원 등록 전으로 복구
commit;					-- 8. 트랜젝션 종료 (변경사항 확정)

select * from emp where empno = 9999;	-- 데이터 확인