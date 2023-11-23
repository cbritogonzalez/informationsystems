CREATE TABLE orders (
	CustomerId varchar,
	OrderId varchar,
	BookTitle varchar,
	DeliveryZip int
);

CREATE TABLE customers (
	CustomerId varchar,
	CustomerName varchar
);

CREATE TABLE orderInformation (
	OrderId varchar,
	OrderDate date
);

CREATE TABLE product (
	BookTitle varchar,
	Price real
);

CREATE TABLE addresses (
	DeliveryAddress varchar,
	DeliveryCity varchar,
	DeliveryZip int
);

CREATE TABLE Bookstore (
    CustomerID VARCHAR(5),
    CustomerName VARCHAR(50),
    OrderID VARCHAR(5),
    BookTitle VARCHAR(100),
    Price DECIMAL(10, 2),
    OrderDate DATE,
    DeliveryAddress VARCHAR(100),
    DeliveryCity VARCHAR(50),
    DeliveryZip VARCHAR(10)
);

INSERT INTO Bookstore (CustomerID, CustomerName, OrderID, BookTitle, Price, OrderDate, DeliveryAddress, DeliveryCity, DeliveryZip)
VALUES
    ('C001', 'John Doe', '0001', 'Database Fundamentals', 45.00, '2023-04-10', '123 Elm St', 'Springfield', '12345'),
    ('C001', 'John Doe', '0001', 'Advanced SQL', 60.00, '2023-04-10', '123 Elm St', 'Springfield', '12345'),
    ('C002', 'Jane Smith', '0002', 'Advanced SQL', 60.00, '2023-04-11', '456 Oak Ave', 'Springfield', '12345'),
    ('C002', 'Jane Smith', '0002', 'The Relational Model', 40.00, '2023-04-11', '456 Oak Ave', 'Springfield', '12345'),
    ('C003', 'Emily Clark', '0003', 'Database Fundamentals', 45.00, '2023-04-12', '789 Pine Rd', 'Riverside', '67890');

--for 3rd Trigger
CREATE TABLE MonthlySalesReport (
    Month INT,
    Year INT,
    TotalSales DECIMAL(10, 2)
);



