use scott;

-- 문제1.
-- 전체 사원 중 ALLEN과 같은 직책 (JOB)인 사원들의 사원 정보, 부서 정보를 출력하는 SQL문을 작성하세요.
select e.ename, e.deptno from emp e
where e.job = (
	select job from emp where ename = 'ALLEN'
);

-- 문제2.
-- 직책이 SALESMAN 인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보 , 급여 등급 정보를 출력하는 SQL문을 작성하세요.
-- (방법 2가지 : 단일행 함수 사용하는 법, 다중행 함수 사용하는 법)

-- 단일행
select * from emp e where sal >
	(select max(sal) from emp where job = 'salesman');

-- 다중행
select emp.job, emp.sal from emp where sal > all
	(select sal from emp where job = 'salesman');