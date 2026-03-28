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
