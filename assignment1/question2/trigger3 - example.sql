CREATE TABLE MonthlySalesReport (
    Month INT,
    Year INT,
    TotalSales DECIMAL(10, 2)
);

INSERT INTO MonthlySalesReport (Month, Year, TotalSales)
VALUES (EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE), 0.00);

INSERT INTO product (BookTitle, Price)
VALUES
    ('Database Fundamentals', 45.00),
    ('Advanced SQL', 60.00),
    ('The Relational Model', 40.00);

--try this:
SELECT * FROM monthlysalesreport;

INSERT INTO orders (CustomerID, OrderID, BookTitle, DeliveryZip)
VALUES
    ('C001', '0004', 'Database Fundamentals', '12345'),
    ('C002', '0005', 'Advanced SQL', '67890');

SELECT * FROM monthlysalesreport;

INSERT INTO orders (CustomerID, OrderID, BookTitle, DeliveryZip)
VALUES ('C003', '0006', 'The Relational Model', '12345');