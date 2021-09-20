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
    
    -- ASM 4
    
    -- C1. Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
    select `Fullname`, A.DepartmentID, D.DepartmentID,`DepartmentName`
    from `Account` A left join `Department` D on A.DepartmentID = D.DepartmentID;
    
    -- C2. Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
    select * from `Account` where CreateDate > '2020-12-20'; 

-- C3. Viết lệnh để lấy ra tất cả các developer
 select `Fullname`, A.PositionID, P.PositionID, `PositionName`
 from `Account` A inner join `Position` P on `PositionName` like 'Dev%';
 
 -- C4. Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
 select D.DepartmentID, D.DepartmentName, COUNT(*) as SoLuong
from `Department` D join `Account` A on D.DepartmentID = A.DepartmentID
group by D.DepartmentID
having SoLuong > 3;
 
 -- C5. Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhat
 select `Content`, Q.`QuestionID`, E.`QuestionID`  from `ExamQuestion` E
inner join `Question` Q on Q.`QuestionID` = E.`QuestionID`
group by E.`QuestionID` 
having count(E.`QuestionID`) = 
 ( select 
             CASE 
                  WHEN max(E.`QuestionID`)
                     THEN 'Cau dc hoi nhieu nhat' 
                  ELSE 0 
             END 
 group by E.`QuestionID`
 );

-- C6. Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) FROM `CategoryQuestion` cq
JOIN `Question` q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;
 
 -- C7. Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT Q.Content, COUNT(EQ.QuestionID) AS 'SO LUONG'
FROM Question Q
LEFT JOIN ExamQuestion EQ ON EQ.QuestionID = Q.QuestionID
GROUP BY Q.QuestionID
ORDER BY EQ.ExamID ASC;

-- C8. Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.`QuestionID`, Q.`Content`, count(A.`QuestionID`) FROM `Answer` A
INNER JOIN `Question` Q ON Q.QuestionID = A.QuestionID
GROUP BY A.`QuestionID`
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);


-- C9. Thống kê số lượng account trong mỗi group

-- C10. Tìm chức vụ có ít người nhất


-- C11. Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
    SELECT 
    d.DepartmentID,
    d.DepartmentName,
    p.PositionName,
    COUNT(p.PositionName) AS count_position
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
        JOIN
    position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID , p.PositionID
order by DepartmentID;

-- C12. Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của 
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
    
-- C13. Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
  
-- C14. Lấy ra group không có account nào 
  
-- C15. Lấy ra group không có account nào

-- C16. Lấy ra question không có answer nào 
    
    
    
drop table if exists `Group`;
create table if not exists `Group`
(
	`GroupID` 		mediumint  auto_increment not null,
    `GroupName` 	varchar(50) not null,
    `CreatorID`		mediumint not null,
    `CreateDate` 	datetime,
    
    PRIMARY KEY (`GroupID`),
	CONSTRAINT fk_gr_acc
	FOREIGN KEY (`CreatorID`)
	REFERENCES `account`(`AccountID`)
    
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
    `Duration`		float,
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
VALUES (1,'Phong Ky Thuat 1'),
       (2,'Phong Ky Thuat 2'),
       (3,'Phong Dev 1'),
       (4,'Phong Dev 2'),
       (5,'Phong Sale'),
       (6,'Phong Marketing'),
       (7,'Phong Giam Doc'),
       (8,'Phong Noi Vu'),
       (9,'Phong PR'),
       (10,'Phong HR');
       
       

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');

INSERT INTO `Position`(`PositionID`,`PositionName`)
VALUES (1,'Dev1'),
       (2,'Dev2'),
       (3,'Test'),
       (4,'PM'),
       (5,'Leader'),
       (6,'Scrum Master');


/* INSERT DATA bang Account */
INSERT INTO `Account`(`AccountID`,`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES (1,'maxmad1@gmai.com', 'dtm', 'Doan Thi Mo', 1, 1, '2019-12-01'),
       (2,'maxmad2@gmai.com', 'thl', 'Dinh Hoai Dao', 1, 2, '2020-12-01'),
       (3,'maxmad3@gmai.com', 'lmq', 'Le Minh Quang', 1, 1, '2020-07-01'),
       (4,'maxmad4@gmai.com', 'ldh', 'Le Dang Hoang', 1, 2, '2019-09-01'),
       (5,'maxmad5@gmai.com', 'dvd', 'Do Van Dung', 3, 2, '2021-07-01'),
       (6,'maxmad6@gmai.com', 'das', 'Do Anh Son', 3, 1, NOW()),
       (7,'maxmad7@gmai.com', 'nnh', 'Nguyen Ngoc Hoang', 3, 3, '2020-10-01'),
       (8,'maxmad8@gmai.com', 'bdt', 'Bui Duc Toan', 3, 4, '2019-04-01'),
       (9,'maxmad9@gmai.com', 'tkt', 'Tran Kim Tuyen', 2, 1, NOW()),
       (10,'maxmad10@gmai.com', 'ldsm', 'Le Dang Sao Mai', 5, 5, '2019-10-01'),
       (11,'maxmad11@gmai.com', 'ntpl', 'Nguyen Thi Phuong Lan', 1, 3, '2020-12-01');

/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupID`,`GroupName`, `CreatorID`, `CreateDate`)
VALUES (1,'Nhom 1', 3, '2021-04-03'),
       (2,'Nhom 2', 3, '2019-01-03'),
       (3,'Nhom 3', 2, '2020-04-03'),
       (4,'Nhom 4', 1, NOW()),
       (5,'Nhom 5', 3, '2021-06-03'),
       (6,'Nhom 6', 1, '2020-04-03'),
       (7,'Nhom 7', 5, '2021-04-03'),
       (8,'Nhom 8', 5, '2019-05-03'),
       (9,'Nhom 9', 3, '2019-01-03'),
       (10,'Nhom 10', 1, NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES (1, 1, '2021-07-01'),
       (2, 3, '2020-01-01'),
       (1, 2, NOW()),
       (1, 4, '2021-07-01'),
       (2, 1, '2021-06-01'),
       (2, 10, '2019-05-01'),
       (5, 1, '2021-06-01'),
       (5, 3, '2020-01-01'),
       (5, 4, '2021-07-01'),
       (3, 1, '2021-06-01'),
       (9, 2, '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeID`,`TypeName`)
VALUES (1,'Trac nghiem'),
       (2,'Tu Luan');

/* INSERT DATA bang CategoryQuestion */
INSERT INTO `CategoryQuestion` (`CategoryID`,`CategoryName`)
VALUES (1,'Java'),
       (2,'SQL'),
       (3,'HTML'),
       (4,'CSS '),
       (5,'.NET'),
       (6,'Python'),
       (7,'Ruby'),
       (8,'JavaScript');



INSERT INTO `Question`(`QuestionID`,`Content`,`CategoryID`, `TypeID`, `CreatorID`, `CreateDate`)
VALUES (1,'Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       (2,'Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       (3,'Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       (4,'Câu hỏi JAVA 2', 1, 2, 5, '2021-06-01'),
       (5,'Câu hỏi HTML 1', 3, 1, 2, NOW()),
       (6,'Câu hỏi HTML 2', 3, 2, 2, NOW()),
       (7,'Câu hỏi C# 1', 3, 1, 2, NOW()),
       (8,'Câu hỏi C++ 1', 3, 1, 2, NOW()),
       (9,'Câu hỏi abc 1', 3, 1, 2, NOW()),
       ('10','Câu hỏi xyz 1', 3, 1, 2, NOW());


/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`AnswerID`,`Content`, `QuestionID`, `isCorrect`)
VALUES (1,'Câu trả lời 1 - question SQL 1', 1, 1),
       (2,'Câu trả lời 2 - question SQL 1', 1, 0),
       (3,'Câu trả lời 3 - question SQL 1', 1, 0),
       (4,'Câu trả lời 4 - question SQL 1', 1, 1),
       (5,'Câu trả lời 1 - question SQL 2', 2, 0),
       (6,'Câu trả lời 2 - question SQL 2', 2, 0),
       (7,'Câu trả lời 3 - question SQL 2', 2, 0),
       (8,'Câu trả lời 4 - question SQL 2', 2, 1),
       (9,'Câu trả lời 1 - question JAVA 1', 3, 0),
       (10,'Câu trả lời 2 - question JAVA 1', 3, 1),
       (11,'Câu trả lời 1 - question JAVA 2', 4, 0),
       (12,'Câu trả lời 2 - question JAVA 2', 4, 0),
       (13,'Câu trả lời 3 - question JAVA 2', 4, 0),
       (14,'Câu trả lời 4 - question JAVA 2', 4, 1),
       (15,'Câu trả lời 1 - question HTML 1', 5, 1),
       (16,'Câu trả lời 2 - question HTML 2', 5, 0);


/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`ExamID`,`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES (1,'MS_01', 'De thi 01', 1, 90, 1, NOW()),
       (2,'MS_02', 'De thi 02', 1, 60, 5, NOW()),
       (3,'MS_03', 'De thi 03', 2, 60, 9, NOW()),
       (4,'MS_04', 'De thi 04', 2, 90, 1, NOW()),
       (5,'MS_05', 'De thi 05', 1, 60, 2, NOW()),
       (6,'MS_06', 'De thi 06', 2, 90, 2, NOW()),
       (7,'MS_07', 'De thi 07', 1, 60, 1, NOW());

/* INSERT DATA bang Examquestion */
INSERT INTO `ExamQuestion`
VALUES (1,1),
									(1,4),
									(2,2),
									(2,3),
									(2,5),
									(3,2),
									(3,2),
									(3,2),
									(4,7),
									(5,10);
 -- End AS 2      
 
 --  AS 3 --
 
 -- 1. Lấy all Department
 select * from Department;
 
 -- 2. Lay id Department "Sale"
 select `DepartmentID` from `Department` where `DepartmentName` = 'Phong Sale'; 
 
  -- 3. Lay ra Account co Fullname = Max
-- select `Account`, character_length(`Fullname`) as `ddMax` 
-- from `Account` order by dodai desc;

SELECT * FROM `Account`
WHERE character_length(`Fullname`) = (SELECT MAX(character_length(`Fullname`)) FROM `Account` AS newTable);

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


-- 11. Xoa all Exam dc tao trc ngay 20/12/2019
 
 SET SQL_SAFE_UPDATES = 0;
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
