-- 팀장님 권한(DBA 권한)
-- 모든 권한이 존재, 모든 명령이 수행 가능
-- 모든 데이터베이스와 모든 테이블을 제어 가능

-- DDL으로 DB 객체를 생성하고 삭제
CREATE DATABASE ddbd;
DROP DATABASE IF EXISTS ddbd;

-- 특정 데이터베이스에 접근하여 테이블 객체 생성 삭제
USE shopdb;
create TABLE test(id int);
DROP TABLE test;