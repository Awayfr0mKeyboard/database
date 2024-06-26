-- 인덱스
drop schema if exists index_db;
create schema if not exists index_db;
use index_db;

/*
	인덱스
    - 데이터베이스의 검색 성능을 향상시키기 위해 사용하는 자료 구조
    - 책의 목차와 유사하게 특정 데이터를 빠르게 찾을 수 있게 도와줌
    - B-Tree 자료 구조를 사용하여 효율적으로 인덱스 검색, 삽입, 삭제
*/

-- 테이블을 생성할 때 자동으로 생성되는 인덱스
create table tbl1 (
	id int primary key,
    column_a int,
    column_b int
);

-- 인덱스 확인
show index from tbl1;
-- 기본 키 제약조건을 지정할 경우 자동으로 primary 인덱스가 생성

create table tbl2 (
	id int primary key,
    column_a int unique,
    column_b int unique,
    column_c int
);

show index from tbl2;
-- UNIQUE 제약 조건 : 한 테이블의 여러 개의 인덱스(컬럼명)가 자동 생성

create table tbl3 (
	id int primary key,
    column_a int,
    column_b int,
    tbl2_id int,
    foreign key (tbl2_id) references tbl2(id)
);

show index from tbl3;
-- 다른 테이블을 참조하는 외래키 제약 조건도 자동으로 인덱스 생성

-- 직접 인덱스 생성하기
create index idx_column_b on tbl3(column_b);		-- column_b를 기준으로 인덱스 생성
show index from tbl3;								-- 생성된 인덱스 확인

-- 복합 인덱스 생성
create index idx_a_b on tbl3(column_a, column_b);	-- 두 개 이상의 열을 기준으로 인덱스 생성
show index from tbl3;

-- 인덱스 삭제하기
drop index idx_a_b on tbl3;
show index from tbl3;