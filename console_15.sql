create table department(
    dept_id serial primary key,
    dept_name varchar(100) not null unique,
    dept_status boolean default true
);
create table employee(
    emp_id serial primary key,
    emp_name varchar(100) not null,
    emp_age int,
    emp_salary float,
    dept_id int references department(dept_id),
    emp_status boolean default true
);
insert into department(dept_name)
values ('HR'), ('IT'), ('Marketing');

insert into employee(emp_name, emp_age, emp_salary, dept_id, emp_status)
values
    ('Nguyễn Văn Huy', 20, 18000000, 1, true), -- dept_id = 1 (HR)
    ('Trần Thị Mai', 21, 12000000, NULL, true),
    ('Lê Quốc Trung', 22, 15000000, 2, true),  -- dept_id = 2 (IT)
    ('Nguyễn Văn Huy', 23, 18000000, 1, true),
    ('Phạm Ngọc Hân', 30, 14000000, NULL, false),
    ('Bùi Thị Lan', 50, 20000000, 3, true),    -- dept_id = 3 (Marketing)
    ('Đặng Hữu Tài', 35, 17000000, NULL, true);
/*
    JOIN: ghép nối nhiều bảng vs nhau
 */

select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
from employee e left join department d on e.dept_id = d.dept_id;

/*
    Join 3 baeng
    select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
    from employee e join department d on e.dept_id = d.dept_id
        join abc
 */
select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
from employee e full join department d on e.dept_id = d.dept_id;

-- In ra số lượng nhân viên có trong từng phòng ban
/*
    Các cột xuất hiện trong select thì phải có trong group bt
 */
select e.dept_id, d.dept_name, count(e.emp_id)
from employee e left join department d on d.dept_id = e.dept_id
group by e.dept_id, d.dept_name;

-- Lấy ra tất cả các phòng ban có số lượng nhân viên lớn > 2
select e.dept_id
from employee e
group by e.dept_id
having count(e.emp_id) >= 2;

-- Lấy thông tin các nhân viên nằm trong phòng ban có lương tb cao nhất
/*
    1. Lấy lương tb các phòng ban
    2. Lấy lương tb cao nhất
    3. Lấy thông tin nhân viên trong các phòng ban có lương cao nhất
 */
select *
from employee e join
(select e.dept_id, avg(e.emp_salary)
from employee e
group by e.dept_id
having avg(e.emp_salary) >= all
(select max(avg_salary)
from (select e.dept_id, avg(e.emp_salary) as "avg_salary"
      from employee e
      group by e.dept_id))) result on e.dept_id = result.dept_id;


drop sequence departments_dept_id_seq;

create table departments(
    dept_id serial primary key,
    dept_name varchar(100)
);
create table employees(
    emp_id serial primary key,
    emp_name varchar(100),
    dept_id int references departments(dept_id),
    salary numeric(10,2),
    hire_date DATE
);
create table projects(
    project_id serial primary key,
    project_name varchar(100),
    dept_id int references departments(dept_id)
);

select e.emp_name "Tên nhân viên", d.dept_name "Phòng ban", e.salary "Lương"
from employees e join departments d on e.dept_id = d.dept_id;

select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
from employee e left join department d on e.dept_id = d.dept_id;

insert into employee(emp_name, emp_age, emp_salary, dept_id, emp_status)
values
    ('Nguyễn Văn Huy', 20, 18000000, 1, true), -- dept_id = 1 (HR)
    ('Trần Thị Mai', 21, 12000000, NULL, true),
    ('Lê Quốc Trung', 22, 15000000, 2, true),  -- dept_id = 2 (IT)
    ('Nguyễn Văn Huy', 23, 18000000, 1, true),
    ('Phạm Ngọc Hân', 30, 14000000, NULL, false),
    ('Bùi Thị Lan', 50, 20000000, 3, true),    -- dept_id = 3 (Marketing)
    ('Đặng Hữu Tài', 35, 17000000, NULL, true);
/*
    JOIN: ghép nối nhiều bảng vs nhau
 */

select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
from employee e left join department d on e.dept_id = d.dept_id;

/*
    Join 3 baeng
    select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
    from employee e join department d on e.dept_id = d.dept_id
        join abc
 */
select e.emp_id, e.emp_name, e.emp_age, e.emp_salary, d.dept_name
from employee e full join department d on e.dept_id = d.dept_id;

-- In ra số lượng nhân viên có trong từng phòng ban
/*
    Các cột xuất hiện trong select thì phải có trong group bt
 */
select e.dept_id, d.dept_name, count(e.emp_id)
from employee e left join department d on d.dept_id = e.dept_id
group by e.dept_id, d.dept_name;

-- Lấy ra tất cả các phòng ban có số lượng nhân viên lớn > 2
select e.dept_id
from employee e
group by e.dept_id
having count(e.emp_id) >= 2;

-- Lấy thông tin các nhân viên nằm trong phòng ban có lương tb cao nhất
/*
    1. Lấy lương tb các phòng ban
    2. Lấy lương tb cao nhất
    3. Lấy thông tin nhân viên trong các phòng ban có lương cao nhất
 */
select *
from employee e join
     (select e.dept_id, avg(e.emp_salary)
      from employee e
      group by e.dept_id
      having avg(e.emp_salary) >= all
             (select max(avg_salary)
              from (select e.dept_id, avg(e.emp_salary) as "avg_salary"
                    from employee e
                    group by e.dept_id))) result on e.dept_id = result.dept_id;



CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL
);

INSERT INTO products (product_id, product_name, category)
VALUES (1, 'Laptop Dell', 'Electronics'),
    (2, 'IPhone 15', 'Electronics'),
    (3, 'Bàn học gỗ', 'Furniture'),
    (4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES (101, 1, 2, 2200),
    (102, 2, 3, 3300),
    (103, 3, 5, 2500),
    (104, 4, 4, 1600),
    (105, 1, 1, 1100);

SELECT p.category, SUM(o.total_price) total_sales, SUM(o.quantity) total_quantity
FROM products p JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;