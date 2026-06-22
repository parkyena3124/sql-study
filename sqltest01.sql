use my_shop;

select * from customers;
-- delete from customers
-- where customer_id=1;


insert into orders(customer_id, product_id, quantity)
value (1,1,10);
select * from orders;