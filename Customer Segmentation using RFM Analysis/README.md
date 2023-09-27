# Customer Segmentation using RFM Analysis (Các bước phân khúc khách hàng theo mô hình RFM) 

## 1. Giới thiệu mô hình RFM 
**RFM** là viết tắt của **Recency**, **Frequency**, và **Monetary**. Đây là một mô hình  thường được sử dụng để phân đoạn và đánh giá khách hàng dựa trên hành vi mua sắm của họ. Cụ thể: 
- **Recency (R)**: Đo lường thời gian kể từ lần mua hàng gần nhất của khách hàng. Khách hàng mua hàng gần đây sẽ có R-score càng cao.
- **Frequency (F)**: Đo lường số lần mua hàng của khách hàng trong một khoảng thời gian nhất định. Khách hàng mua hàng thường xuyên sẽ có giá trị F cao hơn.
- **Monetary (M)**: Đo lường tổng giá trị các giao dịch mua hàng của khách hàng. Khách hàng có tổng chi tiêu cao sẽ có giá trị M cao hơn.

Dựa trên các chỉ số RFM, chúng ta có thể phân khúc các nhóm khách hàng với các đặc điểm giá trị khác nhau đối với công ty. Mỗi loại khách hàng đòi hỏi các phương pháp tiếp thị khác nhau tương ứng. 
## 2. Dataset 
Bộ dữ liệu: [Dataset RFM](https://github.com/tranthithanhhai/My-portfolio/tree/main/Customer%20Segmentation%20using%20RFM%20Analysis/dataset) chứa thông tin về khách hàng, và các giao dịch mua sắm, bao gồm thông tin đơn hàng, vận chuyển, ngày đặt hàng, số tiền giao dịch,...

Vì bộ dữ liệu có ngày giao dịch xảy ra khá lâu từ 01.2014 đến 12.2017. Nên thay vì chọn ngày hiện tại để tính Recency, tôi sẽ chọn ngày phân tích sau 3 tháng kể từ 31.12.2017, tức ngày 31.03.2018.

Bộ dữ liệu có 3 bảng: **customer**, **sales**, **scores**. Dưới đây là các dòng đầu tiên cơ bản của bộ dữ liệu:

Bảng **customer**

|Customer_ID|Customer_Name|Segment|Age|Country|City|State|Postal_Code|Region|
|---|---|---|---|---|---|---|---|---|
|AA-10315|Alex Avila|Consumer|66|United States|Minneapolis|Minnesota|55407|Central|
|AA-10375|Allen Armold|Consumer|22|United States|Mesa|Arizona|85204|West|
|AA-10480|Andrew Allen|Consumer|50|United States|Concord|North Carolina|28027|South|
|AA-10645|Anna Andreadi|Consumer|32|United States|Chester|Pennsylvania|19013|East|
|AB-10015|Aaron Bergman|Consumer|66|United States|Seattle|Washington|98103|West|

Bảng **sales**

|Order_Line|Order_ID|Order_Date|Ship_Date|Ship_Mode|Customer_ID|Product_ID|Sales|Quantity|Discount|Profit|
|---|---|---|---|---|---|---|---|---|---|---|
|1|CA-2016-152156|2016-11-08|2016-11-11|Second Class|CG-12520|FUR-BO-10001798|261.96|2|0|41.9136|
|2|CA-2016-152156|2016-11-08|2016-11-11|Second Class|CG-12520|FUR-CH-10000454|731.94|3|0|219.582|
|3|CA-2016-138688|2016-06-12|2016-06-16|Second Class|DV-13045|OFF-LA-10000240|14.62|2|0|6.8714|
|4|US-2015-108966|2015-10-11|2015-10-18|Standard Class|SO-20335|FUR-TA-10000577|957.5775|5|0.45|-383.031|
|5|US-2015-108966|2015-10-11|2015-10-18|Standard Class|SO-20335|OFF-ST-10000760|22.368|2|0.2|2.5164|

Bảng **scores**

|Segment|Scores|
|---|---|
|About To Sleep|331|
|About To Sleep|321|
|About To Sleep|312|
|About To Sleep|221|
|About To Sleep|213|
|At Risk|255|
|At Risk|254|
|At Risk|253|
|At Risk|252|
|At Risk|245|

Sau khi có được chỉ số RFM cho từng khách hàng, dựa vào bảng scores, chúng ta có thể phân khúc khách hàng và có các chiến lược tiếp thị phù hợp cho từng loại khách hàng như sau: 

![Segment scores](https://github.com/haitran95/My-portfolio/blob/main/Customer%20Segmentation%20using%20RFM%20Analysis/image/segment.PNG)

Nguồn ảnh: [blog.tomorrowmarketers](https://blog.tomorrowmarketers.org/phan-tich-rfm-la-gi/#:~:text=Ph%C3%A2n%20t%C3%ADch%20RFM%20)

## 3. Các bước thực hiện
### Tính Recency, Frequency, Monetary 
```sql
WITH RFM_table AS
(
  SELECT c.Customer_ID, c.Customer_Name AS CustomerName,
    DATEDIFF(DAY, MAX(s.Order_Date), '2018-03-31') AS Recency,
    COUNT(DISTINCT s.Order_Date) AS Frequency,
    ROUND(SUM(s.Sales), 2) AS Monetary
  FROM sales AS s
  INNER JOIN customer AS c ON s.Customer_ID = c.Customer_ID
  GROUP BY c.Customer_ID, c.Customer_Name
)
SELECT TOP 10 * FROM RFM_table
```

Kết quả  RFM_table
|Customer_ID|CustomerName|Recency|Frequency|Monetary|
|---|---|---|---|---|
|AA-10315|Alex Avila|275|5|5563.56|
|AA-10375|Allen Armold|110|9|1056.39|
|AA-10480|Andrew Allen|350|4|1790.51|
|AA-10645|Anna Andreadi|146|6|5086.94|
|AB-10015|Aaron Bergman|506|3|886.16|
|AB-10060|Adam Bellavance|145|8|7755.62|
|AB-10105|Adrian Barton|132|10|14473.57|
|AB-10150|Aimee Bixby|132|5|966.71|
|AB-10165|Alan Barnes|116|8|1113.84|
|AB-10255|Alejandro Ballentine|257|9|914.53|

### Tính RFM_Score
```sql
WITH RFM_table AS
(
  SELECT c.Customer_ID, c.Customer_Name AS CustomerName,
    DATEDIFF(DAY, MAX(s.Order_Date), '2018-03-31') AS Recency,
    COUNT(DISTINCT s.Order_Date) AS Frequency,
    ROUND(SUM(s.Sales), 2) AS Monetary
  FROM sales AS s
  INNER JOIN customer AS c ON s.Customer_ID = c.Customer_ID
  GROUP BY c.Customer_ID, c.Customer_Name
)
-- -- -- RFM_Score -- -- --
, RFM_Score 
AS
(
  SELECT *,
    NTILE(5) OVER (ORDER BY Recency DESC) as R_Score,
    NTILE(5) OVER (ORDER BY Frequency ASC) as F_Score,
    NTILE(5) OVER (ORDER BY Monetary ASC) as M_Score
  FROM RFM_table
)
SELECT * FROM RFM_Score
```

Bảng **RFM_Score**
|Customer_ID|CustomerName|Recency|Frequency|Monetary|R_Score|F_Score|M_Score|
|---|---|---|---|---|---|---|---|
|TS-21085|Thais Sissman|448|2|4.83|1|1|1|
|LD-16855|Lela Donovan|643|1|5.3|1|1|1|
|CJ-11875|Carl Jackson|456|1|16.52|1|1|1|
|MG-18205|Mitch Gastineau|355|1|16.74|1|1|1|
|RS-19870|Roy Skaria|110|2|22.33|5|1|1|
|SG-20890|Susan Gilcrest|317|3|47.95|1|1|1|
|RE-19405|Ricardo Emerson|1188|1|48.36|1|1|1|
|LB-16735|Larry Blacks|139|3|50.19|4|1|1|
|AS-10135|Adrian Shami|132|2|58.82|4|1|1|
|JC-15340|Jasper Cacioppo|205|4|71.26|2|1|1|

### Tính RFM Overall Score và Kết Hợp với Segment
```SQL
WITH RFM_table AS
(
  SELECT c.Customer_ID, c.Customer_Name AS CustomerName,
    DATEDIFF(DAY, MAX(s.Order_Date), '2018-03-31') AS Recency,
    COUNT(DISTINCT s.Order_Date) AS Frequency,
    ROUND(SUM(s.Sales), 2) AS Monetary
  FROM sales AS s
  INNER JOIN customer AS c ON s.Customer_ID = c.Customer_ID
  GROUP BY c.Customer_ID, c.Customer_Name
)
--SELECT * FROM RFM_table
-- -- -- RFM_Score -- -- --
, RFM_Score 
AS
(
  SELECT *,
    NTILE(5) OVER (ORDER BY Recency DESC) as R_Score,
    NTILE(5) OVER (ORDER BY Frequency ASC) as F_Score,
    NTILE(5) OVER (ORDER BY Monetary ASC) as M_Score
  FROM RFM_table
)
-- SELECT * FROM RFM_Score
-- -- -- RFM OVERALL -- -- --
, RFM
AS
(
SELECT *,
  CONCAT(R_Score, F_Score, M_Score) as RFM_overall
FROM RFM_Score
)
SELECT r.*, s.Segment
FROM RFM as r
LEFT JOIN scores s ON r.RFM_overall = s.Scores
```
Bảng **RFM** 
|Customer_ID|CustomerName|Recency|Frequency|Monetary|R_Score|F_Score|M_Score|RFM_overall|Segment|
|---|---|---|---|---|---|---|---|---|---|
|TS-21085|Thais Sissman|448|2|4.83|1|1|1|111|Lost customers|
|LD-16855|Lela Donovan|643|1|5.3|1|1|1|111|Lost customers|
|CJ-11875|Carl Jackson|456|1|16.52|1|1|1|111|Lost customers|
|MG-18205|Mitch Gastineau|355|1|16.74|1|1|1|111|Lost customers|
|RS-19870|Roy Skaria|110|2|22.33|5|1|1|511|New Customers|
|SG-20890|Susan Gilcrest|317|3|47.95|1|1|1|111|Lost customers|
|RE-19405|Ricardo Emerson|1188|1|48.36|1|1|1|111|Lost customers|
|LB-16735|Larry Blacks|139|3|50.19|4|1|1|411|New Customers|
|AS-10135|Adrian Shami|132|2|58.82|4|1|1|411|New Customers|
|JC-15340|Jasper Cacioppo|205|4|71.26|2|1|1|211|Hibernating customers|

## 4. Vẽ treemap chart bằng Power BI
![Treemap chart](https://github.com/haitran95/My-portfolio/blob/main/Customer%20Segmentation%20using%20RFM%20Analysis/image/chart.PNG)

Dựa vào biểu đồ, ta có thể thấy phân khúc khác hàng chiếm tỷ trọng cao nhất là: At Risk, Hibernating customers, và Potential Loyalist. 
- Với phân khúc Potential Loyalist, chúng ta có thể thấy rằng đây là nhóm khách hàng có Recency (R) không quá cao, Frequency (F) và Monetary (M) không cao như nhóm "Loyal Customers" nhưng có tiềm năng để trở thành khách hàng trung thành hơn trong tương lai. Chúng ta có thể đề xuất: 
  + Cung cấp các *Chương trình Khuyến Mãi*: Tạo ra các chương trình khuyến mãi hoặc ưu đãi dành riêng cho nhóm này để tạo động lực cho họ mua sắm thường xuyên hơn. Các ưu đãi có thể bao gồm giảm giá, quà tặng hoặc điểm thưởng.
  + Cung cấp các *Chương trình Tích Điểm hoặc Thẻ Thành Viên*:  để khuyến khích họ tiếp tục mua sắm và tích lũy điểm thưởng hoặc ưu đãi.
- Với phân khúc At Risk (Khách hàng có nguy cơ mất), Hibernating customers (khách hàng đang ngủ đông), chúng ta cần thực hiện các chiến lược để tái kích thích sự tương tác và mua sắm:
  + Ưu đãi đặc biệt: Cung cấp ưu đãi đặc biệt hoặc giảm giáquà tặng kèm, điểm thưởng.,  để kích thích họ quay lại mua sắm. Cố gắng tạo ra lợi ích ngay lập tức để họ có động lực mua hàng.
  + Kích thích tương tác: có thể thông qua việc gửi email, thông báo, hoặc tin nhắn cá nhân.








