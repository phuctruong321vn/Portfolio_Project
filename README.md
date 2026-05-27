#  Retail Toy Store 
## 1. Luồng Dự án (Project Workflow)
* **Python (Data Cleaning & EDA):** Sử dụng `RetailToyStore.ipynb` để đồng bộ chuẩn hóa kiểu dữ liệu và thực hiện EDA nhằm nắm bắt các phân phối, xu hướng cơ bản của tập dữ liệu.
* **SQL (Core Analysis):** Trả lời trực diện 7 câu hỏi kinh doanh cốt lõi bằng `RetailToyStore.sql`. Đóng gói các logic truy vấn thành các View sạch thông qua `View_PowerBI.sql` để kết nối với Power BI.
* **Power BI (Data Visualization):** Tổ chức mô hình Star Schema, xây dựng DAX Measures và thiết kế  Dashboard.

## 2. Bài toán Kinh doanh (Business Problem)
Dự án hướng tới việc tối ưu hóa doanh thu và thúc đẩy tăng trưởng cho chuỗi 50 cửa hàng đồ chơi tại Mexico, tập trung vào 3 mục tiêu chiến lược:

1. **Tối ưu hóa Mô hình Mặt bằng:** Đánh giá hiệu suất kinh doanh theo vị trí địa lý nhằm xác định mô hình mặt bằng (Sân bay, Trung tâm, Thương mại...) mang lại tỷ suất doanh thu cao nhất để nhân rộng.
2. **Khai thác Danh mục Sản phẩm Chủ lực :** Nhận diện các nhóm hàng đóng góp doanh thu/lợi nhuận chính (Top 3 Revenue) để tối ưu hóa không gian trưng bày và kệ hàng.
3. **Quản trị Rủi ro Chuỗi cung ứng :** Dự báo sớm xu hướng mùa vụ và rủi ro cạn kho để duy trì đà tăng trưởng bền vững.
## 3. Tổng quan Bảng điều khiển
<img width="833" height="475" alt="{DB7F9011-1B87-4756-BF30-07320E3F41E8}" src="https://github.com/user-attachments/assets/c2e1df04-6b4f-43c5-96f1-0ff6bcb09c81" />

### 4.1. Hiệu suất Mặt bằng & Khủng hoảng Mùa vụ Tháng 10
* **Insight từ hình ảnh:** Tháng 10 là giai đoạn chạm đáy toàn hệ thống (doanh thu lao dốc nghiêm trọng, chỉ còn đạt mức **$623.87K**). Tuy nhiên, khi nhìn vào bảng Ma trận, các cửa hàng thuộc khu vực **Airport (Sân bay)** vẫn duy trì được sắc xanh đậm, chứng tỏ khả năng chống chịu và duy trì tỷ suất doanh thu cực tốt trong mùa thấp điểm. Dù trong tháng khủng hoảng, nhóm hàng *Toys* và *Electronics* vẫn là trụ cột gánh vác phần lớn lợi nhuận.

<img width="837" height="460" alt="{318DB309-FCCE-4629-A4DA-E1641802A27D}" src="https://github.com/user-attachments/assets/911b6dc2-a77e-40dd-9ffd-3d745dbbafda" />

### 4.2. Khai thác Danh mục Sản phẩm Chủ lực 
* **Insight từ hình ảnh:** Khi lọc riêng nhóm hàng *Toys*, dữ liệu xác nhận đây là trụ cột tài chính tuyệt đối của hệ thống khi đóng góp tới **$5.09M Doanh thu** và **$1.08M Lợi nhuận**. Đáng chú ý, trong bảng xếp hạng Top 3 doanh thu, nhóm Toys đóng góp chủ lực là *Lego Bricks* (Top 1 vững chắc), chiếm lĩnh hoàn toàn sức mua tại các mặt bằng trọng điểm như Sân bay và Trung tâm. 

<img width="834" height="473" alt="{01409C4C-77FE-4CF7-ADCB-15AAC59EA1CC}" src="https://github.com/user-attachments/assets/157b5d56-fb80-484f-86d5-57f86557c9a6" />

### 4.3. Quản trị Rủi ro Chuỗi cung ứng 
* **Insight từ hình ảnh:** Lọc chéo sản phẩm *Colorbuds* (Á quân doanh thu) phát hiện tỷ lệ an toàn tồn kho (Stockout Risk Ratio) chạm đáy báo động ở mức **1.11%**. Lượng dự trữ hiện tại không thể đáp ứng sức mua, đe dọa làm đứt gãy chuỗi cung ứng và dòng tiền ngay trong vài ngày tới.

<img width="842" height="461" alt="{D1966C25-8F79-4CAF-A2FF-C555E52AE228}" src="https://github.com/user-attachments/assets/bc873026-2485-4d3f-b51a-d68443bc9531" />

## 5. Giải pháp Đề xuất 
Dựa trên các phân tích dữ liệu, dưới đây là 3 giải pháp chiến lược nhằm tối ưu hóa vận hành và duy trì tăng trưởng:

1. **Tối ưu hóa Mặt bằng & Khắc phục Mùa vụ:**
   * **Mặt bằng:** Ưu tiên phân bổ ngân sách mở rộng cho các cửa hàng tại khu vực **Sân bay (Airport)** do khả năng duy trì doanh thu ổn định. 
   * **Mùa vụ:** Để ứng phó với chu kỳ suy giảm doanh thu vào tháng 10, cần triển khai sớm các chương trình kích cầu tập trung vào hai nhóm hàng chủ lực là *Toys* và *Electronics* từ cuối Quý 3.

2. **Tối ưu hóa Không gian Trưng bày:**
   * Ưu tiên diện tích kệ hàng tại các vị trí vàng, dễ tiếp cận nhất cho nhóm *Toys* (đặc biệt là *Lego Bricks*). 
   * Đảm bảo cung cấp đủ lượng hàng hóa và tối ưu hóa không gian trưng bày cho nhóm sản phẩm này tại các khu vực trọng điểm (Sân bay và Trung tâm) nhằm tối đa hóa tỷ lệ chuyển đổi.

3. **Quản trị Rủi ro Chuỗi cung ứng:**
   * Lập tức kích hoạt lệnh nhập hàng khẩn cấp cho mặt hàng *Colorbuds* nhằm ngăn chặn nguy cơ đứt gãy dòng tiền.
   
