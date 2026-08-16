-- E-commerce Management System: SQL Project

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Data Insertion

-- Insert sample customers
INSERT INTO Customers (customer_name, email, phone, address) VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Elm Street'),
('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Oak Avenue');

-- Insert sample products
INSERT INTO Products (product_name, price, stock) VALUES
('Laptop', 50000.00, 10),
('Mouse', 1500.00, 50),
('Keyboard', 2000.00, 30),
('Monitor', 12000.00, 20);

-- Insert sample orders
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-01', 66500.00),
(2, '2025-01-02', 16500.00);

-- Insert sample order details
INSERT INTO OrderDetails (order_id, product_id, quantity, total_price) VALUES
(1, 1, 1, 50000.00), -- Laptop
(1, 2, 1, 1500.00),  -- Mouse
(1, 3, 1, 2000.00),  -- Keyboard
(2, 4, 1, 12000.00), -- Monitor
(2, 2, 3, 4500.00);  -- 3 Mice

-- Queries for Insights

-- Total Revenue Generated
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-- Best-Selling Products
SELECT P.product_name, SUM(OD.quantity) AS total_sold
FROM OrderDetails OD
JOIN Products P ON OD.product_id = P.product_id
GROUP BY P.product_name
ORDER BY total_sold DESC;

-- Customer Order Summary
SELECT C.customer_name, COUNT(O.order_id) AS total_orders, SUM(O.total_amount) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY total_spent DESC;

-- Out of Stock Products
SELECT product_name
FROM Products
WHERE stock = 0;

-- Daily Sales Report
SELECT order_date, SUM(total_amount) AS daily_revenue
FROM Orders
GROUP BY order_date
ORDER BY order_date;
