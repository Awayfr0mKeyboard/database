-- select 연습문제
-- world 샘플 데이터베이스
use world;
show tables;
desc city;
desc country;

-- 문제 1: SELECT * 와 특정 열 선택
-- 1. country 테이블에서 모든 열을 선택하여 조회하세요.
-- 2. city 테이블에서 ID, Name, CountryCode 열을 선택하여 조회하세요.
select * from country;
select id, city.name, countrycode from city;

-- 문제 2: 별칭 사용 (AS 키워드)
-- 1. country 테이블에서 Name 열을 CountryName이라는 별칭으로 선택하여 조회하세요.
-- 2. city 테이블에서 Name을 CityName으로, Population을 CityPopulation으로 별칭을 붙여 선택하여 조회하세요.
select country.name as CountryName from country;
select name as CityName, population as CityPopulation from city;

-- 문제 3: WHERE 절
-- 1. country 테이블에서 Continent가 'Asia'인 나라들을 조회하세요.
-- 2. city 테이블에서 Population이 5000000 이상인 도시들을 조회하세요.
-- 3. country 테이블에서 Region이 'Eastern Europe'인 나라들을 조회하세요.
select * from country where continent = 'asia';
select * from city where population > 5000000;
select * from country where region = 'eastern europe';

use world;
-- 문제 1: BETWEEN ... AND 사용
-- 1. country 테이블에서 인구(Population)가 2000만에서 5000만 사이인 나라들의 이름과 인구를 조회하세요.
select name, population from country where population between 20000000 and 50000000;

-- 문제 2: IN() 사용
-- 2. country 테이블에서 Continent가 'Africa', 'South America', 'Oceania' 중 하나인 나라들의 이름과 대륙을 조회하세요.
select name, continent from country where continent in ('Africa', 'south america', 'oceania');

-- 문제 3: LIKE 사용
-- 3. city 테이블에서 이름(Name)이 'A'로 시작하는 도시들의 이름을 조회하세요.
select name from city where name like 'a%';