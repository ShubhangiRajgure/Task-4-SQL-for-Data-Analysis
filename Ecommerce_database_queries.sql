-- Create Database
CREATE DATABASE IF NOT EXISTS Ecommerce_SQL_Database;
USE Ecommerce_SQL_Database;

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Country VARCHAR(50),
    SignupDate DATE DEFAULT (CURRENT_DATE)
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE DEFAULT (CURRENT_DATE),
    TotalAmount DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

USE Ecommerce_SQL_Database;

-- Insert Customers
INSERT INTO Customers (Name, Email, Country, SignupDate) VALUES
('Amit Sharma', 'amit.sharma@example.com', 'India', '2024-01-15'),
('Priya Verma', 'priya.verma@example.com', 'India', '2024-02-10'),
('John Smith', 'john.smith@example.com', 'USA', '2024-03-05'),
('Emma Brown', 'emma.brown@example.com', 'UK', '2024-04-20'),
('Rajesh Kumar', 'rajesh.kumar@example.com', 'India', '2024-05-01');

-- Insert Products
INSERT INTO Products (Name, Category, Price, Stock) VALUES
('iPhone 14', 'Electronics', 799.99, 50),
('Samsung Galaxy S23', 'Electronics', 699.99, 40),
('Dell Laptop', 'Computers', 999.99, 30),
('Nike Running Shoes', 'Footwear', 120.00, 100),
('Adidas T-shirt', 'Clothing', 35.00, 200);

-- Insert Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-05-05', 1599.98),
(2, '2024-05-10', 120.00),
(3, '2024-05-15', 699.99),
(1, '2024-06-01', 35.00),
(4, '2024-06-10', 999.99);

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 799.99),
(1, 2, 1, 699.99),
(2, 4, 1, 120.00),
(3, 2, 1, 699.99),
(4, 5, 1, 35.00),
(5, 3, 1, 999.99);

USE Ecommerce_SQL_Database;

-- 1. Get all customers from India
SELECT * FROM Customers WHERE Country = 'India';

-- 2. Total sales by product category
SELECT p.Category, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;

-- 3. Get orders with customer details
SELECT o.OrderID, o.OrderDate, c.Name AS CustomerName, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;

-- 4. Customers and their orders (LEFT JOIN)
SELECT c.CustomerID, c.Name, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5. Customers who spent more than average
SELECT CustomerID, Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (SELECT AVG(TotalAmount) FROM Orders)
);

-- 6. Average order value per customer
SELECT c.Name, AVG(o.TotalAmount) AS AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- 7. Create a view for sales by customer
CREATE OR REPLACE VIEW CustomerSales AS
SELECT c.CustomerID, c.Name, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- 8. Use the view
SELECT * FROM CustomerSales ORDER BY TotalSpent DESC;

-- 9. Create indexes for optimization
CREATE INDEX idx_country ON Customers(Country);
CREATE INDEX idx_order_date ON Orders(OrderDate);
CREATE INDEX idx_order_product ON OrderDetails(OrderID, ProductID);
