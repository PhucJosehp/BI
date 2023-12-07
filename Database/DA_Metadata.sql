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
select ID, NAME, CET from DATAFLOW Where STATUS = 3
select * from STATUS
select * from PACKAGE

 truncate table STATUS
 truncate table DATAFLOW
 truncate table PACKAGE