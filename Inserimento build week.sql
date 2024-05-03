create database vendicose_database;
use vendicose_database;

-- creaiamo tabelle
CREATE TABLE Shop (
    ShopID INT PRIMARY KEY,
    ShopName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    NameProduct VARCHAR(100),
    CategoryID INT
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE PurchaseOrder (
    OrderID INT PRIMARY KEY,
    Date DATE,
    FK2_ShopID INT
);

CREATE TABLE OrderRow (
    OrderRowID INT,
	OrderID INT,
    FK1_ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, OrderRowID)
);

CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    FK1_ShopID INT,
    FK3_ProductID INT,
    Quantity INT,
    RestockLevel INT
);

CREATE TABLE Sales (
    SalesID INT auto_increment PRIMARY KEY,
    Date DATE,
    StockID INT,
    Amount DECIMAL(10, 2)
);

CREATE TABLE SalesRow (
    SalesID INT,
    SalesRowID INT ,
    FK2_ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    PRIMARY KEY (SalesID, SalesRowID)
);

-- inseriamo foreign key
ALTER TABLE Product
ADD CONSTRAINT CategoryID
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID);

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK2_ShopID
FOREIGN KEY (FK2_ShopID) REFERENCES Shop(ShopID);

ALTER TABLE OrderRow
ADD CONSTRAINT OrderID
FOREIGN KEY (OrderID) REFERENCES PurchaseOrder(OrderID);

ALTER TABLE OrderRow
ADD CONSTRAINT FK1_ProductID
FOREIGN KEY (FK1_ProductID) REFERENCES Product(ProductID);

ALTER TABLE Stock
ADD CONSTRAINT FK1_ShopID
FOREIGN KEY (FK1_ShopID) REFERENCES Shop(ShopID);

ALTER TABLE Stock
ADD CONSTRAINT FK3_ProductID
FOREIGN KEY (FK3_ProductID) REFERENCES Product(ProductID);

ALTER TABLE Sales
ADD CONSTRAINT StockID
FOREIGN KEY (StockID) REFERENCES Stock(StockID);

ALTER TABLE SalesRow
ADD CONSTRAINT SalesID
FOREIGN KEY (SalesID) REFERENCES Sales(SalesID);

ALTER TABLE SalesRow
ADD CONSTRAINT FK2_ProductID
FOREIGN KEY (FK2_ProductID) REFERENCES Product(ProductID);

-- popoliamo le tabelle

-- Popolamento della tabella Shop
INSERT INTO Shop (ShopID, ShopName, City) VALUES
(1, 'Elettronica Plus', 'Milano'),
(2, 'Abbigliamento Trendy', 'Roma'),
(3, 'Libreria Cultura', 'Firenze');

-- Popolamento della tabella Category
INSERT INTO Category (CategoryID, CategoryName) VALUES
(1, 'Elettronica'),
(2, 'Abbigliamento'),
(3, 'Libri');

-- Popolamento della tabella Product
INSERT INTO Product (ProductID, NameProduct, CategoryID) VALUES
(1, 'Smartphone X', 1),
(2, 'Laptop Y', 1),
(3, 'Maglietta Casual', 2),
(4, 'Pantaloni Jeans', 2),
(5, 'Romanzo Giallo', 3),
(6, 'Manuale di Programmazione', 3);

-- Popolamento della tabella PurchaseOrder
INSERT INTO PurchaseOrder (OrderID, Date, FK2_ShopID) VALUES
(1, '2024-04-30', 1),
(2, '2024-05-01', 2),
(3, '2024-05-02', 3);

-- Popolamento della tabella OrderRow
INSERT INTO OrderRow (OrderRowID, OrderID, FK1_ProductID, Quantity) VALUES
(1, 1, 1, 2),
(2, 1, 3, 3),
(3, 2, 2, 1),
(4, 3, 5, 1),
(5, 3, 6, 2);

-- Popolamento della tabella Stock
INSERT INTO Stock (StockID, FK1_ShopID, FK3_ProductID, Quantity, RestockLevel) VALUES
(1, 1, 1, 50, 10),
(2, 2, 2, 30, 5),
(3, 3, 3, 20, 8),
(4, 1, 4, 40, 15),
(5, 2, 5, 25, 7),
(6, 3, 6, 15, 6);
INSERT INTO Stock (StockID, FK1_ShopID, FK3_ProductID, Quantity, RestockLevel) VALUES ( 7, 1, 1, 45, 10);

-- Popolamento della tabella Sales
INSERT INTO Sales (Date, StockID, Amount) VALUES
( '2024-05-01', 1, 1500.00),
( '2024-05-02', 2, 2000.00),
( '2024-05-02', 3, 500.00);

-- Popolamento della tabella SalesRow
INSERT INTO SalesRow (SalesID, SalesRowID, FK2_ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 1, 1000.00),
(1, 2, 3, 2, 250.00),
(2, 1, 2, 1, 2000.00),
(3, 1, 5, 1, 300.00),
(3, 2, 6, 1, 200.00);
