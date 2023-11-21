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
