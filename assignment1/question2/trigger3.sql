CREATE OR REPLACE FUNCTION after_insert_order()
RETURNS TRIGGER AS $$
DECLARE
    total_sales DECIMAL(10, 2);
BEGIN
    -- Calculate total sales amount for the current month and year
    SELECT COALESCE(SUM(product.Price), 0)
    INTO total_sales
    FROM product
    WHERE product.BookTitle = NEW.BookTitle;

    -- Check if a row for the current month and year exists
    PERFORM 1
    FROM MonthlySalesReport
    WHERE Month = EXTRACT(MONTH FROM NEW.orderdate)
      AND Year = EXTRACT(YEAR FROM NEW.orderdate);

    -- If the row doesn't exist, insert a new row
    IF NOT FOUND THEN
        INSERT INTO MonthlySalesReport (Month, Year, TotalSales)
        VALUES (EXTRACT(MONTH FROM NEW.orderdate), EXTRACT(YEAR FROM NEW.orderdate), total_sales);
    ELSE
        -- Update MonthlySalesReport table
        UPDATE MonthlySalesReport
        SET TotalSales = COALESCE(TotalSales, 0) + total_sales
        WHERE Month = EXTRACT(MONTH FROM NEW.orderdate) AND Year = EXTRACT(YEAR FROM NEW.orderdate);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for both INSERT events
CREATE TRIGGER insert_order_trigger
AFTER INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION after_insert_order();

