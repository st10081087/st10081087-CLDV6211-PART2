USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'KhumaloCraftDB')
BEGIN
    ALTER DATABASE KhumaloCraftDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE KhumaloCraftDB;
END
GO

CREATE DATABASE KhumaloCraftDB;
GO

USE KhumaloCraftDB;
GO

IF OBJECT_ID('Transactions', 'U') IS NOT NULL
BEGIN
    ALTER TABLE Transactions DROP CONSTRAINT FK_Transactions_UserID;
    ALTER TABLE Transactions DROP CONSTRAINT FK_Transactions_ProductID;
END
GO

IF OBJECT_ID('Users', 'U') IS NOT NULL
BEGIN
    DROP TABLE Users;
END
GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL
);
GO

IF OBJECT_ID('Products', 'U') IS NOT NULL
BEGIN
    DROP TABLE Products;
END
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Category NVARCHAR(50),
    Availability BIT NOT NULL,
    ArtistID INT FOREIGN KEY REFERENCES Users(UserID)
);
GO

IF OBJECT_ID('Transactions', 'U') IS NOT NULL
BEGIN
    DROP TABLE Transactions;
END
GO

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Users (Name, Email, Password) VALUES 
('Alex Thompson', 'alex.thompson@example.com', 'password123'),
('Leila Patel', 'leila.patel@example.com', 'password123'),
('Karen White', 'karen.white@example.com', 'password123'),
('Priya Patel', 'priya.patel@example.com', 'password123'),
('John Chen', 'john.chen@example.com', 'password123'),
('Nomvula Khumalo', 'nomvula.khumalo@example.com', 'password123'),
('James Anderson', 'james.anderson@example.com', 'password123'),
('Maria Rodriguez', 'maria.rodriguez@example.com', 'password123');
GO

INSERT INTO Products (Name, Price, Category, Availability, ArtistID) VALUES 
('Chromatic Fusion - Stained Glass Plate', 1350.00, 'Decor', 1, 2),
('Clay Bird Companion', 1500.00, 'Decor', 1, 3),
('Blue Blossoms - Vase', 1800.00, 'Decor', 1, 4),
('Divine Harmony - Oil Painting', 8500.00, 'Art', 1, 5),
('Eternal Beauty - Oil Painting', 1000.00, 'Art', 1, 6),
('African Dream - Painting', 1200.00, 'Art', 1, 7),
('Serene Reflections - Acrylic Painting', 900.00, 'Art', 1, 8),
('Sunflower Dreams - Hand-Painted Ceramic Vase', 950.00, 'Decor', 1, 8);
GO

INSERT INTO Transactions (UserID, ProductID, Quantity, TotalPrice) VALUES 
(1, 1, 1, 1350.00),
(2, 2, 1, 1500.00),
(3, 3, 2, 3600.00),
(4, 4, 1, 8500.00),
(5, 5, 1, 1000.00),
(6, 6, 1, 1200.00),
(7, 7, 1, 900.00),
(8, 8, 1, 950.00);
GO

SELECT * FROM Users;
GO

SELECT * FROM Products;
GO

SELECT * FROM Transactions;
GO


SELECT * FROM Users;
GO

SELECT * FROM Products;
GO

SELECT * FROM Transactions;
GO

