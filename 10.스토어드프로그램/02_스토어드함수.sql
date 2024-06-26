/*
	- DB에 저장되고 실행되는 SQL 구문 집합
	- 호출 시 항상 하나의 값을 반환
    - SQL문 내에서 호출 가능
*/
use sqldb;

-- 스토어드 함수 생성 권한 허용
SET GLOBAL log_bin_trust_function_creators = 1;

-- 두 수를 더하는 함수
delimiter $$
create function addNumber(a int, b int)
	returns int
begin
	return a + b;
end $$
delimiter ;

-- 함수 호출
select addNumber(10, 20);
-- 내장 함수처럼 SQL문 내부에서 호출 가능
select name, height, addNumber(height, 10) from usertbl;


-- 사용자의 나이를 계산하는 함수
delimiter $$
create function getUserAge(userName VARCHAR(10))
	returns int
begin
	-- 사용할 변수 선언
	declare yearBirth int;
	declare yearCurrent int;
    
    -- 테이블에서 출생년도 가져오기
    select birthYear into yearBirth
    from usertbl
    where name = userName;
    
    -- 연도 계산
    set yearCurrent = year(curdate());			-- 현재 년도
    
    -- 나이 계산하여 반환
    return yearCurrent - yearBirth;
    
end $$
delimiter ;

drop function getUserAge;

-- 함수 호출
select getUserAge('김범수');
select name, birthYear, getUserAge(name) as age from usertbl;


-- 저장 함수 목록 확인 (데이터 사전에서 프로시저와 함수 확인)
select * from information_schema.routines;
select * from information_schema.routines
	where routine_schema  = 'sqldb';
select routine_name, routine_type from information_schema.routines
	where routine_schema  = 'sqldb';
    
-- 저장 함수 생성문 확인
show create function getUserAge;

-- 함수 삭제하기
drop function addNumber;