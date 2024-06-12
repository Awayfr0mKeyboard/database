use scott;

-- 서브 쿼리 : SQL문 내에 포함된 쿼리(SELECT문), 중첩 쿼리, 메인 쿼리의 일부로 동작
-- 메인 쿼리의 일부로 동작

-- JONES씨의 급여 = 2975
select sal from emp where ename = 'JONES';

-- JONES씨보다 급여를 많이 받는 사원의 정보
select * from emp where sal > 2975;		-- 메인 쿼리

select * from emp where sal > (
	select sal from emp where ename = 'JONES'	-- 서브 쿼리
);


-- 단일 행(Single row) 서브 쿼리

-- SCOTT씨보다 빨리 입사한 사원의 정보

-- 1. 서브쿼리 (스콧의 입사일)
select hiredate from emp where ename = 'scott';		-- 1982-12-09

-- 2. 메인 쿼리
select * from emp where hiredate <
	(select hiredate from emp where ename = 'scott');
    
-- 집계 함수 sum, avg, count, min, max => 단일행
-- 30번 부서의 평균 급여보다 높은 급여를 받는 직원 정보

-- 서브 쿼리 : 30번 부서의 평균 => 단일행
select avg(sal) from emp where deptno = 30; 	-- 1566

-- 메인 쿼리
select * from emp where sal > (
	select avg(sal) from emp where deptno = 30
);

-- 다중행(multi-row) 서브쿼리

-- 각 부서별 최고급여와 동일한 급여를 받는 사원 정보
-- 1. 서브 쿼리
select max(sal) from emp GROUP BY deptno;

-- 서브 쿼리가 1행 이상인 경우 Error 발생 (1242)
select * from emp where sal = (
	select max(sal) from emp GROUP BY deptno;
);

-- IN 함수를 사용하는 경우, 여러 개의 값을 인자로 받을 수 있음.
select * from emp
	where sal in (3000, 2850, 5000);		

-- 다중 행 메인 쿼리
select * from emp
	where sal in (
		select max(sal) from emp group by deptno
);

-- ANY : 비교 연산자와 함께 사용
-- 결과 집합 중 하나 이상의 값과 비교할 때 사용

-- 30번 부서 직원들의 급여 (1600, 1250, 1250, 2850, 1500, 950)
select sal from emp where deptno = 30;

-- 30번 부서 직원들의 급여보다 적은 급여를 받는 사람 정보
select * from emp
where sal < any (
	select sal from emp where deptno = 30
);
-- ANY : 인자들 중 하나라도 참이면 참 => 인자들 중 최대값(2850)보다 적은 급여

-- ALL : 서브 쿼리의 모든 집합과 비교, 비교 연산자와 함께 사용
-- 30번 부서 직원들의 급여 (1600, 1250, 1250, 2850, 1500, 950)
-- 결과 셋의 모든 값을 만족해야 통과 => 950보다 적은 값만 만족
select * from emp
where sal < all (
	select sal from emp where deptno = 30
);

-- select 절 내부에서 서브 쿼리 사용
-- 사원의 부서 이름을 조회하는데 서브 쿼리를 사용
select e.ename,
	(select d.dname from dept d where e.deptno = d.deptno) as '부서명'
from emp e;

-- FROM절 내부에서 서브 쿼리 사용
-- 각 부서의 최대 급여를 부서 이름과 조회
select d.dname, max_dept_sal.max_sal from dept d
join (select deptno, max(sal) as max_sal from emp group by deptno) as max_dept_sal
on d.deptno = max_dept_sal.deptno;