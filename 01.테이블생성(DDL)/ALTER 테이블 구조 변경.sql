/* ALTER문 연습 */
drop schema if exists alter_db;
create schema alter_db;
use alter_db;

-- 테이블 생성 (샘플 데이터베이스에서 테이블 구조를 복사)
create table employees
	like employees.employees;
    -- employees DB의 employees 테이블 구조와 같은 테이블을 현재 DB에 생성한다.

desc employees;					-- 테이블 구조 확인
select * from employees;		-- 데이터는 복사되지 않음

-- 1. ADD 새로운 컬럼 추가
	-- ADD COLUMN 컬럼명 데이터 타입
alter table employees
	add column phone_number varchar(20);

-- 2. DROP 컬럼 삭제
	-- DROP COLUMN 컬럼명
alter table employees
	drop column phone_number;
    
-- 3. CHANGE 컬럼명 변경하기
alter table employees
	change column first_name FIRSTNAME varchar(14);
    
-- 4. MODIFY 데이터 타입 변경하기
alter table employees
	modify column hire_date DATETIME;
    
-- 5. RENAME 테이블 이름 변경하기
alter table employees
	rename to employees_ABC;
alter table employees_ABC
	rename to employees;


desc employees;

/* 제약조건 변경 */

alter table employees
	add column email VARCHAR(255);	-- 1. 일반 컬럼 추가

alter table employees
	add unique (email);				-- 2. 고유 제약 조건 추가

desc employees;						-- 구조 확인

-- 외래키 제약조건 추가하기
-- 1. 참조할 테이블 만들기
create table department (
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);

-- 2. 외래키로 사용할 컬럼을 추가 (참조할 테이블의 기본키와 같은 타입)
alter table employees
	add column department_id INT;
    
-- 3. 외래키 제약 조건을 추가 (CONSTRAINT 제약 조건의 이름)
alter table employees
	add constraint fk_department_id
    foreign key (department_id) references department(department_id);
    
desc employees;

-- 체크 제약 조건 추가하기
alter table employees
	add column age int;		-- 1. 컬럼 추가하기

alter table employees
	add constraint chk_age	-- 제약 조건의 이름 명시
    check (age > 19);		-- 2. 체크 제약 조건 추가
    
desc employees;

-- 컬럼에 대한 설명(COMMENT) 추가하기
alter table employees
	add column salary int
    comment '직원이 받는 급여 컬럼입니다.';
    
-- 제약 조건 삭제하기
-- 1. 외래 키 삭제하기
alter table employees
	drop foreign key fk_department_id;	-- 제약 조건의 이름을 통해 삭제
    
-- 2. 제약 조건 삭제하기
alter table employees
	drop constraint chk_age;
    
-- ALTER 컬럼의 속성 변경하기
-- DEFAULT 제약 조건
alter table employees
	alter column age set default 20;	-- 컬럼에 DEFAULT 추가(수정)
    
desc employees;

-- 기본값 제약 조건 삭제
alter table employees
	alter column age drop default;		-- 컬럼의 제약 사항 변경
    
-- 제약 조건의 이름을 확인하기
-- 1. 오브젝트를 통해 확인
select * from information_schema.table_constraints
	where table_name = 'employees';
    
-- 2. DDL문을 통해서 확인
show create table employees;