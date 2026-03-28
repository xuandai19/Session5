CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10, 2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10, 2)
);

INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội'),
    (2, 'Trần Thị B', 'Đà Nẵng'),
    (3, 'Lê Văn C', 'Hồ Chí Minh'),
    (4, 'Phạm Thị D', 'Hà Nội');

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES (101, 1, '2024-12-20', 3000),
    (102, 2, '2025-01-05', 1500),
    (103, 1, '2025-02-10', 2500),
    (104, 3, '2025-02-15', 4000),
    (105, 4, '2025-03-01', 800);

INSERT INTO order_items (item_id, order_id, product_name, quantity, price)
VALUES (1, 101, 'Laptop Dell', 2, 1500),
    (2, 102, 'Bàn học gỗ', 1, 1500),
    (3, 103, 'IPhone 15', 5, 500),
    (4, 104, 'Bàn học gỗ', 4, 1000);

SELECT c.customer_name, o.order_date, o.total_amount
FROM customers c JOIN orders o ON c.customer_id = o.customer_id;

SELECT SUM(total_amount) total_revenue,
    AVG(total_amount) average_order_value,
    MAX(total_amount) max_order_value,
    MIN(total_amount) min_order_value,
    COUNT(order_id) AS total_orders
FROM orders;

SELECT c.city, SUM(o.total_amount) city_total_revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT c.customer_name, o.order_date, oi.product_name, oi.quantity, oi.price
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
         JOIN order_items oi ON o.order_id = oi.order_id;

SELECT c.customer_name, SUM(o.total_amount) total_revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_per_customer)
    FROM (
        SELECT SUM(total_amount) total_per_customer
        FROM orders
        GROUP BY customer_id
    ) AS sub
);
