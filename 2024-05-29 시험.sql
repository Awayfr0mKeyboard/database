create schema testing;
use testing;


CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20)
);
desc customer;

CREATE TABLE Product (
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price INT NOT NULL CHECK(0 < Price)
);
desc product;

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);
desc orders;

CREATE TABLE OrderDetail (
	OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
desc orderdetail;

-- Customer 테이블에 Address라는 문자열(길이 255)의 열을 추가합니다.
ALTER TABLE Customer
	ADD COLUMN Address VARCHAR(255);
desc customer;

-- Customer 테이블에 Phone 열을 삭제합니다.
ALTER TABLE Customer
	DROP COLUMN Phone;
desc customer;

-- ProductName 열의 이름을 Name으로 변경합니다.
ALTER TABLE Product
	CHANGE COLUMN ProductName Name VARCHAR(100); 
desc product;