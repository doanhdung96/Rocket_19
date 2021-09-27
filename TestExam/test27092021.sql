drop database if exists QuanLyDiem;
create database if not exists QuanLyDiem;

use QuanLyDiem;

drop table if exists Student;
create table if not exists Student
(
	StudentID tinyint primary key auto_increment not null,
    `Name` varchar(50),
    `Age` tinyint,
    Gender bit

);

drop table if exists `Subject`;
create table if not exists `Subject`
(
	SubjectID tinyint primary key auto_increment not null,
    `Name` enum('Toán','Lý','Hoá')


);

drop table if exists StudentSubject;
create table if not exists StudentSubject
(
	
	StudentID tinyint,
    SubjectID tinyint,
    Mark float,
    `Date` date,
    
    constraint fk_st_id foreign key (StudentID) references Student(StudentID) on delete set null on update cascade,
    constraint fk_su_id foreign key (SubjectID) references `Subject`(SubjectID) on delete set null on update cascade




);

INSERT INTO Student
VALUES (1, 'Đỗ Anh Dũng', 25, 0),
 (2, 'Bùi Đức Toàn', 26, 0),
(3, 'Lê Đăng Hoàng', 27,0),
(4, 'Lê Đặng Sao Mai', 24,1),
(5, 'Nguyễn Kiều Anh', 23,1);

insert into `Subject`
value (1,'Toán'),
(2,'Lý'),
(3,'Hoá');

insert into studentsubject
value (1,1,9,'2021-09-23'),
(2,2,10,'2021-09-23'),
(3,2,8,'2021-09-23'),
(4,1,7,'2021-09-23'),
(5,1,8,'2021-09-23');


-- C2
select sj.`Name`
from `Subject` sj join Studentsubject ss on sj.SubjectID = ss.SubjectID
where ss.Mark is null;





