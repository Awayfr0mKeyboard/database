use world;

-- 문제 1: ORDER BY와 LIMIT 사용
-- 1. country 테이블에서 인구(Population)가 많은 상위 10개의 나라를 조회하세요.
select name from country order by population desc limit 10;

-- 문제 2: ORDER BY와 LIMIT, OFFSET 사용
-- 2. city 테이블에서 인구(Population)가 많은 상위 10번째에서 20번째까지의 도시를 조회하세요.
select name from city order by population desc limit 10 offset 9;

-- 문제 3: ORDER BY와 LIMIT, OFFSET 사용
-- 3. country 테이블에서 대륙(Continent)이 'Asia'인 나라들을 면적(SurfaceArea) 기준으로 내림차순 정렬하여 상위 5개의 나라를 조회하세요.
select name, surfacearea from country where continent = 'Asia' order by surfacearea desc limit 5;

-- 문제 4: ORDER BY와 LIMIT 사용
-- 4. city 테이블에서 이름(Name)을 오름차순 정렬하여 첫 5개의 도시를 조회하세요.
select name from city order by name limit 5;

-- 문제 5: DISTINCT 사용
-- 5. country 테이블에서 고유한 대륙(Continent) 목록을 조회하세요.
select distinct continent from country;

-- 문제 6: ORDER BY와 DISTINCT 사용
-- 6. city 테이블에서 고유한 국가 코드(CountryCode)를 조회하고, 이를 오름차순으로 정렬하세요.
select distinct countrycode from city order by countrycode;



-- (2)


-- 1. country 테이블에서 대륙(Continent)이 'Asia'인 나라들 중 인구(Population)가 많은 상위 5개 나라를 조회하세요.
-- 결과는 나라 이름(Name)과 인구(Population)를 내림차순으로 정렬하여 조회하세요.
select name, population from country where continent = 'Asia' order by population desc limit 5;

-- 2. countrylanguage 테이블에서 고유한 나라 코드(CountryCode) 목록을 조회하세요.
-- 결과는 나라 코드(CountryCode)를 오름차순으로 정렬하여 조회하세요.
select distinct countrycode from countrylanguage order by countrycode;

-- 3. city 테이블에서 이름(Name)이 'S'로 시작하는 도시들 중 인구(Population)가 많은 상위 5개 도시를 조회하세요.
-- 결과는 도시 이름(Name)과 인구(Population)를 내림차순으로 정렬하여 조회하세요.
select name, population from city where name like 'S%' order by population desc limit 5;

-- 4. country 테이블에서 인구(Population)가 1000만에서 5000만 사이인 나라들을 조회하세요.
-- 결과는 나라 이름(Name)과 인구(Population)를 인구가 많은 순서로 정렬하여 조회하세요.
select name, population from country where population between 10000000 and 50000000 order by population desc; 

-- 5. country 테이블에서 대륙(Continent)이 'Europe', 'Asia', 'North America'인 나라들 중 GNP가 높은 상위 10개 나라를 조회하세요.
-- 결과는 나라 이름(Name)과 GNP를 내림차순으로 정렬하여 조회하세요.
select name, gnp from country where continent in ('europe', 'asia', 'north america') order by gnp desc limit 10;