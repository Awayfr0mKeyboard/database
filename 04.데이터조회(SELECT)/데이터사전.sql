-- 데이터 사전 (Data Dictionary)
-- 데이터를 구성하는 정보가 담겨있는 데이터
-- 메타 데이터(Meta Data)
-- 사용자 정보, DB 객체(테이블, 인덱스, 뷰) 정보
-- 제약 조건, 함수 , 프로시저, 트리거 등

use information_schema;
-- information_schema
-- 표준 스키마, 읽기 전용 테이블, DB 현재 상태 확인

show tables;

-- 데이터 베이스 내의 모든 테이블에 대한 정보를 저장한 테이블
-- information_schema.tables
select * from information_schema.tables;

-- 특정 스키마(DB) 내부에 있는 테이블 정보 조회
-- DB 이름, 테이블 이름, DB 엔진명, 데이터 크기, 생성 시간 등
select table_schema, table_name, engine, data_length, create_time
from information_schema.tables where table_schema = 'world';

-- columns
-- DB 내의 모든 column에 대한 정보
select * from information_schema.columns;

-- 특정 스키마, 특정 테이블의 컬럼 정보 조회
select * from information_schema.columns where table_schema = 'world' and table_name = 'city';

-- table_constraints : DB 내의 전체 테이블 제약 조건에 대한 조회
select * from information_schema.table_constraints;

-- 특정 스키마에 대한 제약 조건 확인
select constraint_name, table_name, constraint_type from information_schema.table_constraints
where table_schema = 'world';

-- DB의 인덱스 정보 조회
select * from information_schema.statistics;

-- 특정 스키마의 인덱스 정보 조회
select table_name, index_name, column_name, seq_in_index from information_schema.statistics
where table_schema = 'world';

-- 데이터 베이스(스키마) 목록 조회
select * from information_schema.schemata;

select schema_name from information_schema.schemata;
show databases;
show schemas;