use scott;

-- 문제 1: emp 테이블에서 사원의 이름(ename)을 소문자로 변환하고, 그 길이를 계산하여 조회하세요.
select ename, lower(ename), length(ename) from emp;

-- 문제 2: emp 테이블에서 사원의 급여(sal)를 백의자리까지 반올림하고, 그 값을 조회하세요.
select sal, round(sal, -3) from emp;

-- 문제 3: emp 테이블에서 사원의 입사일(hiredate)로부터 현재까지의 일 수를 계산하여 조회하세요.
select hiredate, datediff(now(), hiredate) from emp;

-- 문제 4: emp 테이블에서 사원의 급여(sal)가 3000 이상이면 'High', 그렇지 않으면 'Low'를 반환하는 쿼리를 작성하세요.
select ename, if(sal >= 3000 , 'High', 'Low') from emp;

-- 문제 5: emp 테이블에서 사원의 이름(ename)과 직업(job)을 결합하고, 그 결합된 문자열을 소문자로 변환하여 조회하세요.
select lower(concat(ename, '-', job)) from emp;

-- 문제 6: emp 테이블에서 사원의 입사일(hiredate)에 6개월을 더한 날짜를 계산하여 조회하세요.
select hiredate, adddate(hiredate, interval 6 month) from emp;

-- 문제 7: emp 테이블에서 사원의 입사일(hiredate)이 속한 달의 마지막 날을 조회하세요.
select hiredate, last_day(hiredate) from emp;