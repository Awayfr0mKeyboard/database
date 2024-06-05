-- 기본 문법 : select 컬럼명 from 테이블명 order by 컬럼명 ASC|DESC
-- 컬럼명 : 정렬할 기준이 되는 열
-- ASC : 오름차순
-- DESC : 내림차순

use scott;

-- sal 기준으로 오름차순 정렬 (ASC, DESC 생략 시 기본값 : 오름차순)
-- 급여 적은 순으로 직원 정렬하여 조회 (오름차순)
select * from emp order by sal;

-- 급여 많은 순으로 직원 정렬하여 조회 (내림차순)
select * from emp order by sal desc;

-- 여러 컬럼을 기준으로 정렬하기
-- 부서 기준으로 정렬하고 각 부서 내부에서 급여 많은 순으로 조회
select * from emp order by deptno asc, sal desc;

-- LIMIT : 조회 결과를 제한
-- 급여를 가장 적게 받는 3인을 조회
select * from emp order by sal limit 3;

-- 급여를 가장 많이 받는 3인을 조회
select * from emp order by sal desc limit 3;

-- OFFSET : 결과 셋에서 몇 행을 건너 뛸 때 사용
-- 급여 많이 받는 순위 4 ~ 6위 까지를 조회
select * from emp order by sal desc limit 3 offset 3;

-- LIMIT ~ OFFSET은 대규모의 데이터 셋에서 필요한 부분만 조회
-- 응답 시간과 성능을 최적화하여 사용자 경험을 개선
-- 데이터 페이지네이션(Pagenation)

-- DISTINCT : 중복된 값을 제거하고 고유값만 반환
-- 직원 테이블에서 어떤 직무가 있는지 조회
select distinct job from emp;
-- 직원 테이블에서 어떤 부서 번호가 있는지 조회
select distinct deptno from emp;
-- 직원 테이블에서 어떤 부서 번호가 있는지 조회 + 오름차순 정렬
select distinct deptno from emp order by deptno;