use master
go

if db_id('DA_NDS') is not null
	drop database DA_NDS
go

create database DA_NDS
go

use DA_NDS
go;
 
--------------------------------------------------------------------------

--DROP TABLE SupermarketSale_NDS
CREATE TABLE SupermarketSale_NDS(
	InvoiceID_SK	INT IDENTITY(1,1),
	InvoiceID_NK	NVARCHAR(255),
	CustomerID		NVARCHAR(255),
	SOR				INT,
	Branch			NVARCHAR(255),
	ProductID		NVARCHAR(255),
	Tax				FLOAT(3),
	Total			FLOAT(3),
	Quantity		INT,
	Day				INT,
	Month			INT,
	Year			INT,
	Time			TIME,
	Cogs			FLOAT(2),
	GMP				FLOAT(7),
	Rating			FLOAT(1),
	createdDate		Datetime,
	updateDate		Datetime,

	CONSTRAINT PK_SUPERMARKET PRIMARY KEY (InvoiceID_SK),
)

ALTER TABLE SupermarketSale_NDS
ADD CONSTRAINT FK_SPMK_PRODUCT
FOREIGN KEY (ProductID)
REFERENCES Product_NDS(ProductID_NK)

ALTER TABLE SupermarketSale_NDS
ADD CONSTRAINT FK_SPMK_BRANCH
FOREIGN KEY (Branch)
REFERENCES City_NDS(Branch_NK)

ALTER TABLE SupermarketSale_NDS
ADD CONSTRAINT FK_SPMK_Customer
FOREIGN KEY (CustomerID)
REFERENCES Customer_NDS(CustomerID_NK)

ALTER TABLE SupermarketSale_NDS
ADD CONSTRAINT FK_SPMK_SOURCE
FOREIGN KEY (SOR)
REFERENCES SOURCETABLE(ID)

--------------------------------------------------------------------------
--DROP TABLE Customer_NDS
CREATE TABLE Customer_NDS(
	CustomerID_SK	INT PRIMARY KEY IDENTITY(1,1),
	CustomerID_NK	NVARCHAR(255) not null unique,
	SOR				INT,
	CustomerType	NVARCHAR(255),
	Gender			NVARCHAR(255),
	Payment			NVARCHAR(255),
	GrossIncome		FLOAT(4),
	createdDate		Datetime,
	updateDate		Datetime,
)


--------------------------------------------------------------------------

--DROP TABLE Product_NDS
CREATE TABLE Product_NDS(
	ProductID_SK	INT IDENTITY(1,1),
	ProductID_NK	NVARCHAR(255) NOT NULL UNIQUE,
	SOR				INT,
	UnitPrice		FLOAT(2),
	ProductLine		NVARCHAR(255),
	createdDate		Datetime,
	updateDate		Datetime,

	CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductID_SK)
)

ALTER TABLE Product_NDS
ADD CONSTRAINT FK_PRODUCT_PRODUCTLINE
FOREIGN KEY (ProductLine)
REFERENCES ProductLine_NDS(ProductLineID_NK)

ALTER TABLE Product_NDS
ADD CONSTRAINT FK_PRODUCT_SOURCE
FOREIGN KEY (SOR)
REFERENCES SOURCETABLE(ID)

--------------------------------------------------------------------------

--DROP TABLE ProductLine_NDS
CREATE TABLE ProductLine_NDS(
	ProductLineID_SK	INT IDENTITY(1,1),
	ProductLineID_NK	NVARCHAR(255) NOT NULL UNIQUE,
	SOR					INT,
	ProductLine			NVARCHAR(255),
	createdDate			Datetime,
	updateDate			Datetime,

	CONSTRAINT PK_PRODUCTLINE PRIMARY KEY (ProductLineID_SK)
)

ALTER TABLE ProductLine_NDS
ADD CONSTRAINT FK_PRODUCTLINE_SOURCE
FOREIGN KEY (SOR)
REFERENCES SOURCETABLE(ID)


--------------------------------------------------------------------------

--DROP TABLE City_NDS
CREATE TABLE City_NDS(
	Branch_SK		INT IDENTITY(1,1),
	Branch_NK		NVARCHAR(255) NOT NULL UNIQUE,
	SOR				INT,
	City			NVARCHAR(255),
	createdDate		Datetime,
	updateDate		Datetime,
		
	CONSTRAINT PK_CITY PRIMARY KEY (Branch_SK)
)

ALTER TABLE City_NDS
ADD CONSTRAINT FK_City_SOURCE
FOREIGN KEY (SOR)
REFERENCES SOURCETABLE(ID)

--------------------------------------------------------------------------

CREATE TABLE SOURCETABLE(
	ID			INT IDENTITY(1,1),
	SOURCENAME	CHAR(10),

	CONSTRAINT PK_SRTB PRIMARY KEY (ID)
)

INSERT INTO SOURCETABLE (SOURCENAME)
VALUES ('Excel')

--select * from sys.tables

SELECT * FROM City_NDS --JOIN SOURCETABLE ON SOR = ID
SELECT * FROM ProductLine_NDS
SELECT * FROM Product_NDS 
SELECT * FROM SupermarketSale_NDS --Where [Year] = 2019

--update SupermarketSale_NDS set time = '11:36:00.0000000' where day = 1 and Month = 1 and year = 2019 and time = '10:39:00.0000000'

SELECT * FROM Customer_NDS
--UPDATE City_NDS SET updateDate = GETDATE() where Branch_NK = 'A'


truncate table  City_NDS 
truncate table  ProductLine_NDS
truncate table  Product_NDS 
truncate table  SupermarketSale_NDS



UPDATE SupermarketSale_NDS
Set Branch = ?,
	ProductID = ?,
	Tax = ?,
	Total = ?,
	Day = ?,
	Month = ?,
	YEAR = ?,
	Time = ?,
	Cogs = ?,
	GMP = ?,
	Rating = ?,
	updateDate = ?
Where InvoiceID_NK = ?

UPDATE Customer_NDS
Set CustomerType = ?,
	Gender = ? ,
	Quantity = ?,
	Payment = ?,
	GrossIncome = ?,
	updateDate = ?
Where CustomerID_NK = ?

SELECT        *
FROM          Product_NDS
WHERE        (createdDate>= '2023-12-01 00:00:00.000' AND createdDate< '2023-12-01 08:41:50.717') OR
              (updateDate>= '2023-12-01 00:00:00.000' AND updateDate< '2023-12-01 08:41:50.717')


select getdate()