drop database if exists TestExam;
create database if not exists TestExam;

use TestExam; 
drop table if exists Customer;
create table if not exists Customer
(
	CustomerID mediumint primary key auto_increment not null,
    `Name` varchar(50),
	Phone int,
    Email varchar(50) unique,
    Address varchar(100),
    Note varchar(100)


);

drop table if exists Car;
create table if not exists Car
(
	CarID mediumint primary key auto_increment not null,
    Maker enum('HONDA','TOYOTA','NISSAN'),
    Model varchar(50),
    `Year` year,
    Color enum('Black','White','Yellow','Pink'),
    Note varchar(100)

);

drop table if exists CarOder;
create table if not exists CarOder
(
	OderID mediumint primary key auto_increment not null,
    CustomerID mediumint,
    CarID mediumint,
    Amount double default  1,
    SalePrice double,
    OderDate datetime,
    DeliveryDate datetime,
    DeliveryAddress varchar(100),
    `Status` enum ('0','1','2') default null  ,
    Note varchar(100),


constraint fk_ctm_id foreign key (CustomerID) references Customer(CustomerID) on delete set null on update cascade,
constraint fk_c_id foreign key (CarID) references Car(CarID) on delete set null on update cascade

);


-- Question
-- a)
insert into Customer
value (1,'Đỗ Anh Dũng',0936187872,'anhdung@gmail.com','Thanh Oai','Lười'),
		(2,'Bùi Đức Toàn',0967891234,'ductoan@gmail.com','Thanh Lương','Đã có vợ con'),
        (3,'Lê Đăng Hoàng',0336123654,'danghoang@gmail.com','Cao Viên','Siêu trắng sáng'),
        (4,'Lê Đặng Sao Mai',0986686868,'meoengland@gmail.com','Chương Mỹ','Giỏi Tiếng Anh'),
        (5,'Không Biết Thêm Gì',0986456789,'caigicungbiet@gmail.com','Sao Hoả','Khác người');
        
insert into Car
value
(1,'HONDA','DreamX',2017,'Black','Nhẹ'),
(2,'TOYOTA','Exciter',2018,'White','Vừa'),
(3,'NISSAN','Ethat',2019,'Yellow','Nặng'),
(4,'HONDA','DreamX',2016,'White','Dễ Bẩn'),
(5,'TOYOTA','Winner',2020,'Black','Đẹp');


insert into CarOder
value
(1,1,1,1,20000000,'2019-06-09','2019-06-12','Thanh Oai','0','odered'),
(2,2,2,1,50000000,'2018-07-20','2018-07-23','Thanh Lương','1','delivered'),
(3,1,3,1,100000000,'2020-01-02','2020-01-06','Thanh Oai','2','canceled'),
(4,4,4,1,22000000,'2017-02-07','2017-02-10','Chương Mỹ','0','odered'),
(5,5,5,1,47000000,'2020-05-23','2020-06-14','Sao Hoả','2','canceled');
        

-- b)Write SQL script to list out information (Customer’s name, number of cars that customer bought) and sort ascending by number of cars.


 select cu.`Name` as 'Tên Khách Hàng' , count(cod.CustomerID) as 'Số order', sum(cod.Amount)
 from Customer cu join caroder cod on cu.CustomerID = cod.CustomerID
 where cod.`Status` != '2'
 group by cod.CustomerID
 order by sum(cod.Amount) asc;





        