/*
- 테이블 생성 연습문제

- 요구사항:
- products라는 이름의 새로운 테이블을 생성하십시오.

이 테이블은 다음과 같은 컬럼을 포함해야 합니다:
- product_id (INT, 기본키, NULL 불허용)
- product_name (VARCHAR(100), NULL 불허용)
- price (DECIMAL(10,2), NULL 불허용)
- stock_quantity (INT, NULL 불허용)
- supplier_id (INT, NULL 허용)
*/

USE test_db;

CREATE TABLE products (
	product_id INT PRIMARY KEY NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    supplier_id INT
);

DESC products;
SELECT * FROM products;

/*
테이블 생성 연습문제 2

- `course_registrations`라는 이름의 새로운 테이블을 생성하십시오.

- 이 테이블은 학생들의 과정 등록 정보를 저장하며, 다음과 같은 컬럼을 포함해야 합니다:
  - `student_id` (INT, NULL 불허용)
  - `course_id` (INT, NULL 불허용)
  - `registration_date` (DATE, NULL 불허용)
  - 학생과 과정의 조합은 유일해야 합니다. 즉, 같은 학생이 같은 과정에 두 번 등록될 수 없습니다.
  - `student_id`와 `course_id`의 조합으로 복합 기본키를 사용합니다.
*/

CREATE TABLE course_registrations (
	student_id INT NOT NULL,
    course_id INT NOT NULL,
    registration_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

DESC course_registrations;

/*
테이블 생성 연습문제 3

- `customer_accounts`라는 이름의 새로운 테이블을 생성하십시오.

- 이 테이블은 고객 계정 정보를 저장하며, 다음과 같은 컬럼을 포함해야 합니다:
  - `account_id` (INT, 기본키, NULL 불허용)
  - `customer_name` (VARCHAR(100), NULL 불허용)
  - `email` (VARCHAR(100), NULL 불허용, 유니크 제약조건)
  - `phone_number` (VARCHAR(15), 유니크 제약조건, NULL 허용)

*/

CREATE TABLE customer_accounts (
	account_id INT PRIMARY KEY NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) UNIQUE
);

DESC customer_accounts;