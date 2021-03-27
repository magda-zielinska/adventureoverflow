CREATE TABLE IF NOT EXISTS sales.DimDate (
    DateKey integer PRIMARY KEY,
    FullDateAlternateKey date,
    EnglishDayNameOfWeek varchar,
    EnglishMonthName varchar,
	FiscalQuarter smallint,
	FiscalYear smallint,
	FiscalSemester smallint
);

CREATE TABLE IF NOT EXISTS sales.DimSalesTerritory (
    SalesTerritoryKey integer PRIMARY KEY,
	SalesTerritoryRegion varchar,
	SalesTerritoryCountry varchar,
	SalesTerritoryGroup varchar
);

CREATE TABLE IF NOT EXISTS sales.DimDateHoliday (
	DateHolidayKey serial PRIMARY KEY,
    DateKey integer,
	TerritoryCode char(2),
	HolidayFlag boolean,
	HolidayName varchar,
	FOREIGN KEY (DateKey) REFERENCES sales.DimDate(DateKey)
);

CREATE TABLE IF NOT EXISTS sales.DimCustomer (
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

CREATE TABLE IF NOT EXISTS sales.FactInternetSales (
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
	
	
CREATE TABLE IF NOT EXISTS sales.FactPosts (
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
	

