

--Insert yourself into the Employees table Include the following fields: LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo
select * from employees
insert into employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, city, region, postal_code, country, home_phone, reports_to)
values (10,'Mello', 'Ricardo', Engineer, 'Mr', '1980-05-28', '2014-12-05', 'City', 'State', 5784751, 'Brazil','5125687746','AC')


--Insert an order for yourself in the Orders table Include the following fields: CustomerID, EmployeeID, OrderDate, RequiredDate
insert into orders (order_id, customer_id, employee_id, order_date, required_date)
values (11078, 'VINET', 10, '2024-11-28', '2024-12-12')


--Insert order details in the Order_Details table Include the following fields: OrderID, ProductID, UnitPrice, Quantity, Discount
SELECT * FROM order_details
INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
VALUES (11078, 42, 9.8, 15, 0.10)


--Update the phone of yourself (from the previous entry in Employees table) 
UPDATE employees
SET home_phone = '555765545'
WHERE first_name = 'Ricardo'


--Double the quantity of the order details record you inserted before 
update order_details
set quantity = quantity*2
where order_id = 11078


--Repeat previous update but this time update all orders associated with you
update order_details 
set quantity = quantity*2
where order_id in 
(select orders.order_id from order_details
join orders ON order_details.order_id = orders.order_id
join employees on orders.employee_id = employees.employee_id
where employees.employee_id = 10
)


--Delete the records you inserted before. 
delete from employees
where employee_id = 10

delete from orders
where order_id = 11078

delete from order_details
where order_id = 11078

