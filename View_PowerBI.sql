USE RetailToyStore_DB;
GO

-- 1. Bảng Chi tiết Bán hàng (Fact Sales)
CREATE VIEW vw_Fact_Sales AS
SELECT Sale_ID, Date, Store_ID, Product_ID, Units
FROM Clean_Sales
GO

-- 2. Bảng Chi tiết Tồn kho (Fact Inventory)
CREATE VIEW vw_Fact_Inventory AS
SELECT Store_ID, Product_ID, Stock_On_Hand
FROM Clean_Inventory
GO

-- 3. Bảng Danh mục Sản phẩm (Dim Products)
CREATE VIEW vw_Dim_Products AS
SELECT Product_ID, Product_Name, Product_Category, Product_Cost, Product_Price
FROM Clean_Products
GO

-- 4. Bảng Danh mục Cửa hàng (Dim Stores)
CREATE VIEW vw_Dim_Stores AS
SELECT Store_ID, Store_Name, Store_City, Store_Location, Store_Open_Date
FROM Clean_Stores
GO

-- 5. Bảng Trục Thời gian (Dim Date)
CREATE VIEW vw_Dim_Date AS
SELECT Date,Day_of_Week, Day, Month,Quarter, Year
FROM Dim_Date
GO