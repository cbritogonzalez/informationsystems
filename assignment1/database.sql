CREATE TABLE orders (
	CustomerId varchar,
	OrderId varchar,
	BookTitle varchar,
	DeliveryZip int
);

CREATE TABLE orders_audit (
	CustomerId varchar,
	OrderId varchar,
	BookTitle varchar,
	DeliveryZip int,
	changed_on timestamp
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

---Procedures
CREATE TABLE customer_orders (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    order_details JSONB NOT NULL
);

-- Inserting data into the table
INSERT INTO customer_orders (customer_id, customer_name, order_details)
VALUES
    ('C001', 'John Doe', '{"order_id": "0001", "book_titles": ["Database Fundamentals", "Advanced SQL"], "prices": [45.00, 60.00], "order_date": "2023-04-10", "delivery_address": "123 Elm St", "delivery_city": "Springfield", "delivery_zip": "12345"}'),
    ('C002', 'Jane Smith', '{"order_id": "0002", "book_titles": ["Advanced SQL", "The Relational Model"], "prices": [60.00, 40.00], "order_date": "2023-04-11", "delivery_address": "456 Oak Ave", "delivery_city": "Springfield", "delivery_zip": "12345"}'),
    ('C003', 'Emily Clark', '{"order_id": "0003", "book_titles": ["Database Fundamentals"], "prices": [45.00], "order_date": "2023-04-12", "delivery_address": "789 Pine Rd", "delivery_city": "Riverside", "delivery_zip": "67890"}');



