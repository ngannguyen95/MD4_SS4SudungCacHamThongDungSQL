create database quanLiSinhVien;
use quanLiSinhVien;
create table Class(
classid int auto_increment primary key,
className varchar (255) not null,
startdate datetime default now(),
status bit
);
create table student(
studentid int auto_increment primary key,
studentName varchar (30) not null,
address varchar (50) not null,
phone varchar (20) not null,
`status` bit,
classid int not null,
foreign key (classid) references class(classid)
);
create table subject(
subid int auto_increment primary key,
subname varchar (30) not null,
credit tinyint not null default(1) check(credit>=1),
`status` bit default(1)
);
create table mark(
markid int auto_increment primary key,
subid int unique,
foreign key (subid) references `subject`(subid),
studentid int,
foreign key(studentid) references student(studentid),
mark float default(0) check (mark between 0 and 100) ,
examtimes tinyint default(1)
);

insert into  class(classname) values
("a1"),("a2"),("a3"),("a4"),("a5"),("a6");
insert into student(studentname,address,phone,status,classid) values
("nguyen van a","ha noi",093526045,1,1),
("nguyen thi b","nghe an",093526045,1,1),
("nguyen van a2","ha noi2",000356045,0,1),
("nguyen van a3","ha noi3",093526045,1,2),
("nguyen van a4","ha noi4",093026045,0,2),
("nguyen van a5","ha noi",093526045,1,3),
("nguyen van a6","ha noi",093526045,1,3),
("nguyen van a7","ha noi",093526045,1,3);
insert into `subject`(subname,credit,status) values
("toan",5,1),
("van",10,1),
("hoa",15,1),
("lich su",6,1),
("tieng anh",20,1),
("dia",11,1);
insert into mark (subid,studentid,mark,examtimes)values
(1,2,50,10),
(2,3,60,12),
(3,4,80,12),
(4,2,100,1),
(5,4,75,2),
(6,1,60,3);
insert into mark (subid,studentid,mark,examtimes)values
(4,3,12,10),
(5,2,25,12),
(4,1,6,12),
(3,1,23,1),
(2,2,90,2),
(1,3,30,3);
-- drop table mark; 

-- hien thi danh sach tat ca sinh vien
select * from student;
-- hien thi danh sach cac hoc vien dang theo hoc
select *from student where status=1;
-- hien thi danh sach mon hoc có thoi gian hoc nhỏ hon 10
select * from subject where credit<=10;
-- hien thi danh sach hoc vien lop a1
select s.studentid,s.studentname,c.classname
from student s join class c on s.classid=c.classid
where c.classname="a1";
-- hien thi diem mon van cua cac hoc vien
select s.studentid,s.studentname,sub.subname,m.mark
from student s join mark m on s.studentid=m.studentid join subject sub on m.subid=sub.subid
where sub.subname="van";
-- hiển thị tất cả sinh viên có tên bắt đầu bằng kí tự "h"
select * from student where studentName like "n%";
-- hiển thị thông tin lớp học bắt đầu từ tháng 12
select * from mark where examtimes like  "12";
-- hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
select * from subject where credit between 3 and 5;
-- thay đổi mã lớp (classId) của sinh viên có tên là nguyen van a2 là 2
update student set classid=2 where studentname = "nguyen van a2";
-- hiển thị các thông tin sắp xếp theo điểm thi giảm dân
select student.studentName,`subject`.subname,mark.mark
from  
	student join `mark` on student.studentid = mark.studentid
join `subject` on `subject`.subid = mark.subid
order by mark.mark desc;
-- hiển thị số lượng sinh viên ở từng nơi
select address ,count(studentId) as "Số lượng học viên"
from student
group by address;
-- tính điểm trung bình các môn học của mỗi học viên
select s.studentId,s.studentName,avg(m.mark)
from student s join mark m on s.studentId=m.studentId
group by s.studentId,s.studentName;
-- 	Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 60
select s.studentName , avg(m.mark)
from student s join mark m on s.studentId=m.studentId
group by s.studentName
having avg(m.mark)>60;
--  Hiển thị thông tin các học viên có điểm trung bình lớn nhất
select s.studentId,s.studentName,max((m.mark))
from student s join mark m on s.studentId= m.studentId
group by s.studentId,s.studentName;
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất
select sb.subname ,sb.credit,max(sb.credit)
from `subject` sb
group by sb.subname,sb.credit;
-- Hiển thị các thông tin môn học có điểm thi lớn nhất
select sb.subname , max(m.mark)
from `subject` sb join mark m on sb.subid=m.subid
group by sb.subname;
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.studentId,s.studentName,avg(m.mark)
from student s join mark m on s.studentId=m.studentId
group by s.studentId,s.studentName
order by avg(m.mark ) desc;