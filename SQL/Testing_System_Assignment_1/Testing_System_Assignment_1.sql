drop database if exists Testing_System_Assignment_1;
create database if not exists Testing_System_Assignment_1;
use Testing_System_Assignment_1;
drop table if exists `Department`;

create table if not exists `Department`
(
	`DepartmentID`	 	tinyint primary key auto_increment ,
    `DepartmentName`	varchar(50) 
);

drop table if exists `Position`;
create table if not exists  `Position`
(
	`PositionID`		tinyint  auto_increment ,
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
    `CreateDate` 		datetime
    
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
        `JoinDate`		datetime
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
    `CategoryName`	 enum('Java','.NET','SQL','Postman','Ruby','C#','Python','HTML')
);
    
drop table if exists `Question`;
create table if not exists `Question`
(
	`QuestionID`	 tinyint primary key auto_increment not null,
    `Content`		 varchar(50),
    `CategoryID`	 tinyint,
    `TypeID`		 tinyint,
    `CreatorID`		 mediumint,
    `CreateDate`	 datetime
);

drop table if exists `Answer`;
create table if not exists `Answer`
(
	`AnswerID`		tinyint primary key auto_increment not null,
    `Content`		varchar(50),
    `QuestionID`	tinyint,
    `isCorrect`		bit
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
    `CreateDate`	datetime
);

drop table if exists `ExamQuestion`;
create table if not exists `ExamQuestion`
(
    `ExamID`     TINYINT ,
    `QuestionID` TINYINT
);
 
 

 
    
    

