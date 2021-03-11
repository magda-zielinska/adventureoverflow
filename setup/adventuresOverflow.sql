CREATE USER joyful_alligator WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;
  

CREATE DATABASE adventuresOverflow
    WITH
    OWNER = joyful_alligator
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
	TEMPLATE template0;
	

CREATE SCHEMA sales;


CREATE TABLE sales.DimDate (
    DateKey integer PRIMARY KEY,
    FullDateAlternateKey date,
    EnglishDayNameOfWeek varchar,
    EnglishMonthName varchar,
	FiscalQuarter smallint,
	FiscalYear smallint,
	FiscalSemester smallint
);

CREATE TABLE sales.DimSalesTerritory (
    SalesTerritoryKey integer PRIMARY KEY,
	SalesTerritoryRegion varchar,
	SalesTerritoryCountry varchar,
	SalesTerritoryGroup varchar
);

CREATE TABLE sales.DimDateHoliday (
	DateHolidayKey serial PRIMARY KEY,
    DateKey integer,
	TerritoryCode char(2),
	HolidayFlag boolean,
	HolidayName varchar,
	FOREIGN KEY (DateKey) REFERENCES sales.DimDate(DateKey)
);

CREATE TABLE sales.DimCustomer (
    CustomerKey integer PRIMARY KEY,
    GeographyKey date,
    FirstName varchar,
    LastName varchar,
	BirthDate date,
	MaritalStatus char,
	Gender varchar,
	EmailAddress varchar,
	YearlyIncome money,
	EnglishEducation varchar,
	DateFirstPurchase date,
	SalesTerritoryKey integer,
	City varchar,
	FOREIGN KEY (SalesTerritoryKey) REFERENCES sales.DimSalesTerritory(SalesTerritoryKey)
);

CREATE TABLE sales.FactInternetSales (
	OrderSalesNumber integer PRIMARY KEY,
    ProductKey integer,
    OrderDateKey integer,
    DueDateKey integer,
    ShipDateKey integer,
    CustomerKey integer,
    SalesTerritoryKey integer,
    OrderQuantity smallint,
    UnitPrice money,
	DiscountAmount decimal(3,2),
	SalesAmount money,
	OrderDate timestamp,
	DueDate timestamp,
	ShipDate timestamp,
	FOREIGN KEY (OrderDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (DueDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (ShipDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (CustomerKey) REFERENCES sales.DimCustomer(CustomerKey),
	FOREIGN KEY (SalesTerritoryKey) REFERENCES sales.DimSalesTerritory(SalesTerritoryKey)
	);
	
	
CREATE TABLE sales.FactPosts (
	PostKey integer PRIMARY KEY,
    AnswerCount integer,
    Body varchar,
    ClosedDate timestamp,
    CommentCount integer,
    CreationDate timestamp,
    FavoriteCount integer,
    LastActivityDate timestamp,
    LastEditDate timestamp,
	Score integer,
	Title varchar,
	ViewCount integer,
	ClosedDateKey integer,
	CreationDateKey integer,
	LastActivityDateKey integer,
	LastEditDateKey integer,
	FOREIGN KEY (ClosedDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (CreationDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (LastActivityDateKey) REFERENCES sales.DimDate(DateKey),
	FOREIGN KEY (LastEditDateKey) REFERENCES sales.DimDate(DateKey)
	);
	

