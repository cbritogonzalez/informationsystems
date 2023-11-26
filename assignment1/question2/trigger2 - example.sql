-- The deletion from 1 will fail due to the trigger
insert into customers values('1', 'hachi');
insert into customers values('2', 'carlos');
insert into orders values ('1', '1', 'hp1', now(), 12345);
delete from customers where customerid='1';
-- This deletion will work since there is no related customerid in the orders table
delete from customers where customerid='2';