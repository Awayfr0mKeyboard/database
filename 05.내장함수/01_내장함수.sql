use scott;

-- 변수 선언
set @variable1 = 5;
set @variable2 = 3;
select @variable1 + @variable2;

-- 직원 급여 평균을 변수로 저장
set @avg_salary = (select avg(sal) from emp);

select @avg_salary;

-- 변수를 사용해서 쿼리 수행 : 평균보다 많이 급여를 받는 사원 조회
select * from emp where sal > @avg_salary;

-- 1. 문자열 함수

-- length(문자열)
select length('hello, sql');
select ename, length(ename) from emp;		-- 직원 이름 길이 문자열

-- uppper(문자열), lower(문자열)
select upper('hello, sql');					-- 대문자로
select ename, lower(ename) from emp;		-- 소문자로

-- substr(문자열, 시작 위치, 길이) : 특정 문자열 추출
select substr('hello, sql', 1, 5);			-- 시작 위치가 1부터 시작
select ename, substr(ename, 1, 3) as short from emp;

-- instr(문자열, 찾을 문자열) : 찾을 문자열이 처음 나타나는 위치 반환
select instr('hello, sql', ',');
select ename, instr(ename, 'A') from emp;	-- 포함되지 않으면 0 반환
-- instr을 사용하여 substr의 인덱스를 계산 (, 이전의 글자 추출)
select substr('hello, sql', 1, instr('hello, sql', ',') - 1);

-- concat(문자열1, 문자열2, ...) : 2개 이상의 문자열을 연결
select concat("안녕하세요", " ", "반갑습니다.");
select ename, job, concat(ename, '-', job) as 'name-job' from emp;
-- concat_ws(구분자, 문자열1, 문자열2, ...) : 2개 이상의 문자열을 구분자 포함 연결
select concat_ws('-', '2024', '06', '19');
select concat_ws('/', '2024', '06', '19');

-- trim, ltrim, rtrim : 기본으로 공백 제거 또는 특정 문자 제거
select trim('           문자열          ');		-- 좌우 공백 제거
select ltrim('           문자열          ');		-- 좌측 공백 제거
select rtrim('           문자열          ');		-- 우측 공백 제거
select trim('-' from '----문자열----');			-- 특정 문자 제거

-- replace(원본 문자열, 찾을 문자열, 대체 문자열) : 다른 문자열로 대체
select replace('문자열', '문자', '유희');
select replace(ename, 'A', '*') from emp;

-- lpad, rpad(문자열, 전체 길이, 패딩 문자) : 패딩 문자를 추가
select lpad('안녕하세요', 10, '#');
select rpad('안녕하세요', 10, '#');
select sal, lpad(sal, 4, '0') from emp;

-- left, right(문자열, 길이) : 문자열의 방향에서 길이만큼 반환
select left('문자열', 2);
select right('문자열', 2);
select left(ename, 3) from emp;

-- reverse(문자열) : 문자열 뒤집어서 반환
select reverse('문자열');

-- repeat(문자열, 횟수) : 횟수만큼 문자열 반복
select repeat('문자열', 5);

-- space(길이) : 길이만큼의 공백을 반환
select concat('문', space(5), '자', space(5), '열');

-- ascii(문자열) : 첫 번째 글자의 아스키 문자열 반환
select ename, ascii(ename) from emp;

-- 2. 숫자 함수

-- round(숫자, 소수점 자리수) : 반올림
select round(10.4567), round(10.4567, 2), round(4567.1234, -2);

-- 올림 ceil(숫자), 내림 floor(숫자)
select ceil(23.456), floor(56.789);

-- 거듭제곱 pow, power(숫자, 거듭제곱 값)
select pow(4, 2), pow(4, 3), pow(2, 10);

-- 제곱근 sqrt(숫자)
select sqrt(16);

-- log 자연로그, log10 상용로그
select log(2.71828), log10(100);

-- mod(숫자, 나눌 숫자) : 나머지 연산
select mod(10, 3);		-- 나머지 1

-- pi() : 원주율
select pi();

-- 3. 날짜 함수

-- now() : 현재 날짜 시간
select now();

-- curdate() : 현재 날짜, curtime() : 현재 시간
select curdate(), curtime();

-- date(DATETIME|TIMESTAMP 타입 등) : 전체 날짜 시간에서 날짜만 반환
select date(now()), time(now());
select date('2024-06-19 10:35:21'), time('2024-06-19 10:35:21');

-- year, month, day(DATE|DATETIME|TIMESTAMP 날짜 타입) : 연 월 일 추출
select ename, hiredate,
	year(hiredate), month(hiredate), day(hiredate)
from emp;

-- hour, minute, second(시간 타입) : 시 분 초 추출
select now(), hour(now()), minute(now()), second(now());

-- date_add(날짜값, INTERVAL 간격(DAY, MONTH, YEAR) : 지정된 날짜 더하기
select now(), date_add(now(), interval 7 day);		-- 일주일 후
select now(), date_add(now(), interval 7 month);	-- 7개월 후
select now(), date_add(now(), interval 7 year);		-- 7년 후

-- date_sub(날짜값, INTERVAL 간격(DAY, MONTH, YEAR) : 지정된 날짜 빼기
select now(), date_sub(now(), interval 7 day);		-- 일주일 전
select now(), date_sub(now(), interval 7 month);	-- 7개월 전
select now(), date_sub(now(), interval 7 year);		-- 7년 전

-- datediff(날짜1, 날짜2) : 날짜 차이를 일 단위로
select datediff(now(), '2020-01-01');

-- timestampdiff(단위, 날짜1, 날짜2) : 지정된 단위로 날짜/시간 차이 반환
select timestampdiff(month, now(), '2020-01-01');
select timestampdiff(year, now(), '2020-01-01');
select timestampdiff(hour, now(), '2020-01-01 01:01:01');

-- date_format(날짜, 날짜 형식) : 날짜값을 지정된 형식의 문자열로 반환
select date_format(now(), '%Y-%m-%d');
select date_format(now(), '%Y년 %m월 %d일');

-- last_day(날짜 타입) : 주어진 달의 마지막 날 반환
select now(), last_day(now());
select '2024-02-01', last_day('2024-02-01');

-- 4. 변환 함수

-- cast(값 as 타입) : 데이터를 지정된 타입으로 변환
select cast(1000 as char);				-- 숫자를 문자열 타입으로
select cast(sal as char) from emp;		-- 숫자를 문자열 타입으로
-- select cast(ename as int) from emp;		-- 문자열 -> 숫자(X)

-- convert(값, 데이터 타입) : 타입 변환
select convert(1000, char);				-- 숫자를 문자열 타입으로

-- str_to_date(날짜 타입의 문자열, 날짜 형식) : 문자열을 날짜 타입으로 변환
select str_to_date('2024년 6월 19일', '%Y년 %m월 %d일');

-- format(숫자, 소수점 자리수) : 숫자를 1000단위마다 콤마가 붙여진 문자열로 변환
select format(1234567812345, 2);
select format(1234567812345, 0);

-- 5. 집계 함수 : count, sun, avg, min, max -> Groupby에서 다룸


-- 6. 시스템 정보 함수
select version();			-- MySql 서버 버전 반환
select database();			-- 현재 선택(use)된 데이터 베이스 반환
select user();				-- 현재 세션에 접속된 사용자와 호스트 정보 반환
select current_timestamp();	-- 현재 시스템 상 날짜 시간 반환

select @@hostname;			-- 서버에 호스트 이름 반환
select @@port;				-- MySql 서버 포트 반환

-- sleep(n) : 쿼리 실행을 n초간 멈춤
select sleep(3);
select '3초 후의 쿼리';


-- 7. 제어 흐름 함수

-- if(조건, 참일 때, 거짓일 때)
select if(100 < 101, '참', '거짓');
select if(100 > 101, '참', '거짓');

-- ifnull(표현식, 대체할 값) : 만약 첫 번째 인자 표현식이 null이면 대체값(두 번째 인자) 반환
select ifnull(null, '빈값');
select ename, sal, comm from emp;				-- null 존재 컬럼(comm)
select ename, sal, ifnull(comm, 0) from emp;	-- null -> 0 대체

-- nullif(표현식1, 표현식2) : 두 표현식이 같으면 null, 다르면 표현식1(첫 번째 인자)반환
select nullif(100, 100), nullif(100, 0);

-- 커미션이 null이면 0으로 반환하여 계산 (ifnull)
select ename, sal, comm, sal+ifnull(comm, 0) as total_sal from emp;

-- 급여 합계와 급여가 같으면 null을 반환 (nullif)
select ename, sal, comm, sal+ifnull(comm, 0) as total_sal, nullif(sal, sal+ifnull(comm, 0)) from emp;

