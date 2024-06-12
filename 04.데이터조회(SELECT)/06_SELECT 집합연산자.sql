use scott;

-- 두 개 이상의 SELECT문의 결과(쿼리)를 집합으로 결합(또는 교집합, 차집합)

-- 1. UNION (합집합)
select * from emp where deptno = 10;			-- 10번 부서 3 rows
select * from emp where deptno = 20;			-- 20번 부서 5 rows

-- 10번 부서와 20번 부서의 합집합 (8 rows)
select * from emp where deptno = 10
union
select * from emp where deptno = 20;

-- 집합 연산자를 사용하려는 데이터 셋의 열 개수와 자료형이 다르면 집합 연산자를 사용할 수 없음
select ename, sal, deptno from emp where deptno = 10
union
select ename, sal, deptno from emp where deptno = 20;

-- 열 개수와 자료형만 맞으면 집합 연산 가능
-- (정상적인 데이터가 들어가지 않을 수 있음)
select ename, empno, sal, deptno from emp where deptno = 10
union
select empno, ename, sal, deptno from emp where deptno = 20;

-- 10번 부서 + 20번 부서 직원 (8 rows)
select * from emp where deptno = 10 or deptno = 20;

-- 20번 부서 + 30번 부서 직원 (11 rows)
select * from emp where deptno = 20 or deptno = 30;

-- {10 + 20번 부서(8)} + {20 + 30번 부서(11)} => 14 rows
-- 중복된 데이터 행(row)은 하나만 남는다. 
select * from emp where deptno = 10 or deptno = 20
union
select * from emp where deptno = 20 or deptno = 30;

-- 2. UNION ALL : 중복 데이터도 모두 포함하여 결과 반환
-- 쿼리1(8 rows) + 쿼리2(11 rows) = 19 rows (20번 부서 중복 포함)
select * from emp where deptno = 10 or deptno = 20
union all
select * from emp where deptno = 20 or deptno = 30;

-- 3. 교집합 (INTERSECT)
-- 두 쿼리의 공통된 행(row)만 반환
-- MySQL은 8.x 버전 이후에만 INTERSECT를 지원 (workbench에서 문법 오류로 안식하기도 함)
select * from emp where deptno = 10 or deptno = 20
INTERSECT
select * from emp where deptno = 20 or deptno = 30;

-- 4. 차집합 (except)
-- 쿼리1의 결과에서 쿼리2의 결과 데이터 셋(교집합)을 제거한 결과 셋 변환
-- Oracle DB에서는 MINUS로 사용됨.
-- MySQL 8.x 버전에서부터 교집합, 차집합 사용에 관한 문서
-- https://dev.mysql.com/blog-archive/intersect-and-except-in-mysql-80/
select * from emp where deptno = 10 or deptno = 20
except
select * from emp where deptno = 20 or deptno = 30;


-- FULL OUTER JOIN
-- MySQL에서는 FULL OUTER JOIN을 지원하지 않음 (Oracle에서는 가능)
-- 구현 방법 : LEFT JOIN과 RIGHT JOIN을 UNION 함으로 구현
select e.ename, d.deptno
from emp e
left join dept d
using (deptno)

union

select e.ename, d.deptno
from emp e
right join dept d
using (deptno);