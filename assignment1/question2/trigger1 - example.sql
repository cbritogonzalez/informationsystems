insert into orders values ('1', '1', 'hp1', 12345);
select * from orders;
select * from orders_audit;
-- This will update the audit logs
update orders set booktitle = 'hp3' where orderid='1';
update orders set deliveryzip = 123456 where orderid='1';

--This will not update the audit logs
update orders set customerid = '2' where orderid='1';

-- You can check the updates made and then inserted in the orders_audit table
select * from orders_audit;

-- The other triggers can be tested in a similar manner, for example:
select * from product;
select * from product_audit;
insert into product values('hp1', 20.5);
update product set price=21 where booktitle='hp1';