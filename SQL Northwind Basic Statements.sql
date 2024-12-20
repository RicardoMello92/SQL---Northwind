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


--Get the names of all the contact persons where the person is a manager, alphabetically
select contact_name, contact_title from customers
where contact_title like '%Manager%'
order by contact_name


--Get all orders placed on the 19th of May, 1997
select * from orders
where order_date = '1997-05-19'


--Only show records for products for which the quantity ordered is fewer than 200 
select * from order_details
where quantity < 200


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


--Select the name, address, city, and region of employees living in USA.
select first_name, last_name, city, region from employees
where country ='USA'


--Select the name, address, city, and region of employees older than 63 years old.
select first_name, last_name, city, region, DATE('now') - birth_date  as age from employees
where DATE('now')-birth_date >63


