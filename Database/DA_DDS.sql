CREATE DATABASE DA_DDS;
USE DA_DDS;

Drop table DIM_BRANCH
CREATE TABLE DIM_BRANCH(
	Branch		nvarchar(255) PRIMARY KEY,
	City		nvarchar(255)
)

Drop table DIM_PRODUCT
CREATE TABLE DIM_PRODUCT(
	Product_ID	nvarchar(255) PRIMARY KEY,
	UnitPrice	FLOAT(2),
	ProductLine	NVARCHAR(255),
)

Drop table DIM_DATE
CREATE TABLE DIM_DATE(
	Date_id INT PRIMARY KEY IDENTITY(1,1),
	[Hour]	TIME,
	[Day]	INT,
	[Month]	INT,
	[Year]	INT,
)

Drop table DIM_CUSTOMER
CREATE TABLE DIM_CUSTOMER(
	Customer_id		Nvarchar(255) Primary key,
	[Type]			Nvarchar(255),
	Gender			Nvarchar(255),
	Payment			Nvarchar(255),
	GrossIncome		FLOAT(4),
)

Drop table FACT_INVOICE
CREATE TABLE FACT_INVOICE(
	Invoice_id		nvarchar(255),
	Customer_id		nvarchar(255),
	Product_id		nvarchar(255),
	Date_id			INT,
	Branch_id		nvarchar(255),
	Cogs			FLOAT(2),
	Total			FLOAT(3),
	Rating			FLOAT(1),

	CONSTRAINT PK_FACT PRIMARY KEY (Invoice_id, Customer_id, Product_id, Date_id, Branch_id)
)

ALTER TABLE FACT_INVOICE
ADD CONSTRAINT FK_FACT_BRANCH
FOREIGN KEY (Branch_id)
REFERENCES DIM_BRANCH(Branch)

ALTER TABLE FACT_INVOICE
ADD CONSTRAINT FK_FACT_DATE
FOREIGN KEY (Date_id)
REFERENCES DIM_DATE(Date_id)

ALTER TABLE FACT_INVOICE
ADD CONSTRAINT FK_FACT_PRODUCT
FOREIGN KEY (Product_id)
REFERENCES DIM_PRODUCT(Product_ID)

ALTER TABLE FACT_INVOICE
ADD CONSTRAINT FK_FACT_CUSTOMER
FOREIGN KEY (Customer_id)
REFERENCES DIM_CUSTOMER(Customer_id)


DROP TABLE  DIM_DATE;

select * from FACT_INVOICE where Invoice_id = '873-95-4984' or Invoice_id = '400-80-4065'

select * from DIM_PRODUCT
select * from DIM_CUSTOMER
select * from DIM_BRANCH
select * from DIM_DATE