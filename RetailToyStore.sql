use RetailToyStore_DB
go

 --Câu hỏi 1: Nhóm đồ chơi nào đang đứng đầu bảng về tổng lợi nhuận? 
 select p.Product_Category,
 round(sum(s.Units * p.Product_Price),2) as Revenue,
 round(sum(s.Units * (p.Product_Price - p.Product_Cost)),2) as Profit
 from Clean_Sales s
 inner join Clean_Products p on s.Product_ID = p.Product_ID
 group by p.Product_Category
 order by Profit desc 

 --Câu hỏi 2: Doanh thu của hệ thống biến động như thế nào qua từng tháng?
 select d.Month, d.Year,
 round(sum(s.Units * p.Product_Price),2) as Revenue
 from Clean_Sales s
 inner join Clean_Products p on s.Product_ID = p.Product_ID
 inner join Dim_Date d on s.Date = d.Date
 group by d.Month, d.Year
 order by d.Year asc, d.Month asc
 
 --Câu hỏi 3: phân hạng các cửa hàng dựa trên tổng doanh thu
 --Tạo bảng tạm chứa tổng doanh thu từng cửa hàng
 with StoreRevenue as (
 select st.Store_ID, st.Store_Name,
 round(sum(s.Units *p.Product_Price),2) as Revenue
 from Clean_Sales s
 inner join Clean_Products p on s.Product_ID = p.Product_ID
 inner join Clean_Stores st on s.Store_ID = st.Store_ID
 group by st.Store_ID, st.Store_Name
 )
 --phân hạng
 select Store_ID, Store_Name, Revenue,
 case 
	when Revenue >400000 then 'Tier 1'
	when Revenue >= 220000 then 'Tier 2'
 else 'Tier 3 (Needs Improvement)'
 end as Store_Segment
 from StoreRevenue
 order by Revenue desc
 
 --Câu hỏi 4: danh sách các Giao dịch (Sales) nơi khách hàng mua số lượng (Units) trong một đơn hàng lớn hơn mức trung bình của toàn bộ hệ thống.
 select s.Sale_ID, p.Product_Name, s.Units, s.Date
 from Clean_Sales s
 inner join Clean_Products p on s.Product_ID = p.Product_ID
 where s.Units > (select AVG(Units) from Clean_Sales)
 order by s.Units desc
 
 --Câu hỏi 5: Sản phẩm nào đang có nguy cơ cạn kiệt kho cao nhất dựa trên tốc độ bán hàng
 -- Tính Tổng Tồn Kho
WITH ProductStock AS (
    SELECT Product_ID, SUM(Stock_On_Hand) AS Total_Stock
    FROM Clean_Inventory
    GROUP BY Product_ID
),
-- Tính Tổng Đã Bán
Sales_Summary AS (
    SELECT Product_ID, SUM(Units) AS Total_Sold
    FROM Clean_Sales
    GROUP BY Product_ID
)
-- Tính Tỷ lệ Cảnh báo
SELECT 
    p.Product_Name,
    i.Total_Stock,
    s.Total_Sold,
    ROUND((i.Total_Stock * 1.0 / s.Total_Sold) * 100, 2) AS Stock_To_Sales_Ratio_Percent
FROM Clean_Products p
INNER JOIN ProductStock i ON p.Product_ID = i.Product_ID
INNER JOIN Sales_Summary s ON p.Product_ID = s.Product_ID
ORDER BY Stock_To_Sales_Ratio_Percent ASC

-- Câu hỏi 6: Top 3 sản phẩm lợi nhuận cao nhất bên trong từng nhóm đồ chơi
-- Tính lợi nhuận và cấp số thứ tự (Rank) cho từng sản phẩm trong nội bộ nhóm
WITH ProductProfitability AS (
    SELECT 
        p.Product_Category,
        p.Product_Name,
        ROUND(SUM(s.Units * (p.Product_Price - p.Product_Cost)), 2) AS Total_Profit,
        ROW_NUMBER() OVER(PARTITION BY p.Product_Category ORDER BY SUM(s.Units * (p.Product_Price - p.Product_Cost)) DESC) AS Rank_In_Category
    FROM Clean_Sales s
    INNER JOIN Clean_Products p ON s.Product_ID = p.Product_ID
    GROUP BY p.Product_Category, p.Product_Name
)
-- Truy xuất từ bảng tạm, chỉ lấy những món có hạng 1, 2, 3
SELECT * FROM ProductProfitability
WHERE Rank_In_Category <= 3

-- Câu hỏi 7: Phân tích Doanh thu theo loại hình vị trí và thành phố
SELECT 
    st.Store_Location , st.Store_City,
    ROUND(SUM(s.Units * p.Product_Price), 2) AS Total_Revenue
FROM Clean_Sales s
INNER JOIN Clean_Products p ON s.Product_ID = p.Product_ID
INNER JOIN Clean_Stores st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_Location, st.Store_City
ORDER BY Total_Revenue DESC