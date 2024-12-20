--– Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late. --Order by employee last_name, then by first_name, and then descending by number of orders.
select first_name, last_name, count(*) as num_orders, case 
when shipped_date <= required_date then 'On Time'
ELSE 'Late'
END as shipped
from employees
join orders on orders.employee_id = employees.employee_id
group by first_name, last_name, shipped
order by last_name, first_name, num_orders desc




--Create a view with total revenues per customer
create view total_Revenue AS
select customers.customer_id, company_name, round(sum(quantity*unit_price*(1-discount)),2) as revenue from order_details
join orders on order_details.order_id = orders.order_id
join customers on orders.customer_id = customers.customer_id
group by customers.customer_id


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

