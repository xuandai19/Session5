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

insert into departments(dept_name)
values ('HR'), ('IT'), ('Marketing');

insert into employees(emp_name, dept_id, salary, hire_date)
values
    ('Nguyễn Văn Huy', 1, 18000000,'2010-04-01'),
    ('Trần Thị Mai', 3, 12000000, '2005-01-01'),
    ('Lê Quốc Trung', NULL, 15000000, '2023-05-23'),
    ('Nguyễn Văn Huy', 2, 18000000, '2023-10-04'),
    ('Phạm Ngọc Hân', 3, 14000000, '2025-01-15'),
    ('Bùi Thị Lan', 1, 20000000,'2024-10-23'),
    ('Đặng Hữu Tài', NULL, 17000000,'2019-04-29');

INSERT INTO projects (project_name, dept_id)
VALUES
    ('Hệ thống Quản lý IoT', 1),
    ('Ứng dụng Web MemePicker', 1),
    ('Chiến dịch Tuyển dụng 2026', 2),
    ('Ra mắt Sản phẩm Mới', 3),
    ('Nâng cấp Bảo mật Mạng', 1);

select e.emp_name "Tên nhân viên", d.dept_name "Phòng ban", e.salary "Lương"
from employees e join departments d on e.dept_id = d.dept_id;

select sum(salary),
        avg(salary),
        max(salary),
        min(salary) ,
        count(emp_id)
from employees;

select d.dept_name, avg(e.salary) avg_salary
from departments d join employees e ON d.dept_id = e.dept_id
group by d.dept_name
having avg(e.salary) > 15000000;

select p.project_name, d.dept_name, e.emp_name
from projects p join departments d ON p.dept_id = d.dept_id
         join employees e ON d.dept_id = e.dept_id;

select emp_name, dept_id, salary
from employees e1
where salary = (
    select max(salary)
    from employees e2
    where e1.dept_id = e2.dept_id
);



create table students(
    student_id serial primary key,
    full_name varchar(100),
    major varchar(50)
);
create table courses(
    course_id serial primary key,
    course_name varchar(100),
    credit int
);
create table enrollments(
    student_id int references students(student_id),
    course_id int references courses(course_id),
    score numeric(5,2)
);

insert into courses(course_name, credit)
values
    ('Quản lý IoT', 3),
    ('Ứng dụng Web', 4),
    ('Bảo mật Mạng', 3);

insert into students(full_name, major)
values
    ('Nguyễn Văn Huy', 'IT'),
    ('Trần Thị Mai', 'Marketing'),
    ('Lê Quốc Trung','IT'),
    ('Nguyễn Văn Huy', 'Teach'),
    ('Phạm Ngọc Hân', 'Teach'),
    ('Bùi Thị Lan', 'Marketing'),
    ('Đặng Hữu Tài', 'IT');

insert into enrollments(student_id, course_id, score)
values
    (1, 1, 8.5),
    (1, 3, 6.5),
    (2, 2, 7.0),
    (3, 1, 9.5),
    (4, 2, 5.0),
    (4, 4, 5.5),
    (5, 3, 7.5),
    (6, 2, 8.0),
    (7, 1, 6.0);

select s.full_name "Tên sinh viên", c.course_name "Môn học", e.score "Điểm"
from students s join enrollments e on s.student_id = e.student_id
         join courses c on e.course_id = c.course_id;

select s.full_name, avg(e.score) "Điểm trung bình", max(e.score) "Điểm cao nhất", min(e.score) "Điểm thấp nhất"
from students s join enrollments e on s.student_id = e.student_id
group by s.student_id, s.full_name;

select e.student_id, avg(e.score) "Điểm trung bình", max(e.score) "Điểm cao nhất", min(e.score) "Điểm thấp nhất"
from enrollments e
group by e.student_id;

select s.major, avg(e.score)
from students s JOIN enrollments e on s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

select s.full_name, c.course_name, c.credit, e.score
from students s join enrollments e on s.student_id = e.student_id
         join courses c on e.course_id = c.course_id;

select s.full_name, avg(e.score)
from students s join enrollments e on s.student_id = e.student_id
group by s.student_id, s.full_name
having avg(e.score) > (
    select avg(score)
    from enrollments e
);


create table customers(
    customer_id serial primary key,
    customer_name varchar(100),
    city varchar(50)
);
create table orders(
    order_id serial primary key,
    customer_id int references customers(customer_id),
    order_date date,
    total_amount numeric(10,2)
);
create table order_items(
    item_id serial primary key,
    order_id int references orders(order_id),
    product_name varchar(100),
    quantity int,
    price numeric(10,2)
);

insert into customers(customer_name, city)
values
    ('Nguyễn Văn An', 'Hà Nội'),
    ('Lê Thị Bình', 'Hồ Chí Minh'),
    ('Trần Văn Cường', 'Đà Nẵng'),
    ('Phạm Minh Đức', 'Hà Nội');

insert into orders(customer_id, order_date, total_amount)
values
    (1, '2024-03-01', 15000.00),
    (2, '2024-03-05', 8000.00),
    (3, '2024-03-10', 12000.00),
    (4, '2024-03-12', 5000.00),
    (1, '2024-03-15', 2000.00);

insert into order_items(order_id, product_name, quantity, price)
values
    (1, 'Laptop Dell', 1, 15000.00),
    (2, 'iPhone 13', 1, 8000.00),
    (3, 'Tủ lạnh Samsung', 1, 12000.00),
    (4, 'Chuột không dây', 5, 1000.00),
    (5, 'Bàn phím cơ', 1, 2000.00);

select c.customer_name "Tên khách", o.order_date "Ngày đặt hàng", o.total_amount "Tổng tiền"
from customers c join orders o on c.customer_id = o.customer_id;

select s.full_name, avg(e.score) "Điểm trung bình", max(e.score) "Điểm cao nhất", min(e.score) "Điểm thấp nhất"
from students s join enrollments e on s.student_id = e.student_id
group by s.student_id, s.full_name;

select
       sum(total_amount) "Tổng doanh thu",
       avg(total_amount) "Tb giá trị đơn hàng",
       max(total_amount) "Đơn hàng lớn nhất",
       min(total_amount) "Đơn hàng nhỏ nhất",
       count(order_id) "Số lượng đơn hàng"
from orders;

select c.city, sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;

select c.customer_name, o.order_date, oi.quantity, oi.price
from customers c join orders o on c.customer_id = o.customer_id
                join order_items oi on oi.order_id = o.order_id;

select s.full_name, avg(e.score)
from students s join enrollments e on s.student_id = e.student_id
group by s.student_id, s.full_name
having avg(e.score) > (
    select sum(total_amount)
    from orders o
);


