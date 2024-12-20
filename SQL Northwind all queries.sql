-- Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
SELECT contact_name, address, city FROM Customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain')


-- Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
select employee_id, order_id, customer_id, required_date, shipped_date from orders
WHERE shipped_date > required_date


--–Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
SELECT CITY, company_name, contact_name FROM customers
WHERE CITY LIKE '%l%'
order by contact_name


--–Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
select company_name, contact_name, fax from customers
where FAX is not null


--–Show the first_name, last_name. hire_date of the most recently hired employee.
select first_name, last_name, hire_date from employees
order by hire_date desc
limit 1


--–Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.
select round(AVG(unit_price),2) , sum(units_in_stock), sum(discontinued) from products


--Show the category_name and the average product unit price for each category rounded to 2 decimal places.
select category_name, round(avg(unit_price),2) from products
join categories on products.category_id = categories.category_id
group by category_name


--–Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
select City, company_name, contact_name, 'customers' as relationship 
from customers
union
select city, company_name, contact_name, 'suppliers'
from suppliers


--– Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late. --Order by employee last_name, then by first_name, and then descending by number of orders.
select first_name, last_name, count(*) as num_orders, case 
when shipped_date <= required_date then 'On Time'
ELSE 'Late'
END as shipped
from employees
join orders on orders.employee_id = employees.employee_id
group by first_name, last_name, shipped
order by last_name, first_name, num_orders desc


--–Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places
SELECT strftime('%Y', orders.order_date) as year , round(sum(quantity*unit_price*discount),2) from order_details
JOIN orders ON order_details.order_id = orders.order_id
group by year
order by year desc


--Get the count of all Orders made during 1997
select STRFTIME('%Y', order_date) as year, count(*) from orders
group by year
having year = '1996'


--Get the names of all the contact persons where the person is a manager, alphabetically
select contact_name, contact_title from customers
where contact_title like '%Manager%'
order by contact_name


--Get all orders placed on the 19th of May, 1997
select * from orders
where order_date = '1997-05-19'


--Create a report for all the orders of 1996 and their Customers 
select order_id, orders.customer_id, company_name  from orders
join customers on orders.customer_id = customers.customer_id
where strftime ('%Y', order_date) = '1996'


--Create a report that shows the number of employees and customers from each city that has employees in it 
select employees.city, count(employees.city), count(customers.city) from employees
LEFT join customers on
employees.city = customers.city
group by employees.city


--Create a report that shows the number of employees and customers from each city that has customers in it 
select customers.city, count(employees.city), count(customers.city) from customers
LEFT join employees on
employees.city = customers.city
group by customers.city


--Create a report that shows the number of employees and customers from each city 
select employees.city, count(employees.city), count(customers.city) from employees
LEFT join customers on
employees.city = customers.city
group by employees.city
union
select customers.city, count(employees.city), count(customers.city) from customers
LEFT join employees on
employees.city = customers.city
group by customers.city


--Create a report that shows the order ids and the associated employee names for orders that shipped after the required date 
select order_id, first_name, last_name from orders
join employees on orders.employee_id = employees.employee_id
where shipped_date > required_date


--Only show records for products for which the quantity ordered is fewer than 200 
select * from order_details
where quantity < 200


--Create a report that shows the total number of orders by Customer since December 31,1996. The report should only return rows for which the total number of orders is greater than 15 
select customer_id, count(order_id) as number_of_orders from orders
where order_date >'1996-12-31'
group by customer_id
having number_of_orders > 15


--What were our total revenues in 1997? 
select round(sum(unit_price*quantity*(1-discount)),2) from order_details
join orders on order_details.order_id = orders.order_id
where strftime ('%Y', order_date) = '1997'


--What is the total amount each customer has payed us so far? 
select customers.customer_id, company_name, round(sum(quantity*unit_price*(1-discount)),2) from order_details
join orders on order_details.order_id = orders.order_id
join customers on orders.customer_id = customers.customer_id
group by customers.customer_id


--Find the 10 top selling products (Hint: Top selling product is "Côte de Blaye")
select product_name, round(sum(order_details.quantity*order_details.unit_price*(1-discount)),2) as revenue from order_details
join products on order_details.product_id = products.product_id
group by product_name
order by revenue desc
limit 10


--Create a view with total revenues per customer
create view total_Revenue AS
select customers.customer_id, company_name, round(sum(quantity*unit_price*(1-discount)),2) as revenue from order_details
join orders on order_details.order_id = orders.order_id
join customers on orders.customer_id = customers.customer_id
group by customers.customer_id


--Which UK Customers have payed us more than 1000 dollars 
select customers.customer_id, company_name, round(sum(quantity*unit_price*(1-discount)),2) as revenue, customers.country from order_details
join orders on order_details.order_id = orders.order_id
join customers on orders.customer_id = customers.customer_id 
group by customers.customer_id
having country = 'UK' and revenue > 1000


--How much has each customer payed in total and how much in 1997. We want one result set with the following columns:
--CustomerID
--CompanyName
--Country
--Customer's total from all orders
--Customer's total from 1997 orders You can try this with views, subqueries or temporary tables. 
--Try using [Order Subtotals] view that already exists in database.

-- Using temporary table 
create temp table revenue_1997 as 
select company_name, round(sum(quantity*unit_price*(1-discount)),2) as 'rev_1997' from orders 
join customers on orders.customer_id = customers.customer_id
join order_details on orders.order_id = order_details.order_id
where strftime ('%Y', order_date) = '1997'
group by company_name


select customers.company_name, round(sum(quantity*unit_price*(1-discount)),2) as total, rev_1997 as '1997' from orders 
full join customers on orders.customer_id = customers.customer_id
full join order_details on orders.order_id = order_details.order_id
full join  revenue_1997 
on customers.company_name = revenue_1997.company_name
group by customers.company_name


--Using views
CREATE VIEW revenue1997 as 
select company_name, sum(quantity) as revenue1997 from orders 
join customers on orders.customer_id = customers.customer_id
join order_details on orders.order_id = order_details.order_id
where strftime ('%Y', order_date) = '1997'
group by company_name

select customers.company_name, sum(quantity) as total, revenue1997 as rev_1997 from orders 
full join customers on orders.customer_id = customers.customer_id
full join order_details on orders.order_id = order_details.order_id
full join  (select * from revenue1997) as B
on customers.company_name = B.company_name
group by customers.company_name


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


--Select all category names with their descriptions from the Categories table.
select category_name, description from categories


--Marketing managers and sales representatives have asked you to select all available columns in the Suppliers tables that have a FAX number.
select * from suppliers
where fax is not NULL


--Select a list of customers id’s from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.
select customer_id, required_date, freight from orders
where required_date between '1997-01-01' and '1998-01-01' and freight < 100


--Count the number of discontinued products in the Products table.
select count(*) from products
where discontinued = 1


--Select the product id and the total quantities ordered for each product id in the Order Details table.
select product_id, sum(quantity) from order_details
group by product_id


--Select the customer name and customer address of all customers with orders that shipped using Speedy Express.
select DISTINCT customers.company_name, address, shippers.company_name from orders 
join shippers on orders.ship_via = shippers.shipper_id
join customers on orders.customer_id = customers.customer_id
where shippers.company_name = 'Speedy Express'


--Select a list of customer names who have no orders in the Orders table.
select company_name, order_id from orders 
right join customers on orders.customer_id = customers.customer_id
where order_date is NULL


--Select a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
select company_name, sum(freight)from orders
left join shippers on orders.ship_via = shippers.shipper_id
group by company_name


--Select the name, address, city, and region of employees living in USA.
select first_name, last_name, city, region from employees
where country ='USA'


--Select the name, address, city, and region of employees older than 63 years old.
select first_name, last_name, city, region, DATE('now') - birth_date  as age from employees
where DATE('now')-birth_date >63


--Select the name, address, city, and region of employees that have placed orders to be delivered in Belgium. Write two versions of the query, with and without join.
--using Joins
select  first_name, last_name, city, region, ship_country from orders
join employees on orders.employee_id = employees.employee_id
WHERE ship_country = 'Belgium'
group by first_name, last_name

--using subqueries
select  first_name, last_name, city, region from employees
where employee_id IN (
  SELECT employee_id from orders 
  where ship_country = 'Belgium'
  )


--Select the employee name and the customer name for orders that are sent by the company ‘Speedy Express’ to customers who live in Bruxelles.
select first_name, last_name, customers.company_name, shippers.company_name, customers.city from orders
join employees on orders.employee_id = employees.employee_id
join customers on orders.customer_id = customers.customer_id
join shippers on orders.ship_via = shippers.shipper_id
where shippers.company_name = 'Speedy Express' and customers.city = 'Bruxelles'


--Select the title and name of employees who have sold at least one of the products ‘Gravad Lax’ or ‘Mishi Kobe Niku’.
select employees.title, first_name, last_name, products.product_name from employees
join orders on employees.employee_id = orders.employee_id
join order_details on orders.order_id = order_details.order_id
join products on order_details.product_id = products.product_id
where product_name IN ('Gravad Lax', 'Mishi Kobe Niku')


--Select the name and title of employees and the name and title of the person to which they refer (or null for the latter values if they don’t refer to another employee).
select A.first_name, A.last_name, a.title, B.first_name, B.last_name, B.title from employees as A
left JOIN employees as B
on A.reports_to = B.employee_id


--Select the customer name, the product name and the supplier name for customers who live in London and suppliers whose name is ‘Pavlova, Ltd.’ or ‘Karkki Oy’.
select customers.company_name as customer , product_name, suppliers.company_name as suppliers from orders
join order_details on orders.order_id = order_details.order_id
join customers on orders.customer_id = customers.customer_id
join products on order_details.product_id = products.product_id
join suppliers on products.supplier_id = suppliers.supplier_id
where customers.city = 'London' and (suppliers.company_name = 'Pavlova, Ltd.' OR suppliers.company_name = 'Karkki Oy')


--Select the name of products that were bought or sold by people who live in London. Write two versions of the query, with and without union.
select products.product_name, employees.city as emp_city, customers.city as cust_city from orders
join order_details on orders.order_id = order_details.order_id
join customers on orders.customer_id = customers.customer_id
join products on order_details.product_id = products.product_id
join employees on orders.employee_id = employees.employee_id
where employees.city ='London' or customers.city = 'London'


--Select the names of employees who are strictly older than: (a) average age of employee who lives in London. (b) oldest employee who lives in London.
select * from employees
where DATE('now') - birth_date > (
  select avg(DATE('now') - birth_date) from employees
  where city = 'London'
)


select * from employees
where DATE('now') - birth_date > (
  select MAX(DATE('now') - birth_date) from employees
  where city = 'London'
)


--Select the name of employees and the city where they live for employees who have sold to customers in the same city.
select first_name, last_name, employees.city, customers.city from orders
join customers on orders.customer_id = customers.customer_id
join employees on orders.employee_id = employees.employee_id
where employees.city = customers.city


--Select the average price of products by category.
select categories.category_name, round(avg(unit_price),2) from categories
join products on products.category_id = categories.category_id
group by category_name


--Select the identifier and the name of the companies that provide more than 3 products.
select suppliers.supplier_id, suppliers.company_name, count (DISTINCT products.product_id) as prod_qty from products
join suppliers on products.supplier_id = suppliers.supplier_id
group by company_name
having prod_qty > 3 


--For each employee give the identifier, name, and the number of distinct products sold, ordered by the employee identifier.
select employees.employee_id, first_name, last_name, count(DISTINCT product_id) from orders
join employees on orders.employee_id = employees.employee_id
join order_details on orders.order_id = order_details.order_id

group by employees.employee_id
order by employees.employee_id


--Select the identifier, name, and total sales of employees, ordered by the employee identifier for employees who have sold more than 70 different products.
select employees.employee_id, first_name, last_name, count (DISTINCT products.product_id) as differente_products from orders
join order_details on orders.order_id = order_details.order_id
join products on order_details.product_id = products.product_id
join employees on employees.employee_id = orders.employee_id
group by employees.employee_id
HAVING differente_products > 70


--Select the names of employees who sell the products of more than 7 suppliers.
select employee_id, count( DISTINCT supplier_id) from orders
join order_details on orders.order_id = order_details.order_id
join products on order_details.product_id = products.product_id
group by employee_id
