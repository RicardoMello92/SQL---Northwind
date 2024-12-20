# Northwind Database

The Northwind database is a sample database used by Microsoft to demonstrate the
features of some of its products, including SQL Server and Microsoft Access. The database
contains the sales data for Northwind Traders, a fictitious specialty foods export­import
company.

# Main SQL Commands used in the analysis: 

SELECT, WHERE, LIKE, GROUP BY, JOINS, UNION, VIEWS, TEMPORARY TABLES, CASE, ORDER BY, SUBQUERIES, INSERT, UPDATE, DELETE

# Questions

## - [Basic Statements (Select, Where, Order by, Limit, Agg Functions)](https://github.com/RicardoMello92/SQL---Northwind/blob/main/SQL%20Northwind%20Basic%20Statements.sql) :
Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'

Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date

Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name

Show the company_name, contact_name, fax number of all customers that has a fax number. 

Show the first_name, last_name. hire_date of the most recently hired employee.

Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.

Get the names of all the contact persons where the person is a manager, alphabetically

Get all orders placed on the 19th of May, 1997

Only show records for products for which the quantity ordered is fewer than 200 

Select all category names with their descriptions from the Categories table.

Marketing managers and sales representatives have asked you to select all available columns in the Suppliers tables that have a FAX number.

Select a list of customers id’s from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.

Count the number of discontinued products in the Products table.

Select the name, address, city, and region of employees living in USA.

Select the name, address, city, and region of employees older than 63 years old.


## - [Group by / Join / Union Statements](https://github.com/RicardoMello92/SQL---Northwind/blob/main/SQL%20Northwind%20Group%20by%20_%20Join%20_%20Union%20Statements.sql) :


Show the category_name and the average product unit price for each category rounded to 2 decimal places.

Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which contains 'customers' or 'suppliers' depending on the table it came from.

Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places

Get the count of all Orders made during 1997

Create a report for all the orders of 1996 and their Customers 

Create a report that shows the number of employees and customers from each city that has employees in it 

Create a report that shows the number of employees and customers from each city that has customers in it 

Create a report that shows the number of employees and customers from each city 

Create a report that shows the order ids and the associated employee names for orders that shipped after the required date 

Create a report that shows the total number of orders by Customer since December 31,1996. The report should only return rows for which the total number of orders is greater than 15 

What were our total revenues in 1997? 

What is the total amount each customer has payed us so far? 

Find the 10 top selling products 

Which UK Customers have payed us more than 1000 dollars 

Select the product id and the total quantities ordered for each product id in the Order Details table.

Select the customer name and customer address of all customers with orders that shipped using Speedy Express.

Select a list of customer names who have no orders in the Orders table.

Select a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.

Select the employee name and the customer name for orders that are sent by the company ‘Speedy Express’ to customers who live in Bruxelles.

Select the title and name of employees who have sold at least one of the products ‘Gravad Lax’ or ‘Mishi Kobe Niku’.

Select the name and title of employees and the name and title of the person to which they refer (or null for the latter values if they don’t refer to another employee).

Select the customer name, the product name and the supplier name for customers who live in London and suppliers whose name is ‘Pavlova, Ltd.’ or ‘Karkki Oy’.

Select the name of products that were bought or sold by people who live in London. 

Select the name of employees and the city where they live for employees who have sold to customers in the same city.

Select the average price of products by category.

Select the identifier and the name of the companies that provide more than 3 products.

For each employee give the identifier, name, and the number of distinct products sold, ordered by the employee identifier.

Select the identifier, name, and total sales of employees, ordered by the employee identifier for employees who have sold more than 70 different products.

Select the names of employees who sell the products of more than 7 suppliers.

## - [Insert, update, Delete Statements](https://github.com/RicardoMello92/SQL---Northwind/blob/main/SQL%20Northwind%20Insert%20_%20Update%20_%20Delete%20(1).sql) :

Insert yourself into the Employees table Include the following fields: LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo

Insert an order for yourself in the Orders table Include the following fields: CustomerID, EmployeeID, OrderDate, RequiredDate

Insert order details in the Order_Details table Include the following fields: OrderID, ProductID, UnitPrice, Quantity, Discount

Update the phone of yourself (from the previous entry in Employees table) 

Double the quantity of the order details record you inserted before 

Repeat previous update but this time update all orders associated with you

Delete the records you inserted before.

## - [SubQueries / Views / Temporary Tables / Case Statements](https://github.com/RicardoMello92/SQL---Northwind/blob/main/SQL%20Northwind%20SubQueries%20_%20Views%20_%20Temporary%20Tables%20_%20Case%20Statements%20.sql) :
 
Select the name, address, city, and region of employees that have placed orders to be delivered in Belgium. 

Select the names of employees who are strictly older than: (a) average age of employee who lives in London. (b) oldest employee who lives in London.

Create a view with total revenues per customer

Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late. Order by employee last_name, then by first_name, and then descending by number of orders.

How much has each customer payed in total and how much in 1997. We want one result set with the following columns:
CustomerID
CompanyName
Country
Customer's total from all orders
Customer's total from 1997 orders You can try this with views, subqueries or temporary tables. 

