use world;

-- 문제 1: COUNT()와 GROUP BY 사용
-- 1. country 테이블에서 대륙(Continent)별 나라의 수를 구하세요.
select continent, count(*) from country group by continent
order by count(*) desc;

-- 문제 2: SUM()와 GROUP BY 사용
-- 2. country 테이블에서 대륙(Continent)별 전체 인구(Population)의 합계를 구하세요.
select continent, sum(population) as 대륙별인구수 from country GROUP BY continent;

-- 문제 3: AVG()와 GROUP BY 사용
-- 3. country 테이블에서 대륙(Continent)별 평균 인구(Population)를 구하세요.
select continent, round(avg(population)) from country group by continent;

-- 문제 4: MAX()와 GROUP BY 사용
-- 4. country 테이블에서 대륙(Continent)별 최대 인구(Population)를 구하세요.
select continent, max(population) from country group by continent;

-- 문제 5: MIN()와 GROUP BY 사용
-- 5. country 테이블에서 대륙(Continent)별 최소 인구(Population)를 구하세요.
select continent, min(population) from country group by continent;

-- 문제 6: COUNT(DISTINCT)와 GROUP BY 사용
-- 6. countrylanguage 테이블에서 각 나라(CountryCode)별 사용되는 고유 언어(Language)의 수를 구하세요.
select countrycode, count(distinct(language)) from countrylanguage group by countrycode; 

-- 문제 7: GROUP BY와 HAVING 사용
-- 7. country 테이블에서 대륙(Continent)별 나라의 수가 10개 이상인 대륙의 이름과 나라의 수를 구하세요.
select continent, count(*) from country group by continent having count(*) > 10; 

-- 문제 8: WHERE, 집계 함수, GROUP BY, ORDER BY 사용
-- 8. city 테이블에서 인구가 100만 이상인 도시들만을 대상으로 각 국가(CountryCode)별 도시의 수를 구하고,
--    도시의 수가 많은 순서대로 정렬하세요.
select countrycode, count(*) from city 
where population >= 1000000
group by countrycode order by count(*) desc;

-- 문제 9: ROLLUP, 집계 함수, GROUP BY
-- 9. country 테이블에서 각 대륙(Continent)별, 지역(Region)별 총 인구(Population)를 구하세요.
--    ROLLUP을 사용하여 대륙별 총계와 전체 총계를 포함하세요.
select continent, region, sum(population) from country group by continent, region with rollup;