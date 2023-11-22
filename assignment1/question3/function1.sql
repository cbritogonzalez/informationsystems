CREATE OR REPLACE FUNCTION calculate_total_order_value(p_customer_id VARCHAR)
RETURNS DECIMAL AS
$$
DECLARE
    total_value DECIMAL := 0;
BEGIN
    SELECT SUM(Price) INTO total_value
    FROM bookstore
    WHERE CustomerID = p_customer_id;

    RETURN total_value;
END;
$$
LANGUAGE plpgsql;
