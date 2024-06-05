-- scott.sql 실행 후 SCOTT 스키마 사용
use scott;
-- 데이터 베이스 탐색
show tables;
desc emp;

-- 전체 테이블 내용을 확인하기
-- *(asterisk) : 모든 열을 선택
select * from emp;

-- 특정 컬럼만 선택하기 (프로젝션(투영))
-- projection attribute
-- 직원 테이블에서 직원번호, 이름, 직무 선택
select empno, ename, job from emp;

-- 특정 조건만 선택하기 (셀렉션(선택))
-- select condition
-- 직원 테이블에서 직무가 'CLERK'인 사람만 선택
select * from emp where job = 'CLERK';

-- 셀렉션 + 프로젝션
-- 직원 테이블에서 직무가 'CLERK'인 사람의 이름과 직무를 선택
select ename, job from emp where job = 'CLERK';

-- where절 조건식
-- 문법 : SELECT 컬럼명, ... FROM 테이블명 WHERE 조건식(condition)

-- 특정 조건에 일치하는 행 선택
select * from emp where job = 'CLERK';

-- 조건에 따른 비교 (>, <, >=, <=)
select * from emp where sal > 1500;

-- 논리 연산자 사용 (AND, OR, NOT)
-- AND(그리고) : 급여가 1500 이상이면서 SALESMAN인 직원 조회
select * from emp where sal > 1500 and job = 'SALESMAN';
-- OR(또는) : 직무가 SALESMAN이거나 부서번호가 30번인 직원 조회
select * from emp where job = 'SALESMAN' or deptno = 30;
-- NOT(아니다) : 직무가 SALESMAN이 아닌 직원 조회
select * from emp where not job = 'SALESMAN';

-- NULL 처리
-- IS NULL : 해당 값(커미션)이 NULL인 직원 조회
select * from emp where comm is null;
-- IS NOT NULL : 해당 값(커미션)이 NULL이 아닌 직원 조회
select * from emp where comm is not null;

-- 별칭 사용 (AS 키워드)
select empno as id, ename as name from emp;

-- 별칭(AS)을 사용하여 계산된 열을 표시                        null인 경우 0으로 처리
select ename as 직원이름, sal as 급여, comm as 상여, sal + ifnull(comm, 0) as 실지급액 from emp;

-- 테이블 이름에 별칭을 부여하여 사용
select emp.ename, emp.job from emp;
select e.ename, e.job from emp as e;
