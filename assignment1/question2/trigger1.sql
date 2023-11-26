CREATE OR REPLACE FUNCTION log_orders_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.BookTitle <> OLD.BookTitle OR NEW.DeliveryZip <> OLD.DeliveryZip THEN
		 INSERT INTO orders_audit(CustomerId,OrderId,BookTitle,OrderDate,DeliveryZip,changed_on)
		 VALUES(OLD.CustomerId,OLD.OrderId,OLD.BookTitle,OLD.OrderDate,OLD.DeliveryZip,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER orders_changes
  BEFORE UPDATE
  ON orders
  FOR EACH ROW
  EXECUTE PROCEDURE log_orders_changes();


CREATE OR REPLACE FUNCTION log_customers_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.CustomerName <> OLD.CustomerName THEN
		 INSERT INTO customers_audit(CustomerId, CustomerName,changed_on)
		 VALUES(OLD.CustomerId,OLD.CustomerName,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER customers_changes
  BEFORE UPDATE
  ON customers
  FOR EACH ROW
  EXECUTE PROCEDURE log_customers_changes();


CREATE OR REPLACE FUNCTION log_product_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.Price <> OLD.Price THEN
		 INSERT INTO product_audit(BookTitle, Price,changed_on)
		 VALUES(OLD.BookTitle,OLD.Price,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER product_changes
  BEFORE UPDATE
  ON product
  FOR EACH ROW
  EXECUTE PROCEDURE log_product_changes();

CREATE OR REPLACE FUNCTION log_addresses_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW IS DISTINCT FROM OLD THEN
		 INSERT INTO addresses_audit(DeliveryAddress, DeliveryCity, DeliveryZip,changed_on)
		 VALUES(OLD.DeliveryAddress,OLD.DeliveryCity, OLD.DeliveryZip,now());
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER addresses_changes
  BEFORE UPDATE
  ON addresses
  FOR EACH ROW
  EXECUTE PROCEDURE log_addresses_changes();