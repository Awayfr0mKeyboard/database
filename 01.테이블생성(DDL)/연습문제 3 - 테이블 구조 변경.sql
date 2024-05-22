USE exercise;

-- 연습 문제 1: departments 테이블에 고유 제약조건을 삭제한 후 다시 추가하세요.
alter table departments
	drop constraint dept_name;		-- 제약 조건 이름으로 삭제
alter table departments
	add unique (dept_name);			-- 유니크 제약 조건 추가
/* 인덱스(유니크 제약 조건에서 생성되는 인덱스)로 삭제하기 */
alter table departments
	drop index dept_name;
desc departments;
    
-- 연습 문제 2: departments 테이블에서 location 컬럼에 NOT NULL 제약조건을 추가하세요.
alter table departments
	modify column location varchar(255) not null;
desc departments;

-- 연습 문제 3: employees 테이블에서 급여가 음수인 경우를 허용하도록 CHECK 제약조건을 삭제하세요.
show create table employees;		-- DDL문 확인
alter table employees
	drop check chk_salary;
desc employees;

-- 연습 문제 4: employees 테이블에 position 컬럼을 추가하고 기본값을 'Staff'로 설정하세요.
alter table employees
	add column position varchar(255) default 'Staff';
desc employees;				-- 구조 확인
select * from employees;	-- 데이터 확인

-- 연습 문제 5: employees 테이블에서 salary 컬럼을 NULL 허용으로 변경하세요.
alter table employees
	modify column salary INT null;
desc employees;

-- 연습 문제 6: projects 테이블에서 project_name 컬럼의 길이를 VARCHAR(100)으로 변경하세요.
alter table projects
	modify column project_name varchar(100) not null;
desc projects;

-- 연습 문제 7: projects 테이블에 budget 컬럼을 추가하고 기본값을 10000으로 설정하세요.
alter table projects
	add column budget int default 10000;
desc projects;

-- 연습 문제 8: projects 테이블에 CHECK 제약조건을 추가하여 프로젝트 예산(budget)이 5000 이상이어야 한다는 조건을 설정하세요.
alter table projects
	add constraint chk_budget
    check (budget >= 5000);
desc projects;

-- 연습 문제 9: assignments 테이블에 UNIQUE 제약조건을 추가하여 동일한 직원과 프로젝트 조합이 중복되지 않도록 하세요.
desc assignments;
alter table assignments
	add constraint unique (emp_id, project_id);

-- 연습 문제 10: assignments 테이블에 assignment_date 컬럼을 추가하고 기본값을 현재 날짜로 설정하세요.
alter table assignments
	add column assignment_date date default(current_date);
desc assignments;

-- 연습 문제 11: departments 테이블에서 location 컬럼을 삭제하세요.
alter table departments
	drop column location;
desc departments;

-- 연습 문제 12: employees 테이블에서 position 컬럼을 삭제하세요.
alter table employees
	drop column position;
desc employees;

-- 연습 문제 13: projects 테이블에서 CHECK 예산 추가 제약조건을 삭제하세요.(제약조건 이름 확인 필요)
desc projects;
alter table projects
	drop constraint chk_budget;

-- 연습 문제 14: projects 테이블에서 다른 체크제약 조건들을 찾아 삭제하세요.(제약조건 이름 확인 필요)
show create table projects;
alter table projects
	drop constraint projects_chk_1;

-- 연습 문제 15: assignments 테이블에서 동일한 직원과 프로젝트 조합이 중복되지 않도록 하는 제약조건을 삭제하세요. (제약조건 이름 확인 필요)
desc assignments;
show create table assignments;
alter table assignments
	drop constraint assignments_ibfk_1,
    drop constraint assignments_ibfk_2;
alter table assignments
	drop constraint unique_emp_id;
-- 외래 키 때문에 바로 삭제 안댐