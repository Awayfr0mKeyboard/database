/*
	View : 실제 데이터를 저장하지 않고, 기본 테이블의 쿼리 결과를 기반으로 생성되는 가상의 테이블
*/

use sqldb;

select * from usertbl;
select * from buytbl;

-- 뷰 생성
create view view_user as
	Select userId, name from usertbl;
    
-- 뷰 조회
select * from view_user;		-- 테이블처럼 조회 가능
desc view_user;					-- 테이블처럼 구조 확인 가능
desc usertbl;
-- 실제(물리적) 테이블에서는 기본키 제약 조건이 존재하지만
-- 가상(논리적) 테이블에서는 기본키 제약 조건이 존재하지 않음
-- 컬럼명, 타입 동일

-- 가상 테이블과 실제 테이블이 조건이 동일할 경우에만 삽입 가능
insert into view_user values ('ABC', '에비씨');

-- 제약 조건이 일치할 경우 DML 수행됨 -> 실제 테이블에 반영
update view_user set name = '바비킴'
	where userId = 'BBK';
    
select * from view_user;		-- 뷰
select * from usertbl;			-- 물리적 테이블

-- 뷰 생성 시 내장함수, 컬럼명 변경, 조인 가능
create view view_user_buy as
	select u.userId '아이디', 
		   u.name '이름',
           b.prodName '상품명',
           u.addr '주소',
		   concat(u.mobile1, '-', u.mobile2) '전화번호'
    from usertbl u
    inner join buytbl b on u.userId = b.userId;

select * from view_user_buy;
desc view_user_buy;
-- 뷰로 생성된 가상 테이블(쿼리 결과)은 실제 테이블처럼 사용 가능

select 아이디, 이름 from view_user_buy;

-- create or replace view
-- 기존의 동일한 이름의 뷰가 있다면 에러 대신 덮어쓰기
create or replace view view_user_buy as
	select u.userId '아이디', 
		   u.name '이름',
           b.prodName '제품명',
           u.addr '지역',
		   concat(u.mobile1, '-', u.mobile2) '전화번호'
    from usertbl u
    inner join buytbl b on u.userId = b.userId;

select * from view_user_buy;
desc view_user_buy;

-- 뷰 목록 조회하기
show tables;		-- 물리적 테이블과 가상 테이블 구분 안됨
show full tables;	-- 테이블의 타입이 같이 조회

-- 뷰만 조회하기
show full tables where table_type = 'VIEW';

-- 데이터 사전에서 뷰 조회하기
select * from information_schema.views;
-- 데이터 사전에서 특정 DB의 뷰 목록만 조회하기
select * from information_schema.views
	where table_schema = 'sqldb';

-- 뷰 삭제하기
drop view view_user_buy;

/*
	뷰 사용의 장점
    1. 데이터 보안 강화 : 사용자가 실제 테이블에 접근하지 못하게하여 정보 노출을 방지
    2. 데이터 접근 단순화 : 여러 테이블을 조인하거나 복잡한 셀렉트문의 결과를 반복적으로 사용해야 할 경우
    3. 쿼리 재사용 : 한 번 정의된 뷰는 다른 쿼리에서 재사용 가능
*/