use insert_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 샘플 데이터 삽입
INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop', 'Electronics', 1000.00, 10),
('Smartphone', 'Electronics', 600.00, 20),
('Tablet', 'Electronics', 400.00, 30),
('Headphones', 'Accessories', 50.00, 100),
('Charger', 'Accessories', 20.00, 150);

INSERT INTO sales (product_id, sale_date, quantity) VALUES
(1, '2023-01-10', 2),
(2, '2023-01-12', 1),
(3, '2023-01-15', 3),
(1, '2023-01-20', 1),
(4, '2023-01-25', 5);

select * from products;

-- 연습문제 1: 새로운 제품 삽입
-- 새로운 제품 'Mouse'를 'Accessories' 카테고리에 가격 25.00, 재고 200으로 삽입하세요.
INSERT INTO products 
	VALUES (6, 'Mouse', 'Accessories', 25.00, 200);
select * from products;

-- 연습문제 2: 제품 가격 업데이트
-- 'Smartphone'의 가격을 650.00으로 업데이트하세요.
UPDATE products
	SET price = 650.00
    WHERE product_id = 2;
select * from products;

-- 연습문제 3: 재고 수량 업데이트
-- 'Laptop'의 재고를 15로 업데이트하세요.
UPDATE products
	SET stock = 15
    WHERE product_id = 1;
select * from products;

-- 연습문제 4: 특정 제품 삭제
-- 'Charger' 제품을 삭제하세요.
DELETE FROM products
	WHERE product_name = 'Charger';
select * from products;

-- 연습문제 5: 특정 날짜의 판매 기록 삽입
-- 'Headphones' 제품이 '2023-02-01'에 10개 판매된 기록을 삽입하세요.
INSERT INTO sales
	VALUES (6, 4, '2023-02-01', 10);
select * from sales;

-- 연습문제 6: 특정 판매 기록 업데이트
-- '2023-01-10'에 판매된 'Laptop'의 수량을 3으로 업데이트하세요.
UPDATE sales
	SET quantity = 3
    WHERE sale_id = 1;
select * from sales;	

-- 연습문제 7: 특정 판매 기록 삭제
-- '2023-01-25'에 판매된 기록을 삭제하세요.
DELETE FROM sales 
	WHERE sale_date = '2023-01-25';
select * from sales;

-- 연습문제 8: 특정 조건에 맞는 제품의 가격 업데이트
-- 'Electronics' 카테고리의 모든 제품 가격을 10% 인상하세요.
UPDATE products
	SET price = price * 1.1
    WHERE category = 'Electronics';
select * from products;

-- 연습문제 9: 특정 조건에 맞는 제품의 재고 업데이트
-- 가격이 500.00 이상인 모든 제품의 재고를 5 증가시키세요.
UPDATE products
	SET stock = stock + 5
    WHERE price >= 500.00;
select * from products;