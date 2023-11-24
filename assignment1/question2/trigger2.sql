CREATE OR REPLACE FUNCTION prevent_deletion()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF EXISTS(SELECT CustomerId from orders where CustomerId = OLD.CustomerId) THEN
		RAISE EXCEPTION 'Customer still has associated orders';
	END IF;
	RETURN OLD;
END;
$$

CREATE TRIGGER prevent_deletion_customer_id
  BEFORE DELETE
  ON customers
  FOR EACH ROW
  EXECUTE PROCEDURE prevent_deletion();