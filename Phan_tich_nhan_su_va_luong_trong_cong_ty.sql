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
