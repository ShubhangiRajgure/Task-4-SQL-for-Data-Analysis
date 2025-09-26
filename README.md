# Task-4-SQL-for-Data-Analysis
# 📊 Ecommerce_SQL_Database
This project contains a **sample Ecommerce SQL Database** built in **MySQL**.  
It is designed for practicing **SQL queries, joins, aggregate functions, views, and query optimization**.

---

## 🏗️ Database Schema

The database `Ecommerce_SQL_Database` includes the following tables:
### 1. Customers
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| CustomerID | int(11)      | NO   | PRI | NULL    | auto_increment |
| Name       | varchar(255) | NO   |     | NULL    |                |
| Email      | varchar(255) | NO   | UNI | NULL    |                |
| Country    | varchar(100) | YES  | MUL | NULL    |                |
| SignupDate | date         | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
### 2. Products
+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| ProductID | int(11)       | NO   | PRI | NULL    | auto_increment |
| Name      | varchar(100)  | NO   |     | NULL    |                |
| Category  | varchar(50)   | YES  |     | NULL    |                |
| Price     | decimal(10,2) | NO   |     | NULL    |                |
| Stock     | int(11)       | YES  |     | 0       |                |
+-----------+---------------+------+-----+---------+----------------+
### 3. Orders
+-------------+---------------+------+-----+---------+----------------+
| Field       | Type          | Null | Key | Default | Extra          |
+-------------+---------------+------+-----+---------+----------------+
| OrderID     | int(11)       | NO   | PRI | NULL    | auto_increment |
| CustomerID  | int(11)       | NO   |     | NULL    |                |
| OrderDate   | date          | NO   | MUL | NULL    |                |
| TotalAmount | decimal(10,2) | NO   |     | NULL    |                |
+-------------+---------------+------+-----+---------+----------------+
### 4. OrderDetails
+---------------+---------------+------+-----+---------+----------------+
| Field         | Type          | Null | Key | Default | Extra          |
+---------------+---------------+------+-----+---------+----------------+
| OrderDetailID | int(11)       | NO   | PRI | NULL    | auto_increment |
| OrderID       | int(11)       | YES  | MUL | NULL    |                |
| ProductID     | int(11)       | YES  | MUL | NULL    |                |
| Quantity      | int(11)       | NO   |     | NULL    |                |
| UnitPrice     | decimal(10,2) | NO   |     | NULL    |                |
+---------------+---------------+------+-----+---------+----------------+

## 📥 Sample Data Inserted

### Customers
- Amit Sharma (India)  
- Priya Verma (India)  
- John Smith (USA)  
- Emma Brown (UK)  
- Rajesh Kumar (India)  

### Products
- iPhone 14 – Electronics  
- Samsung Galaxy S23 – Electronics  
- Dell Laptop – Computers  
- Nike Running Shoes – Footwear  
- Adidas T-shirt – Clothing  

### Orders & OrderDetails
- Amit placed multiple orders (iPhone, Samsung, T-shirt)  
- Priya bought Nike Shoes  
- John bought Samsung Galaxy  
- Emma bought Dell Laptop  

## 🔍 Example Queries

### 1. Get all customers from India
### 2. Total sales by product category
### 3. Customers who spent more than the average order amount
### 4. Average order value per customer
### 5. Create a view to quickly analyze sales by customer
### 6. Index on Customers for faster lookups by country, Index on Orders for faster queries by date, Composite index for OrderDetails to optimize joins
