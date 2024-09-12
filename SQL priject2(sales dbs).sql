create database sale;
use sale;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (customer_name, email, phone_number) VALUES
('John Doe', 'john@example.com', '123-456-7890'),
('Jane Smith', 'jane@example.com', '234-567-8901'),
('Alice Johnson', 'alice@example.com', '345-678-9012'),
('Bob Brown', 'bob@example.com', '456-789-0123'),
('Charlie Davis', 'charlie@example.com', '567-890-1234'),
('Diana Evans', 'diana@example.com', '678-901-2345'),
('Frank Green', 'frank@example.com', '789-012-3456'),
('Grace Hill', 'grace@example.com', '890-123-4567'),
('Hank Irwin', 'hank@example.com', '901-234-5678'),
('Ivy Jones', 'ivy@example.com', '012-345-6789');

INSERT INTO orders (order_date, customer_id, total_amount) VALUES
('2024-09-01', 1, 150.75),
('2024-09-02', 2, 230.50),
('2024-09-03', 3, 345.00),
('2024-09-04', 4, 120.25),
('2024-09-05', 5, 215.60),
('2024-09-06', 6, 400.20),
('2024-09-07', 7, 180.00),
('2024-09-08', 8, 245.80),
('2024-09-09', 9, 135.30),
('2024-09-10', 10, 190.75);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop', 1, 150.75),
(2, 'Smartphone', 2, 115.25),
(3, 'Tablet', 3, 115.00),
(4, 'Headphones', 2, 60.12),
(5, 'Monitor', 1, 215.60),
(6, 'Keyboard', 4, 100.05),
(7, 'Mouse', 5, 36.00),
(8, 'Printer', 1, 245.80),
(9, 'Webcam', 3, 45.10),
(10, 'External Hard Drive', 2, 95.37);

select * from customers;
select * from orders;
select * from order_items;

# DML OPERATIONS
#How would you retrieve the total amount of all orders placed by the customer named "John Doe"?
SELECT SUM(total_amount) AS total_spent
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.customer_name = 'John Doe';

#  add a new customer named "Olivia Wilson" with an email "olivia@example.com" and phone number "321-654-9870".
INSERT INTO customers (customer_name, email, phone_number)
VALUES ('Olivia Wilson', 'olivia@example.com', '321-654-9870');

# modify the orders table to add a new column order_status that can hold values like 'Pending', 'Shipped', or 'Delivered'
ALTER TABLE orders
ADD COLUMN order_status VARCHAR(20);

#Retrieve all customers who have placed orders totaling more than $200 using a subquery.
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 200
);

#DML OPERATIONS
#********************
#1 Insert a new customer named "Samuel Reed" with email "samuel@example.com" and phone number "321-123-4567". 
INSERT INTO customers (customer_name, email, phone_number)
VALUES ('Samuel Reed', 'samuel@example.com', '321-123-4567');

#2 Update the email of the customer "Alice Johnson" to "alice.johnson@example.com".
set sql_safe_updates=0;
UPDATE customers
SET email = 'alice.johnson@example.com'
WHERE customer_name = 'Alice Johnson';

#3. Add a new order for customer with customer_id = 5 with the total amount of $250.50.
INSERT INTO orders (order_date, customer_id, total_amount)
VALUES ('2024-09-11', 5, 250.50);

#4 Increase the total amount of all orders placed by "Grace Hill" by 10%.
UPDATE orders
SET total_amount = total_amount * 1.10
WHERE customer_id in (SELECT customer_id FROM customers WHERE customer_name = 'Grace Hill');

#5.Add a product named "Gaming Console" with a price of $299.99 to the order with order_id = 4
INSERT INTO order_items (order_id, product_name, quantity, price)
VALUES (4, 'Gaming Console', 1, 299.99);

#6.Change the quantity of "Tablet" in order_id = 3 to 5
UPDATE order_items
SET quantity = 5
WHERE order_id = 3 AND product_name = 'Tablet';

#7.Remove the product "Webcam" from order_id = 9
DELETE FROM order_items
WHERE order_id = 9 AND product_name = 'Webcam';

#8.Insert multiple products into order_id = 7 for "Speakers" and "Microphone".
INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(7, 'Speakers', 2, 75.00),
(7, 'Microphone', 1, 50.00);

#9.Decrease the price of "Mouse" in all orders by 5%
UPDATE order_items
SET price = price * 0.95
WHERE product_name = 'Mouse';

#10. retrieve the total amount of all orders placed by the customer named "John Doe"?
SELECT SUM(total_amount) AS total_spent
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.customer_name = 'John Doe';

#DDL OPERATIONS
#********************
#1 Create a new table products with columns product_id, product_name, and price. 
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

#2. Add a column address to the customers table
ALTER TABLE customers
ADD COLUMN address VARCHAR(255);

#3.Drop the phone_number column from the customers table.
ALTER TABLE customers
DROP COLUMN phone_number;

#4. Rename the orders table to customer_orders
ALTER TABLE orders
RENAME TO customer_orders;

#5. Delete the order_items table from the database
DROP TABLE order_items;

#6.Add a unique constraint to the email column in the customers table.
ALTER TABLE customers
ADD CONSTRAINT unique_email UNIQUE (email);

#7. Change the data type of total_amount in the orders table to FLOAT
ALTER TABLE orders
MODIFY COLUMN total_amount FLOAT;

#CLAUSES OPERATIONS
#********************
#1. Retrieve all orders where the total amount is greater than $200. 
SELECT * FROM orders
WHERE total_amount > 200;

#2.Find all products ordered in quantities of more than 2 using the HAVING clause.
SELECT product_name, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_name
HAVING total_quantity > 2;

#3.List all customers who have placed at least one order using the EXISTS clause.alter
SELECT customer_name
FROM customers
WHERE EXISTS (
    SELECT 1 FROM orders WHERE orders.customer_id = customers.customer_id
);

#4.Retrieve the top 5 orders by total amount using the LIMIT clause
SELECT * FROM orders
ORDER BY total_amount DESC
LIMIT 5;

#5.Select all distinct product names ordered from the order_items table.
SELECT DISTINCT product_name
FROM order_items;

#6. Retrieve customer names and their total spending using the GROUP BY clause.
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#7.List all orders placed after September 5, 2024
SELECT * FROM orders
WHERE order_date > '2024-09-05';

#8.Retrieve orders with a total_amount between $100 and $300 using the BETWEEN clause. 
SELECT * FROM orders
WHERE total_amount BETWEEN 100 AND 300;

#9.Find all customers whose names start with the letter 'J'.
SELECT * FROM customers
WHERE customer_name LIKE 'J%';

#10.Retrieve orders that include the product "Monitor" using the IN clause
SELECT * FROM orders
WHERE order_id IN (
    SELECT order_id FROM order_items WHERE product_name = 'Monitor'
);

# JOIN OPERATIONS
#********************
#1.List all orders along with the corresponding customer names
SELECT o.order_id, o.order_date, c.customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

#2. Retrieve all products ordered along with their order dates
SELECT oi.product_name, o.order_date
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id;

#3.Find customers who have not placed any orders using a LEFT JOIN. 
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

#4.Show the total amount for each order and the customer's name using an INNER JOIN.
SELECT o.order_id, o.total_amount, c.customer_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

#5. Use a RIGHT JOIN to retrieve all order items, including any orders that might not have associated order items
SELECT o.order_id, oi.product_name
FROM orders o
RIGHT JOIN order_items oi ON o.order_id = oi.order_id;

#6. Retrieve all orders along with their corresponding customers and the products ordered using a JOIN on three tables.
SELECT o.order_id, c.customer_name, oi.product_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;

#7. Find all customers and their total order count using a GROUP BY with a JOIN. 
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#8. Show all products ordered by "Michael Brown" using a JOIN. 
SELECT oi.product_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_name = 'Michael Brown';

#9. Retrieve all customer names and the total amount they have spent using a JOIN and GROUP BY
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

#10. Find the total quantity of each product ordered using a JOIN on order_items and orders
SELECT oi.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY oi.product_name;

# SUBQUERIES OPERATIONS
#1.Find the customer with the highest total spending
SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
);

#2. List orders that include the product "Headphones"
SELECT *
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM order_items
    WHERE product_name = 'Headphones'
);

#3.Retrieve customers who have spent more than the average order total.
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM orders)
);

#4. List customers who have ordered the product "Smartphone".
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_name = 'Smartphone'
);

#5.Find the order that has the most number of products. 
SELECT order_id
FROM order_items
GROUP BY order_id
ORDER BY COUNT(*) DESC
LIMIT 1;

#6. Retrieve orders where the total amount is greater than any single order placed by "Emily Davis". 
SELECT *
FROM orders
WHERE total_amount > ANY (
    SELECT total_amount
    FROM orders
    WHERE customer_id = (SELECT customer_id FROM customers WHERE customer_name = 'Emily Davis')
);

#7. Find all products that have been ordered at least once but not in the order with order_id = 5
SELECT product_name
FROM order_items
WHERE order_id <> 5
AND product_name NOT IN (
    SELECT product_name
    FROM order_items
    WHERE order_id = 5
);

#8 List customers who have placed more orders than the average number of orders per customer.
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > (SELECT AVG(order_count) FROM (SELECT COUNT(order_id) AS order_count FROM orders GROUP BY customer_id) AS avg_orders)
);

#9.Retrieve the order with the maximum total amount using a subquery
SELECT *
FROM orders
WHERE total_amount = (SELECT MAX(total_amount) FROM orders);

# MULTIROW FUNCTIONS
#*********************
#1.Retrieve the names of customers along with the total number of orders each has placed, only for those customers who have placed more than one order.
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING order_count > 1;

#2.Find all orders along with their total quantities for each product ordered, grouped by order ID.
SELECT oi.order_id, oi.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
GROUP BY oi.order_id, oi.product_name;

#3. List the total spending of each customer, only showing those who have spent more than $300 in total.
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING total_spent > 300;

#4.Retrieve the details of all orders that include at least two different products, sorted by the number of distinct products ordered.
SELECT oi.order_id, COUNT(DISTINCT oi.product_name) AS distinct_products
FROM order_items oi
GROUP BY oi.order_id
HAVING distinct_products >= 2
ORDER BY distinct_products DESC;

#5.List all products that have been ordered more than once across all orders, including the total quantity ordered for each product.
SELECT oi.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
GROUP BY oi.product_name
HAVING total_quantity > 1;

# SINGLE-ROW FUNCTIONS
#1.Find the customer who has spent the highest total amount on their orders.
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

#2.Retrieve the order with the highest total amount.
SELECT *
FROM orders
ORDER BY total_amount DESC
LIMIT 1;

#3.Find the most recently placed order.alter
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 1;

#4. Retrieve the customer with the fewest total orders.
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY order_count ASC
LIMIT 1;

#5.Find the product with the highest total quantity ordered.
SELECT oi.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
GROUP BY oi.product_name
ORDER BY total_quantity DESC
LIMIT 1;













 



 
