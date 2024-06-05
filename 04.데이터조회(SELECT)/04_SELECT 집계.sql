use scott;

-- count() : 행의 개수를 세는 집계 함수
select * from emp;
-- 직원의 수
select count(*) from emp;
-- 직원 이름의 수 : 특정 컬럼명 지정
select count(ename) from emp;
-- 직원 상여금의 수 집계 : null 값은 세지 않는다.
select count(comm) from emp;
-- 급여가 2000 이상인 직원 수 세기 (조건 명시)
select count(*) from emp where sal > 2000;

-- 중복된 값을 제외하고 고유값의 개수만을 셀 때
select count(distinct job) from emp;
select distinct job from emp;

-- sum() : 숫자 타입의 열의 합계
-- 모든 직원의 급여 합계
select sum(sal) from emp;
-- null이 포함된 경우 null을 제외한 합계
select sum(comm) from emp;

-- 셀렉션 : 20번 부서의 직원들 급여 합계
select sum(sal) from emp where deptno = 20;


-- avg() : 숫자 타입의 컬럼의 평균 계산
select avg(sal) from emp;

-- round() : 반올림과 함께 사용
select round(avg(sal)) from emp;
select round(avg(sal), 2) from emp;		-- 소수점 2째 자리 반올림
select round(avg(sal), -2) from emp;	-- 10의 자리 반올림

-- max() : 열의 최대값을 반환
select max(sal) from emp;		-- 숫자 타입은 가장 큰 값
select max(ename) from emp;		-- 문자 타입은 문자셋 정수가 큰 값(A~Z의 경우 Z)
select max(hiredate) from emp;	-- 날짜 타입은 최근

-- min() : 열의 최소값을 반환
select min(sal) from emp;		-- 숫자 타입은 가장 작은 수
select min(ename) from emp;		-- 문자 타입은 문자셋 정수가 작은 값(A~Z의 경우 A)
select min(hiredate) from emp;	-- 가장 오래된 날짜

-- stddev() : 표준 편차, var_samp() 분산 등 통계 함수가 있음
select stddev(sal), var_samp(sal) from emp;

-- GROUP BY 절 : 데이터를 그룹으로 묶어주는 역할
-- 지정된 열을 기준으로 그룹화하고, 집계 함수를 적용

-- 부서별 직원 수 조회
select deptno, count(*) from emp group by deptno;

-- 부서별 급여 합계 조회
select deptno, sum(sal) from emp group by deptno;

-- 부서별 급여 평균 조회
select deptno, avg(sal) from emp group by deptno;

-- 부서별 최소, 최대 급여 조회
select deptno, min(sal), max(sal) from emp group by deptno;

-- HAVING 절 : GROUP BY로 그룹화된 데이터에 조건 적용 시 사용
-- 부서별 직원 수가 5명 이상인 부서 조회
select deptno, count(*) from emp group by deptno having count(*) >= 5;
-- 부서별 월급 합계가 10000 달러 이상인 부서 조회
select deptno, sum(sal) from emp group by deptno having sum(sal) > 10000;
-- WHERE 절은 데이터가 그룹화되기 전에 조건을 적용 (모든 개별 행)
-- HAVING 절은 데이터가 그룹화된 결과에 조건을 적용 (그룹별 단일 행)
select deptno, sum(sal) from emp 
where sal > 1500 			-- 원래 테이블의 각 행에 조건 적용
group by deptno 
having sum(sal) > 5000;		-- 그룹별 결과셋에 조건 적용


-- ROLL UP : 분류별 소합계 및 총합, 요약 정보를 얻을 때
-- 그룹별로 데이터 분석을 하거나 요약 보고서를 작성할 때 사용
-- 결과 셋의 NULL 값은 소합계 또는 총계를 나타냄

-- 부서별, 직업별 합계 및 전체 합계 구하기
select deptno, job, sum(sal) from emp group by deptno, job with rollup;

