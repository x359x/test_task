CREATE TABLE test_task.dbo.SKU (
	ID int NOT NULL,
	Code AS (concat('s', [ID])) NOT NULL,
	Name varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__SKU__3214EC27CE66BBAC PRIMARY KEY (ID),
	CONSTRAINT UQ__SKU__A25C5AA7D6535EC9 UNIQUE (Code)
);

CREATE TABLE test_task.dbo.Basket (
	ID int IDENTITY(1,
1) NOT NULL,
	ID_SKU int NOT NULL,
	ID_family int NOT NULL,
	Quantity int NULL,
	Value int NULL,
	PurchaseDate date DEFAULT getdate() NULL,
	DiscountValue int NULL,
	CONSTRAINT PK__Basket__3214EC2798EFE7E0 PRIMARY KEY (ID)
);

ALTER TABLE test_task.dbo.Basket WITH NOCHECK ADD CONSTRAINT CK__Basket__Quantity__3E52440B CHECK (([Quantity] >=(0)));

ALTER TABLE test_task.dbo.Basket WITH NOCHECK ADD CONSTRAINT CK__Basket__Value__3F466844 CHECK (([Value] >=(0)));

ALTER TABLE test_task.dbo.Basket ADD CONSTRAINT FK__Basket__ID_SKU__3C69FB99 FOREIGN KEY (ID_SKU) REFERENCES test_task.dbo.SKU(ID);

ALTER TABLE test_task.dbo.Basket ADD CONSTRAINT FK__Basket__ID_famil__3D5E1FD2 FOREIGN KEY (ID_family) REFERENCES test_task.dbo.Family(ID);

CREATE TABLE test_task.dbo.Family (
	ID int NOT NULL,
	SurName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BudgetValue decimal(18,
0) NULL,
	CONSTRAINT PK__Family__3214EC27F4B33186 PRIMARY KEY (ID)
);
