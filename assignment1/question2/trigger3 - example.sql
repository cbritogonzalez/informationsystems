CREATE TABLE MonthlySalesReport (
    Month INT,
    Year INT,
    TotalSales DECIMAL(10, 2)
);

INSERT INTO product (BookTitle, Price)
VALUES
    ('Database Fundamentals', 45.00),
    ('Advanced SQL', 60.00),
    ('The Relational Model', 40.00);

--try this:
SELECT * FROM monthlysalesreport;

INSERT INTO orders (CustomerID, OrderID, BookTitle, OrderDate, DeliveryZip)
VALUES
    ('C001', '0004', 'Database Fundamentals','2023-04-10','12345'),
    ('C002', '0005', 'Advanced SQL','2023-04-11','67890');

SELECT * FROM monthlysalesreport;

INSERT INTO orders (CustomerID, OrderID, BookTitle, OrderDate, DeliveryZip)
VALUES ('C003', '0006', 'The Relational Model','2023-05-12','14345');

INSERT INTO orders (CustomerID, OrderID, BookTitle, OrderDate, DeliveryZip)
VALUES
  ('C004', '0007', 'Advanced SQL', '2023-04-13', '12346'),
  ('C005', '0008', 'The Relational Model', '2023-04-14', '118932');