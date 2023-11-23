-- Trigger for inserting and updating orders
CREATE OR REPLACE FUNCTION after_insert_or_update_order()
RETURNS TRIGGER AS $$
DECLARE
    total_sales DECIMAL(10, 2);
BEGIN
    -- Calculate total sales amount for the current month and year
    SELECT COALESCE(SUM(product.Price), 0)
    INTO total_sales
    FROM product
    WHERE product.BookTitle = NEW.BookTitle;

    -- Update MonthlySalesReport table
    UPDATE MonthlySalesReport
    SET TotalSales = COALESCE(TotalSales, 0) + total_sales
    WHERE Month = EXTRACT(MONTH FROM CURRENT_DATE) AND Year = EXTRACT(YEAR FROM CURRENT_DATE);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for both INSERT and UPDATE events
CREATE TRIGGER insert_or_update_order_trigger
AFTER INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION after_insert_or_update_order();
