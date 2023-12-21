use master
go

if db_id('DA_METADATA') is not null
	drop database DA_METADATA
go

create database DA_METADATA
go

use DA_METADATA
go

USE DA_METADATA;

DROP TABLE DATAFLOW;
CREATE TABLE DATAFLOW(
	ID					INT IDENTITY(1,1),
	NAME				NVARCHAR(30),
	SOURCE				NVARCHAR(50),
	TARGET				NVARCHAR(30),
	TRANSFORMATION		NVARCHAR(100),
	PACKAGE				INT,
	STATUS				INT,
	CET					Datetime,
	LSET				Datetime

	CONSTRAINT PK_METADATA PRIMARY KEY (ID)
);

--Drop table PACKAGE
CREATE TABLE PACKAGE(
	ID					INT IDENTITY(1,1),
	NAME				NVARCHAR(30),
	DESCRIPTION			NVARCHAR(255),
	SCHEDULE			NVARCHAR(255),


	CONSTRAINT PK_METADATA_PACKAGE PRIMARY KEY (ID),
)

CREATE TABLE STATUS(
	ID					INT IDENTITY(1,1),
	NAME				NVARCHAR(30),

	CONSTRAINT PK_METADATA_STATUS PRIMARY KEY (ID),
)

-------------------------------------------------
Insert into DATAFLOW (NAME, SOURCE, TARGET, TRANSFORMATION, PACKAGE, LSET) 
values 
('Stage_SupermarketSale','Excel','SupermarketSale_Stage','Import all data from Excel','1','2023-11-01 08:00:00.000'),
('Stage_Product','Excel','Product_Stage','Import all data from Excel','1','2023-11-01 08:00:00.000'),
('Stage_ProductLine' ,'Excel','ProductLine_Stage','Import all data from Excel','1','2023-11-01 08:00:00.000'),
('Stage_City','Excel','City_Stage','Import all data from Excel','1','2023-11-01 08:00:00.000'),

('Dim_Customer','SupermarketSale_NDS','Dim_Customer','Import all data from NDS','4','2023-11-01 08:00:00.000'),
('Dim_Date','SupermarketSale_NDS','Dim_Date','Import all data from NDS','5','2023-11-01 08:00:00.000'),
('Dim_Product','Product_NDS','Dime_Product','Import all data from NDS','2','2023-11-01 08:00:00.000'),
('Dim_Branch' ,'City_NDS','Dim_Branch','Import all data from NDS','3','2023-11-01 08:00:00.000'),
('Fact_Invoice','SupermarketSale_NDS','Fact_Invoice','Import all data from NDS','6','2023-11-01 08:00:00.000');

-------------------------------------------------
Insert into STATUS (NAME) 
values ('Unknown');
Insert into STATUS (NAME) 
values ('Success');
Insert into STATUS (NAME) 
values ('Failed');
Insert into STATUS (NAME) 
values ('In progress');
-------------------------------------------------
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('Stage Import', 'This is SSIS package extracts the following data from the source system and load it onto the stage','Run when run package');
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('DDS Product', 'This loads ProductLine table from the NDS to the DDS. This merge product and productline table.','Run when run package');
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('DDS City', 'This loads City table from the NDS to the DDS','Run when run package');
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('DDS Customer', 'This extract data from table Supermarket_NDS from the NDS to the DDS and turn into DIM_CUSTOMER','Run when run package');
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('DDS Date', 'This extract data from table Supermarket_NDS from the NDS to the DDS and turn into DATE_CUSTOMER','Run when run package');
Insert into PACKAGE (NAME, DESCRIPTION, SCHEDULE) 
values ('DDS Fact table', 'This extract data from table Supermarket_NDS from the NDS to the DDS and turn into FACT_INVOICE','Run when run package');
------------------------------------------------- 
select * from DATAFLOW Where PACKAGE > 1 and STATUS = 3  
select * from STATUS
select * from PACKAGE

 truncate table STATUS
 truncate table DATAFLOW
 truncate table PACKAGE

 --AUDIT METADATA

--Create Database DA_AUDIT_METADATA

--use DA_AUDIT_METADATA
--go

CREATE TABLE EVENT_TYPE (
	ID INT IDENTITY(1, 1),
	EVENT_TYPE VARCHAR(50)

	CONSTRAINT PK_METATDATA_EVENTTYPE PRIMARY KEY (ID)
)

CREATE TABLE EVENT_CATEGORY (
	ID INT IDENTITY(1, 1),
	EVENT_CATEGORY VARCHAR(50)

	CONSTRAINT PK_METATDATA_EVENTCATEGORY PRIMARY KEY (ID)
)

--Drop table AUDIT,
CREATE TABLE AUDIT (
	ID				INT IDENTITY(1, 1),
	EVENT_TYPE		INT,
	EVENT_CATEGORY	INT,
	OBJECT			INT,
	DATAFLOW		INT,
	ROWS			INT,
	TIMESTAMP		DATETIME,
	NOTE			VARCHAR(200)

	CONSTRAINT PK_METADATA_AUDIT PRIMARY KEY (ID),
)

Insert into EVENT_CATEGORY (EVENT_CATEGORY)
Values 
('Stage ETL'),
('NDS ETL')

Insert into EVENT_TYPE (EVENT_TYPE)
Values 
('Load Stage Supermarket'),
('Load Stage Branch'),
('Load Stage Product'),
('Load Stage ProductLine'),
('Load Dim Branch'),
('Load Dim Customer'),
('Load Dim Product'),
('Load Dim Date'),
('Load Fact Invoice')

Insert into AUDIT (EVENT_TYPE, EVENT_CATEGORY, [OBJECT], DATAFLOW)
Values
(1,1,1,1),
(2,1,2,4),
(3,1,3,2),
(4,1,4,3),
(5,2,5,8),
(6,2,6,5),
(7,2,7,7),
(8,2,8,6),
(9,2,9,9)

SELECT * FROM EVENT_CATEGORY
SELECT * FROM EVENT_TYPE
SELECT * FROM [AUDIT] --WHERE EVENT_CATEGORY = 1

Update AUDIT SET ROWS = 1, TIMESTAMP = GETDATE() WHERE EVENT_TYPE =  3

--Structure metadata

CREATE TABLE DS_DATA_STORE(
	[KEY]			INT IDENTITY(1,1) PRIMARY KEY,
	DATA_STORE		NVARCHAR(10),
	[DESCRIPTION]	NVARCHAR(30),
	COLLATION		NVARCHAR(50),
	CURRENT_SIZE	INT,
	GROWTH			INT,
)


CREATE TABLE DS_TABLE(
	[KEY]			INT IDENTITY(1,1) PRIMARY KEY,
	[NAME]			NVARCHAR(30),
	ENTITY_TYPE		INT,
	DATA_STORE		INT,
	[DESCRIPTION]	NVARCHAR(255),
)

CREATE TABLE DS_TABLE_TYPE(
	[KEY]			INT IDENTITY(1,1) PRIMARY KEY,
	TABLE_TYPE		NVARCHAR(20),
	[DESCRIPTION]	NVARCHAR(30),
)

INSERT INTO DS_DATA_STORE (DATA_STORE,[DESCRIPTION],COLLATION,CURRENT_SIZE,GROWTH)
VALUES ('Stage','Staging area','SQL_Latin1_General_CP1_CI_AS',100,20),
	   ('NDS','Normalized data store','SQL_Latin1_General_CP1_CI_AS',150,25),
	   ('DDS','Dimensional data store','SQL_Latin1_General_CP1_CI_AS',175,25),
	   ('Meta','Metadata','SQL_Latin1_General_CP1_CI_AS',10,5)

INSERT INTO DS_TABLE_TYPE (TABLE_TYPE,[DESCRIPTION])
VALUES	('dimension','Dimension table'),
		('fact','Fact table'),
		('stage','Stage table'),
		('metadata','Metadata table'),
		('master','Master table'),
		('transaction','Transaction table')

INSERT INTO DS_TABLE ([NAME],ENTITY_TYPE,DATA_STORE,[DESCRIPTION])
VALUES	('Stage SupermarketSales',3,1,'Load data from source excel and save as table stage'),
		('Stage Branch',3,1,'Load data from source excel and save as table stage'),
		('Stage Product',3,1,'Load data from source excel and save as table stage'),
		('Stage Productline',3,1,'Load data from source excel and save as table stage'),
		('Dim Branch',1,3,'Load data from NDS Branch to Dim Branch. A Branch will have present the city where customer live.'),
		('Dim Customer',1,3,'Load data from NDS Customer to Dim Customer. A customer is an individual that purchased a product.'),
		('Dim Product',1,3,'Load data from Dim Product and ProductLine. A product include ID, single price(unit price) and productline.'),
		('Dim Date',1,3,'Load data from Dim Supermarket and only take day, month, year and time.A Date is present a day with specifically time.'),
		('Fact Invoice',1,2,'Load data Dim Supermarket except day, month, year and time. It contains purchase infor of each customer.'),
		('DATAFLOW',4,4,'Main table to store data flow. It contains some value that describes a data flow like what table, how many rows import and when it runs.')


select * from DS_TABLE_TYPE
select * from DS_DATA_STORE
select * from DS_TABLE