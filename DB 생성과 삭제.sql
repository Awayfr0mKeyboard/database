-- DDL
-- 데이터의 구조를 정의하는 언어

-- CREATE : 새로운 DB 객체를 만든다.

-- 데이터베이스(스키마) 생성
CREATE DATABASE test_db;
-- MySQL에서는 DATABASE와 SCHEMA가 동일한 개념

-- 데이터베이스 사용 (해당 스키마가 활성화)
USE test_db;

-- 테이블 생성
-- db 객체명에는 띄어쓰기(공백 문자)가 포함 가능함
-- 백틱을 사용해서 객체명을 감싼다.
-- (공백 문자가 없을 경우, 감싸지 않아도 됨)
CREATE TABLE `my TestTBL` (id INT);
-- SCHEMAS 창에 보이지 않을 경우 새로고침 클릭

-- DROP : db 객체를 삭제할 때 사용

-- 테이블 삭제
-- IF EXISTS : 존재할 경우 삭제 (에러를 피할 수 있음)
DROP TABLE IF EXISTS `my TestTBL`;

-- 데이터베이스 삭제
DROP DATABASE IF EXISTS test_db;