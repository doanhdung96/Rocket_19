drop database if exists Testing_System_Assignment_1;
create database if not exists Testing_System_Assignment_1;
use Testing_System_Assignment_1;
drop table if exists `Department`;

create table if not exists `Department`
(
	`DepartmentID`	 	tinyint primary key auto_increment not null ,
    `DepartmentName`	varchar(50) not null
);

drop table if exists `Position`;
create table if not exists  `Position`
(
	`PositionID`		tinyint  auto_increment not null ,
    `PositionName` 		enum('Dev','Test','Scrum Master','PM') ,
    CONSTRAINT pk_p PRIMARY KEY (`PositionID`)
);

drop table if exists `Account`;
create table if not exists `Account`
(
	`AccountID`		 	mediumint primary key auto_increment ,
    `Email` 			varchar(100) unique ,
    `Username` 			varchar(100) not null,
    `Fullname`			varchar(50),
    `DepartmentID` 		tinyint default 0,
    `PositionID`	 	tinyint,
    `CreateDate` 		datetime,
    
    constraint fk_dpm_id foreign key (`DepartmentID`) references `Department` (`DepartmentID`),
    constraint fk_pst_id foreign key (`PositionID`) references `Position` (`PositionID`)
    
    
    );
    
drop table if exists `Group`;
create table if not exists `Group`
(
	`GroupID` 		mediumint primary key auto_increment not null,
    `GroupName` 	varchar(50) not null,
    `CreatorID`		mediumint not null,
    `CreateDate` 	datetime
    
    
    
    );
    
drop table if exists `GroupAccount`;
create table if not exists `GroupAccount`
(
		`GroupID`		mediumint not null,
        `AccountID` 	mediumint,
        `JoinDate`		datetime,
        
        constraint fk_gr_id foreign key (`GroupID`) references `Group` (`GroupID`)
);

drop table if exists `TypeQuestion`;
create table if not exists `TypeQuestion`
(
	`TypeID` 	tinyint primary key auto_increment not null,
    `TypeName` 	varchar(50)
);

 drop table if exists `CategoryQuestion`;
 create table if not exists `CategoryQuestion`
 (
	`CategoryID`	 tinyint primary key auto_increment not null,
    `CategoryName`	 enum('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
    
    
);
    
drop table if exists `Question`;
create table if not exists `Question`
(
	`QuestionID`	 tinyint primary key auto_increment not null,
    `Content`		 varchar(50),
    `CategoryID`	 tinyint,
    `TypeID`		 tinyint,
    `CreatorID`		 mediumint,
    `CreateDate`	 datetime,
    
    constraint fk_ctg_id foreign key (`CategoryID`) references `CategoryQuestion` (`CategoryID`),
    constraint fk_tp_id foreign key (`TypeID`) references `TypeQuestion` (`TypeID`),
    constraint fk_ct_id foreign key (`CreatorID`) references `Account` (`AccountID`)
    
);

drop table if exists `Answer`;
create table if not exists `Answer`
(
	`AnswerID`		tinyint primary key auto_increment not null,
    `Content`		varchar(50),
    `QuestionID`	tinyint,
    `isCorrect`		bit,
    
    constraint fk_qt_id foreign key (`QuestionID`) references `Question` (`QuestionID`) ON DELETE CASCADE
    
);
    
drop table if exists `Exam`;
create table if not exists `Exam`
(
	`ExamID`		tinyint primary key auto_increment not null,
    `Code`			varchar(50) not null,
    `Title`			varchar(50) not null,
    `CategoryID`	tinyint,
    `Duration`		tinyint,
    `CreatorID`		mediumint,
    `CreateDate`	datetime,
    
    CONSTRAINT fk_ex_acc FOREIGN KEY (`CreatorID`)
	REFERENCES `account`(`AccountID`),
	CONSTRAINT fk_ex_cate FOREIGN KEY (`CategoryID`) 
	REFERENCES `CategoryQuestion` (`CategoryID`)
  
    
);

drop table if exists `ExamQuestion`;
create table if not exists `ExamQuestion`
(
    `ExamID`     tinyint ,
    `QuestionID` tinyint,
    
constraint fk_eq1 foreign key (`ExamID`) 
references `Exam` (`ExamID`) ON DELETE CASCADE,

 constraint fk_eq2 foreign key (`QuestionID`)
 references `Question` (`QuestionID`) ON DELETE CASCADE
    
);
 /*end as1*/
 
 -- AS 2
 
INSERT INTO `Department`(`DepartmentID`,`DepartmentName`)
VALUES ('1','Phong Ky Thuat 1'),
       ('2','Phong Ky Thuat 2'),
       ('3','Phong Dev 1'),
       ('4','Phong Dev 2'),
       ('5','Phong Sale'),
       ('6','Phong Marketing'),
       ('7','Phong Giam Doc'),
       ('8','Phong Noi Vu'),
       ('9','Phong PR'),
       ('10','Phong HR');
       
       

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');

INSERT INTO `Position`(`PositionName`)
VALUES ('Dev2'),
       ('Dev1'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');


/* INSERT DATA bang Account */
INSERT INTO `Account`(`AccountID`,`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES ('1','maxmad1@gmai.com', 'dtm', 'Doan Thi Mo', 1, 1, '2019-12-01'),
       ('2','maxmad2@gmai.com', 'thl', 'Dinh Hoai Dao', 1, 2, '2020-12-01'),
       ('3','maxmad3@gmai.com', 'lmq', 'Le Minh Quang', 1, 1, '2020-07-01'),
       ('4','maxmad4@gmai.com', 'ldh', 'Le Dang Hoang', 1, 2, '2019-09-01'),
       ('5','maxmad5@gmai.com', 'dvd', 'Do Van Dung', 3, 2, '2021-07-01'),
       ('6','maxmad6@gmai.com', 'das', 'Do Anh Son', 3, 1, NOW()),
       ('7','maxmad7@gmai.com', 'nnh', 'Nguyen Ngoc Hoang', 3, 3, '2020-10-01'),
       ('8','maxmad8@gmai.com', 'bdt', 'Bui Duc Toan', 3, 4, '2019-04-01'),
       ('9','maxmad9@gmai.com', 'tkt', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('10','maxmad10@gmai.com', 'ldsm', 'Le Dang Sao Mai', 1, 5, '2019-10-01'),
       ('11','maxmad11@gmai.com', 'ntpl', 'Nguyen Thi Phuong Lan', 1, 3, '2020-12-01');

/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupName`, `CreatorID`, `CreateDate`)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('1', '1', '2021-07-01'),
       ('2', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-07-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan');

/* INSERT DATA bang CategoryQuestion */
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');



INSERT INTO `Question`(`QuestionID`,`Content`,`CategoryID`, `TypeID`, `CreatorID`, `CreateDate`)
VALUES ('1','Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       ('2','Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('3','Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       ('4','Câu hỏi JAVA 2', 1, 2, 5, '2021-06-01'),
       ('5','Câu hỏi HTML 1', 3, 1, 2, NOW()),
       ('6','Câu hỏi HTML 2', 3, 2, 2, NOW()),
       ('7','Câu hỏi C# 1', 3, 1, 2, NOW()),
       ('8','Câu hỏi C++ 1', 3, 1, 2, NOW()),
       ('9','Câu hỏi abc 1', 3, 1, 2, NOW()),
       ('10','Câu hỏi xyz 1', 3, 1, 2, NOW());


/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
       ('Câu trả lời 2 - question SQL 1', 1, 0),
       ('Câu trả lời 3 - question SQL 1', 1, 0),
       ('Câu trả lời 4 - question SQL 1', 1, 1),
       ('Câu trả lời 1 - question SQL 2', 2, 0),
       ('Câu trả lời 2 - question SQL 2', 2, 0),
       ('Câu trả lời 3 - question SQL 2', 2, 0),
       ('Câu trả lời 4 - question SQL 2', 2, 1),
       ('Câu trả lời 1 - question JAVA 1', 3, 0),
       ('Câu trả lời 2 - question JAVA 1', 3, 1),
       ('Câu trả lời 1 - question JAVA 2', 4, 0),
       ('Câu trả lời 2 - question JAVA 2', 4, 0),
       ('Câu trả lời 3 - question JAVA 2', 4, 0),
       ('Câu trả lời 4 - question JAVA 2', 4, 1),
       ('Câu trả lời 1 - question HTML 1', 5, 1),
       ('Câu trả lời 2 - question HTML 2', 5, 0);


/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 1, 60, 1, NOW());

/* INSERT DATA bang Examquestion */
INSERT INTO `ExamQuestion`
VALUES (1,1),
									(1,4),
									(2,2),
									(2,3),
									(2,5),
									(3,6),
									(3,8),
									(3,9),
									(4,7),
									(5,10);
 -- End AS 2      
 
 --  AS 3 --
 
 -- 1. Lấy all Department
 select * from Department;
 
 -- 2. Lay id Department "Sale"
 select `DepartmentID` from `Department` where `DepartmentName` = 'Phong Sale'; 
 
  -- 3. Lay ra Account co Fullname = Max
select Fullname, character_length(Fullname) as `ddMax` 
from `Account` order by dodai desc;

-- 4. Lay ra all thong tin Account co Fullname = Max thuoc DepartmentID = 3
select * from `Account` 
where character_length(`FullName`) = (select MAX(character_length(`FullName`))
 from `Account` as `A1` where `DepartmentID` = 3) and `DepartmentID` = 3;

-- 5. Lay ra Groupname tham gia truoc ngay 20/12/2019
select `GroupName` from `Group` where `CreateDate` < '2019-12-20';

-- 6. Lay ra QuestionID co >= 4 Answer
select `QuestionID`, COUNT(`QuestionID`) AS `SLAnswer` from `Answer`
group by `QuestionID`
having `SLAnswer` >=4;

-- 7. Lay ra cac ma de thi co time >= 60p va dc tao trc ngay 20/12/2019
select `Code`,`Duration`, `CreateDate` from `Exam`
where `Duration` >= 60 and `CreateDate` < '2019-12-20';

-- 8. Lay ra 5 Group dc tao gan nhat
select * from `Group` order by `CreateDate` desc limit 5;

-- 9. Dem so nhan vien co DepartmentID = 2
select COUNT(`DepartmentID`) as `SLdpmid = 2`
from `Account`
where `DepartmentID` = 2;

-- 10. Lay ra ten nhan vien bat dau = D , ket thuc = o
select `Fullname`
from `Account`
where `FullName` LIKE 'D%o' ;
/* Chi ra duoc 1 ket qua trong khi da dinh 2 Fullname co Bat dau = D va ket thuc = o */

-- 11. Xoa all Exam dc tao trc ngay 20/12/2019
SET SQL_SAFE_UPDATES = 0; -- Tai sao them dong nay moi su dung dc Delete
 delete from `Exam` where (`CreateDate` < '2019-12-20');
/* Chua lam dc cau nay*/

-- 12. Xoa tat ca cac Question bat dau = Cau hoi
SET SQL_SAFE_UPDATES = 0;
delete from `Question` where `Content` like 'Câu hỏi%';

-- 13. Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SET SQL_SAFE_UPDATES = 0;
update `Account`
set `FullName` = "Nguyễn Bá Lộc", `Email`= "loc.nguyenba@vti.com.vn"
where `AccountID` = 5;

-- 14. update account có id = 5 sẽ thuộc group có id = 4
SET SQL_SAFE_UPDATES = 0;
update `GroupAccount`
set `GroupID` = 4
where `AccountID` = 5;
