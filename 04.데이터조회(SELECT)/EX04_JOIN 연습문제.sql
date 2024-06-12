use sakila;

-- MySQL 샘플 DB sakila : 영화 대여점 비즈니스 모델 기반으로 설계된 DB

-- JOIN 연습문제
-- sakila 데이터베이스에서 조회하세요.

-- 문제 1: 고객(customer)의 이름과 그들이 대여(rental)한 영화(film)의 제목을 조회하세요.
-- 선택할 컬럼 : 이름(first_name, last_name) 영화 제목(title)
-- 사용 테이블: customer(customer_id, first_name, last_name), rental(rental_id, customer_id, inventory_id), film(film_id, title), inventory(inventory_id, film_id)
select c.first_name, c.last_name, f.title from customer c
join rental r using (customer_id)
join inventory i using (inventory_id)
join film f using (film_id); 

-- 문제 2: 각 영화(film)의 제목과 해당 영화가 속한 카테고리(category)의 이름을 조회하세요.
-- 선택할 컬럼: 영화제목(film.title), 카테고리이름(category.name)
-- 사용 테이블: film(film_id, title), film_category(film_id, category_id), category(category_id, name)
select f.title, c.name from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.film_id = c.category_id;

-- 문제 3: 각 영화(film)에 대해 몇 명의 배우(actor)가 출연했는지, 영화 제목과 함께 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 영화배우 수(count(film_actor.actor_id))
-- 사용 테이블: film(film_id, title), film_actor(film_id, actor_id), actor(actor_id, first_name, last_name)
select f.film_id, f.title as 영화제목, count(fa.actor_id) as 배우_수 
from film f
join film_actor fa on f.film_id = fa.film_id
group by f.film_id;

-- 문제 4: 모든 대여(rental) 정보에 대해, 해당 대여가 이루어진 스토어(store)의 ID와 직원(staff)의 이름을 조회하세요.
-- 선택할 컬럼 : 대여ID(rental_id), 스토어ID(stord_id), 스탭이름(first_name, last_name)
-- 사용 테이블: rental(rental_id, staff_id), store(store_id), staff(staff_id, first_name, last_name, store_id)
select r.rental_id, s.store_id, st.first_name, st.last_name from staff st
join rental r using (staff_id)
join store s using (store_id);

-- 문제 5: 가장 많이 대여된 영화 5개의 제목과 대여 횟수를 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 대여횟수(count(rental_id))
-- 사용 테이블: film(film_id, title), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
select f.film_id, f.title, count(r.rental_id) 대여횟수 from film f
join inventory i using (film_id)
join rental r using (inventory_id)
group by f.film_id
order by count(r.rental_id) desc
limit 5;

-- 문제 6: 각 고객(customer)별로 그들이 지불한 총 금액(payment)을 조회하세요.
-- 선택할 컬럼 : 고객ID(customer_id), 총 금액(sum(payment.amount))
-- 사용 테이블: customer(customer_id, first_name, last_name), payment(payment_id, customer_id, amount)
select c.customer_id, sum(p.amount) from customer c
join payment p using (customer_id)
group by c.customer_id;

-- 문제 7: 각 카테고리(category)별로 대여된 영화의 총 수를 조회하세요.
-- 선택할 컬럼 : 카테고리ID, 이름(category_id, name), 총 대여 수(count(rental_id)
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), inventory(inventory_id, film_id), rental(rental_id, inventory_id)
select c.category_id, c.name, count(rental_id) from category c
join film_category f using (category_id)
join inventory i using (film_id)
join rental r using (inventory_id)
group by category_id;

-- 문제 8: 2005년 7월에 대여된 모든 영화의 제목과 대여 날짜를 조회하세요.
-- 선택할 컬럼 : 영화제목(film.title), 대여날짜(rental.rental_date)
-- 사용 테이블: rental(rental_id, rental_date, inventory_id), inventory(inventory_id, film_id), film(film_id, title)
select r.rental_date, f.title from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where r.rental_date between '2005-07-01' and '2005-07-31';

-- 문제 9: 'Comedy' 카테고리에 속하는 영화들의 평균 대여 기간(rental_duration)을 조회하세요.
-- 선택할 컬럼 : 카테고리명(category_name) 대여기간(film.rental_duration)
-- 사용 테이블: category(category_id, name), film_category(film_id, category_id), film(film_id, title, rental_duration)
select c.name, avg(f.rental_duration) from category c
join film_category fc using (category_id)
join film f using (film_id)
where c.name = 'comedy';

-- 문제 10: 모든 배우(actor)의 이름과 그들이 출연한 영화(film)의 수를 조회하세요. (LEFT JOIN 사용)
-- 선택할 컬럼 : 배우 이름(actor.first_name, actor.last_name), 영화수(count(film_id))
-- 사용 테이블: actor(actor_id, first_name, last_name), film_actor(actor_id, film_id), film(film_id)
select a.first_name, a.last_name, count(f.film_id) from actor a
left join film_actor fm using (actor_id)
join film f using (film_id)
GROUP BY actor_id;
