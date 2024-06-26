/*
	스토어드(저장된, stored) 프로시저(절차, procedures)
    
    - 데이터베이스에 저장된 쿼리(SQL)의 집합
    - 자주 사용되는 쿼리(또는 복잡한 쿼리)를 저장해 두었다가 필요할 때 호출
    - 재사용성이 향상
    - 문법
		-- 구분자(;)를 변경
		delimiter $$
		create procedure 프로시저명 (매개변수)
		begin
			-- 저장할 SQL 구문
			select * from emp;
			select * from dept;
		end;
		delimiter ;
*/
use sqldb;

-- 스토어드 프로시저 생성
delimiter $$
-- 구분자를 ;에서 $$으로 변경
create procedure userProc()
begin
	-- SQL 문
    select * from usertbl;
end $$
-- 구분자를 ;에서 $$으로 변경
delimiter ;

-- 스토어드 프로시저 호출
call userProc();

-- 매개변수 사용하여 프로시저 생성
delimiter $$
create procedure userProcParam(IN userName VARCHAR(10))
-- IN : 입력 매개변수 데이터 타입
begin
	-- SQL 문
    select * from usertbl where name = userName;
end $$
delimiter ;

-- 매개변수가 있는 프로시저 호출
call userProcParam('김범수');
call userProcParam('바비킴');


-- 매개변수가 여러 개 있는 프로시저
delimiter $$
create procedure youngerAndTaller(IN userYear INT, IN userHeight INT)
-- IN : 입력 매개변수 데이터 타입
begin
	-- SQL 문
    select * from usertbl
		where birthYear > userYear and height > userHeight;
end $$
delimiter ;

drop procedure youngerAndTaller;

-- 1970년 이후 170 넘는 사람 조회
call youngerAndTaller(1980, 180);

-- 출력 매개변수 사용하기
DELIMITER $$
CREATE PROCEDURE countTaller(IN userHeight INT, OUT tallerCount INT)
-- OUT : 출력매개변수 -> INTO를 통해 변수에 반환
BEGIN
	-- SQL문
    SELECT count(*) INTO tallerCount
		FROM usertbl 
		WHERE height > userHeight;
END $$
DELIMITER ;

-- 호출하기
call countTaller(170, @cnt);
select @cnt;		-- @cnt 변수에 쿼리문의 결과 값이 저장


-- 조건문
DELIMITER $$
CREATE PROCEDURE checkYear(IN userName VARCHAR(10))
BEGIN
	-- SQL문
    declare yearBirth int;			-- 정수값을 저장하는 변수 선언
    -- 쿼리문의 결과를 변수에 대입
    select birthYear into yearbirth
    from usertbl
    where name = userName;
    
    -- 조건문
    if (yearBirth >= 1980) then
		select '밀레니얼 세대시군요...';
	else
		select 'X세대시군요...';
	end if;
    
END $$
DELIMITER ;

drop procedure checkYear;

call checkYear('김범수');
call checkYear('이승기');


-- 반복문
DELIMITER $$
CREATE PROCEDURE printNumber()
BEGIN
	-- SQL문
    declare counter int default 1;		-- 정수값 변수 1
	
    while counter <= 5 do
		select counter;
		set counter = counter + 1;
    end while;
END $$
DELIMITER ;

call printNumber();


-- 스토어드 프로시저 목록 표시하기
show procedure status;
show procedure status where db = 'sqldb';		-- 특정 db

-- 프로시저 삭제하기
drop procedure userProc;

-- 프로시저 정의 확인하기
show create procedure checkYear;