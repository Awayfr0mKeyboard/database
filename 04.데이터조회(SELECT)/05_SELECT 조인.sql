use scott;

-- join : 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 출력하여 사용

select * from emp;			-- 직원 정보 테이블 (14 rows)
select * from dept;			-- 부서 정보 테이블 (4 rows)

-- SELECT 문에 2개 이상 테이블을 조회
select * from emp, dept;	-- 14 * 4 = 56 rows 조회

-- 두 개의 테이블 중 deptno가 같은 경우만 조회 => 암시적 조인
select * from emp, dept where emp.deptno = dept.deptno;

-- 테이블 별칭 지정 (AS 문 생략)
select * from emp e, dept d where e.deptno = d.deptno;

-- 특정 컬럼만 프로젝션
select e.ename, e.job, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno;

-- 조인과 함께 셀렉션(조건) 조회
select e.ename, e.job, e.deptno, d.dname, d.loc from emp e, dept d
where e.deptno = d.deptno and e.deptno = 20;

-- 등가 조인(equal join) : 테이블의 특정 열이 일치한 데이터로 선정하는 방식
-- 비등가 조인(non-equal join) : 등가 조인 이외의 모든 방식

select * from salgrade;			-- 급여 등급 정보 테이블
select * from emp;

-- 직원의 급여 등급 범위를 조건식(BETWEEN A AND B)으로 조인
select e.ename, e.sal, s.grade, s.losal, s.hisal from emp e, salgrade s
where e.sal between s.losal and s.hisal;

-- 자체 조인(Self Join)
-- 동일 테이블을 별칭을 사용해서 2개의 테이블이 별개로 있는 것처럼 참조하여 결합하는 방식 
select * from emp;

-- 직원의 매니저의 이름을 조인하여 조회
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_no, e2.ename as mgr_name
from emp e1, emp e2			-- 같은 테이블 별칭 구분
where e1.mgr = e2.empno;	-- 직원의 매니저(e1) = 매니저의 직원 번호 (e2)


-- 명시적 조인
-- JOIN과 ON 키워드를 함께 사용

-- 1. INNER JOIN (두 테이블의 공통된 값이 있는 행을 결합)
select * from emp			-- 테이블1 (왼쪽 테이블 left table)
inner join dept				-- 테이블2 (오른쪽 테이블 right table)
on emp.deptno = dept.deptno;		-- 조인 조건 (공통된 컬럼)

-- 약칭을 사용하고, 특정 컬럼만 프로젝션
select e.ename, e.deptno, d.dname from emp e
inner join dept d
on e.deptno = d.deptno;

-- INNER 키워드를 생략하고 JOIN만 사용할 경우 => INNER JOIN
select e.ename, e.deptno, d.dname from emp e
join dept d
on e.deptno = d.deptno;

-- NATURAL JOIN : 공통된 이름, 데이터 타입을 가진 컬럼을 기준으로 자동으로 등가 조인
-- ON 조건을 사용하지 않음 (주의하여 사용)
select * from emp e
natural join dept d;

-- JOIN ~ USING
-- ON 키워드로 조건을 명시하는 대신, 공통적으로 가지고 있는 열의 이름을 기준으로 JOIN
select e.ename, e.deptno, d.dname from emp e
join dept d USING (deptno);		-- 두 테이블에 공통되는 컬럼


-- 외부 조인
-- 1. LEFT JOIN
-- 왼쪽 테이블의 모든 행을 반환하고, 오른쪽 테이블에 일치하는 행이 없으면 NULL 반환
select * from emp;
select * from dept;

-- 왼쪽 테이블에는 존재하지만, 오른쪽 테이블에 일치하지 않는 데이터 삽입
-- deptno : 50 (오른쪽 테이블에 없는 부서번호)
insert into emp 
value (9999, 'ABC', 'SALESMAN', 7844, '2024-06-12', 1200, null, 50);

-- 내부 조인은 양쪽 테이블의 일치하는 데이터 (14개 행만 반환)
select e.ename, d.deptno, d.dname 
from emp e			-- 왼쪽 테이블
join dept d			-- 오른쪽 테이블
on e.deptno = d.deptno;

-- 내부 조인은 양쪽 테이블의 일치하는 데이터 (14개 행만 반환)
select e.ename, e.deptno, d.deptno, d.dname 
from emp e			-- 왼쪽 테이블 (일치하지 않아도 보여줌)
left join dept d	-- 오른쪽 테이블 (일치하는 것만 보여줌)
on e.deptno = d.deptno;

-- 조인의 기준이 되는 컬럼 고유값
select distinct deptno from emp;
-- 왼쪽에는 존재 오른쪽에는 없는 것 (50)
-- LEFT JOIN에 추가되는 Rows (컬럼 기준)

select distinct deptno from dept;
-- 오른쪽에는 존재 왼쪽에는 없는 것 (40)
-- RIGHT JOIN에 추가되는 Rows (컬럼 기준)

-- 2. RIGHT JOIN
-- 오른쪽 테이블의 모든 행을 반환하고, 왼쪽 테이블에 일치하는 행이 없으면 NULL 반환
select e.ename, d.deptno
from emp e
right join dept d
using (deptno);

-- 임시로 추가한 예시 데이터 삭제
delete from emp where empno = 9999;

-- 3개 테이블 JOIN
select *
from emp e
join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal;

-- ORDER BY와 함게 사용
select *
from emp e
join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
order by sal desc;

-- GROUP BY와 함께 사용 : 부서별 급여 합계
select d.dname, sum(e.sal)
from emp e
join dept d on e.deptno = d.deptno
group by d.dname;		-- 부서 기준으로 그룹화

-- CROSS JOIN
-- 양쪽 테이블의 모든 행을 조인(두 테이블의 행일 곱한 개수를 반환)
-- 카티션 프로덕트
select * from emp
cross join dept;