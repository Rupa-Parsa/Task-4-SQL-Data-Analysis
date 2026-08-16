USE ecommerce_db;

-- 1. SELECT: Display all customers
SELECT * 
FROM Customers;

-- 2. WHERE: Display products with price greater than 2000
SELECT product_name, price
FROM Products
WHERE price > 2000;

-- 3. ORDER BY: Display products from highest to lowest price
SELECT product_name, price
FROM Products
ORDER BY price DESC;

SELECT C.customer_name, SUM(O.total_amount) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY total_spent DESC;

SELECT SUM(total_amount) AS total_revenue
FROM Orders;

SELECT AVG(total_amount) AS average_order_value
FROM Orders;

SELECT AVG(total_amount) AS average_order_value
FROM Orders;

SELECT C.customer_name, O.order_id, O.order_date, O.total_amount
FROM Customers C
INNER JOIN Orders O
ON C.customer_id = O.customer_id;

SELECT C.customer_name, O.order_id, O.order_date, O.total_amount
FROM Customers C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id;

SELECT C.customer_name, O.order_id, O.order_date, O.total_amount
FROM Customers C
RIGHT JOIN Orders O
ON C.customer_id = O.customer_id;

SELECT product_name, price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);

SELECT customer_name, total_amount
FROM Customers
JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM Orders
);

SELECT C.customer_name, SUM(O.total_amount) AS total_spent
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY C.customer_name
HAVING SUM(O.total_amount) > 20000;

CREATE VIEW customer_order_summary AS
SELECT 
    C.customer_name,
    O.order_id,
    O.order_date,
    O.total_amount
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id;

SELECT * FROM customer_order_summary;

CREATE INDEX idx_customer_id
ON Orders(customer_id);

SHOW INDEX FROM Orders;

SELECT product_name, stock
FROM Products
WHERE stock IS NULL;

SELECT 
    customer_name,
    COALESCE(phone, 'Not Available') AS phone_number
FROM Customers;