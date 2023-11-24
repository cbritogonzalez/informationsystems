CREATE OR REPLACE FUNCTION log_orders_booktitle_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.BookTitle <> OLD.BookTitle THEN
		 INSERT INTO orders_audit(CustomerId,OrderId,BookTitle,DeliveryZip,changed_on)
		 VALUES(OLD.CustomerId,OLD.OrderId,OLD.BookTitle,OLD.DeliveryZip,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER booktitle_changes
  BEFORE UPDATE
  ON orders
  FOR EACH ROW
  EXECUTE PROCEDURE log_orders_booktitle_changes();