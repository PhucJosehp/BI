use master
go

if db_id('DA_STAGE') is not null
	drop database DA_STAGE
go

create database DA_STAGE
go

use DA_STAGE
go

DROP TABLE SupermarketSale_Stage
CREATE TABLE SupermarketSale_Stage(
	InvoiceID		NVARCHAR(255),
	Branch			NVARCHAR(255),
	CustomerID		NVARCHAR(255),
	CustomerType	NVARCHAR(255),
	Gender			NVARCHAR(255),
	ProductID		NVARCHAR(255),
	Quantity		Int,
	Tax				FLOAT(3),
	Total			FLOAT(3),
	Date			DATE,
	Time			TIME,
	Payment			NVARCHAR(255),
	Cogs			FLOAT(2),
	GMP				FLOAT(7),
	GrossIncome		FLOAT(4),
	Rating			FLOAT(1),

	CONSTRAINT PK_SUPERMARKET PRIMARY KEY (InvoiceID),
)

DROP TABLE Product_Stage
CREATE TABLE Product_Stage(
	ProductID		NVARCHAR(255),
	UnitPrice		FLOAT(2),
	ProductLine		NVARCHAR(255),

	CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductID)
)

DROP TABLE ProductLine_Stage
CREATE TABLE ProductLine_Stage(
	ProductLineID	NVARCHAR(255),
	ProductLine		NVARCHAR(255),

	CONSTRAINT PK_PRODUCTLINE PRIMARY KEY (ProductLineID)
)

DROP TABLE City_Stage
CREATE TABLE City_Stage(
	Branch			NVARCHAR(255),
	City			NVARCHAR(255),

	CONSTRAINT PK_CITY PRIMARY KEY (Branch)
)

Select Day('9-Feb-19') as DayOfMount;

SELECT * FROM  SupermarketSale_Stage


SELECT * FROM  Product_Stage
SELECT * FROM  ProductLine_Stage
SELECT * FROM  City_Stage

SELECT DISTINCT MONTH(DATE) FROM  SupermarketSale_Stage WHERE YEAR(DATE) = 2019

SELECT CustomerID, CustomerType, Gender, Quantity, Payment, GrossIncome FROM  SupermarketSale_Stage