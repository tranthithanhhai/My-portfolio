# Cohort Analysis using SQL, Tableau and Python (Phân tích khách hàng theo nhóm)
## 1. Cohort Analysis (Khách hàng theo nhóm)
### 1.1 Khái niệm 
- Cohort Ananlysis (Khách hàng theo nhóm) là phương pháp phân tích hành vi, trong đó: tập dữ liệu khách hàng được phân chia thành các nhóm, các nhóm này được gọi là các "cohort" cùng chia sẻ những đặc điểm, trải nghiệm trong cùng một khoảng thời gian. 
- Bằng cách theo dõi các cohort theo thời gian, doanh nghiệp có thể linh hoạt điều chỉnh dịch vụ cho từng cohort cụ thể. 
### 1.2 Phân loại 
#### 1.2.1 **Phân tích Nhóm dựa trên thời gian (Time-based Cohorts)**
Trong loại phân tích này, chúng ta chia khách hàng thành các nhóm *dựa trên khoảng thời gian cụ thể*. Loại phân tích này hữu ích khi chúng ta muốn *xem xét tỷ lệ mất khách hàng(churn rate)* của doanh nghiệp. 

**Ví dụ**, giả định khách hàng được tiếp nhận vào Q1 của năm, và rời bỏ trung bình sau 18 tháng. Trong khi đó, những người được tiếp nhận vào Q2 thì trung bình hủy bỏ sau 6 tháng. Sự chênh lệch này cho thấy có thể đã xảy ra một số vấn đề với quy trình tiếp nhận của chúng tôi vào Q2. Chúng ta cần điều tra thêm xem điều gì đã xảy ra. Có thể trường hợp là vào Q2, một đối thủ bắt đầu cung cấp các ưu đãi tốt hơn cho khách hàng của chúng tôi - sự cải thiện về chất lượng hoặc giảm giá.
    
#### 1.2.1 **Phân tích Nhóm dựa trên đặc điểm (Segment-based Cohorts)**
Loại này phân tích này nhóm khách hàng dựa trên nhiều đặc điểm khác nhau. 

**Ví dụ**, chúng ta có thể chia thành các nhóm dựa trên **lịch sử đăng ký** của họ. 
- Khách hàng sử dụng **phiên bản Basic** của sản phẩm của chúng tôi có thể có nhu cầu khác với người dùng **phiên bản Pro** .  
- Chúng ta cũng có thể xem xét tỷ lệ mất khách hoặc giá trị vòng đời (LTV) của khách hàng dựa trên các nhóm đối tượng khác nhau và xác định kế hoạch đăng ký hoạt động tốt hơn, cải thiện các ưu đãi khác hoặc thúc đẩy hoạt động tốt trong chiến dịch tiếp thị của mình cho từng nhóm khách hàng. 
    
#### 1.2.3 **Phân tích Nhóm dựa trên kích thước (Size-based Cohorts)**
Loại phân tích này dựa trên kích thước/giá trị sử dụng dịch vụ của khách hàng - nhỏ, trung bình, lớn, doanh nghiệp. So sánh số tiền khách hàng trong các nhóm khác nhau chi tiêu sẽ giúp chúng ta xác định nơi mà doanh nghiệp tạo ra dòng tiền. 

## 2. Thực hành phân tích nhóm 

**Trong project này, tôi sẽ thực hiện phân tích cohort bằng việc chia tập khách hàng thành các nhóm đối tượng theo tháng tiếp nhận (Segment-based Cohorts), và thực hiện bằng 2 cách khác nhau:**
- Cách 1: [Sử dụng SQL](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/OnlineRetail_Query.sql) và [Trực Quan bằng Tableau](https://public.tableau.com/app/profile/hai7497/viz/CohortAnalysis_16890938668340/CohortAnalysis)
- Cách 2: [Sử dụng Python](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/Cohort_Analysis.ipynb)

### 2.1 Dataset 
Bộ dữ liệu [Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail) chứa tất cả các giao dịch diễn ra từ ngày 01/12/2010 đến ngày 09/12/2011 của một doanh nghiệp bán lẻ trực tuyến tại UK. Các thuộc tính bao gồm:

| Thuộc tính           | Mô Tả                                                                      |
|---------------|-----------------------------------------------------------------------------|
| InvoiceNo     | Số Hóa Đơn. Một số nguyên 6 chữ số, duy nhất cho mỗi giao dịch. Nếu bắt đầu bằng chữ cái 'c', đây chỉ định một giao dịch bị hủy.   |
| StockCode     | Mã Sản Phẩm. Một số nguyên 5 chữ số, mỗi mã đại diện cho một mặt hàng riêng biệt.   |
| Description   | Tên Sản Phẩm (Mặt Hàng). Được biểu diễn bằng chữ cái và số.   |
| Quantity      | Số Lượng của từng sản phẩm (mặt hàng) trong mỗi giao dịch. Dạng số.   |
| InvoiceDate   | Ngày và giờ hóa đơn. Được biểu diễn bằng dạng số, ngày và giờ khi mỗi giao dịch được tạo ra.   |
| UnitPrice     | Đơn Giá. Dạng số, giá của sản phẩm cho mỗi đơn vị tính bằng bảng Anh.   |
| CustomerID    | Số Khách Hàng. Một số nguyên 5 chữ số, mỗi khách hàng được gán một số duy nhất.   |
| Country       | Tên Quốc Gia. Được biểu diễn bằng chữ cái, đây là tên quốc gia mà mỗi khách hàng đang cư trú.   |

### 2.2 Thực hành phân tích nhóm bằng SQL, Tableau. 
#### Bước 1: Làm sạch dữ liệu: loại bỏ các giá trị null và trùng lặp
```sql
SELECT * FROM OnlineRetail
WHERE CustomerID IS NULL
-- > 135.080 rows have no CustomerID
SELECT * FROM OnlineRetail
WHERE CustomerID IS NOT NULL
--> 406.829 rows have CustomerID

;WITH OnlineRetail AS
(
	SELECT InvoiceNo
		  ,StockCode
		  ,Description
		  ,Quantity
		  ,InvoiceDate
		  ,UnitPrice
		  ,CustomerID
		  ,Country
	  FROM dbo.OnlineRetail
	  WHERE CustomerID IS NOT NULL
)
, t0 AS -- t0 is a table with quantity > 0 and Unit price > 0, CustomerID is not null
(
	---397.884 rows with quantity > 0 and Unit price > 0, CustomerID is not null
	SELECT *
	FROM OnlineRetail
	WHERE Quantity > 0 AND UnitPrice > 0
)
-- SELECT * FROM t0
-- check dupplicate 
SELECT *, ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Quantity ORDER BY InvoiceDate)DUP_CHECK
FROM t0
-- ------
;WITH OnlineRetail AS
(
	SELECT InvoiceNo
		  ,StockCode
		  ,Description
		  ,Quantity
		  ,InvoiceDate
		  ,UnitPrice
		  ,CustomerID
		  ,Country
	  FROM dbo.OnlineRetail
	  WHERE CustomerID IS NOT NULL
)
, t0 AS -- t0 is a table with quantity > 0 and Unit price > 0, CustomerID is not null
(
	---397.884 rows with quantity > 0 and Unit price > 0, CustomerID is not null
	SELECT *
	FROM OnlineRetail
	WHERE Quantity > 0 AND UnitPrice > 0
)
, t_dup_check AS 
(   SELECT *, ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Quantity ORDER BY InvoiceDate)DUP_CHECK
FROM t0
)

SELECT *
INTO #main_table 
FROM t_dup_check
WHERE DUP_CHECK = 1
--
SELECT * FROM #main_table -- 392.669 rows 
```
#### Bước 2: Tạo Cohort và Cohort Index
**Tạo bảng "#Cohort" chứa thông tin về ngày đầu tiên mua hàng của từng khách hàng và cột "CohortDate" biểu thị tháng và năm của lần mua hàng đầu tiên**
```sql
ELECT * FROM #main_table 
-- create first date of invoice 
SELECT CustomerID, 
       MIN(InvoiceDate) FirstPurchaseDate,
       DATEFROMPARTS(YEAR(MIN(InvoiceDate)), MONTH(MIN(InvoiceDate)), 1) CohortDate
INTO #Cohort
FROM #main_table
GROUP BY CustomerID
```
**Tạo cột "CohortIndex," biểu thị số tháng đã trôi qua kể từ khi khách hàng tham gia Cohort đầu tiên**
```sql
SELECT mmm.*, 
       CohortIndex = YearDiff*12 + MonthDiff + 1
INTO #CohortRetention
FROM (
        SELECT mm.*, 
       YearDiff = YearInvoice - YearCohort, 
       MonthDiff = MonthInvoice - MonthCohort
        FROM 
            (
                SELECT m.*, 
                    c.CohortDate, 
                    YEAR(m.InvoiceDate) YearInvoice,
                    MONTH(m.InvoiceDate) MonthInvoice,
                    YEAR(c.CohortDate) YearCohort,
                    MONTH(c.CohortDate) MonthCohort
                FROM #main_table m
                LEFT JOIN #Cohort c ON m.CustomerID = c.CustomerID
            ) mm
     ) mmm
SELECT * FROM #CohortRetention
```
**Tạo bảng pivot để phân tích số lượng khách hàng trong từng Cohort và theo dõi tỷ lệ duy trì Cohort theo thời gian.**
```sql
SELECT DISTINCT 
	CustomerID, CohortDate, CohortIndex
	FROM #CohortRetention

---Pivot Data to see the cohort table
SELECT *
INTO #CohortPivot
FROM(
	SELECT DISTINCT 
		CustomerID,
		CohortDate,
		CohortIndex
	FROM #CohortRetention
) tbl
pivot(
	Count(CustomerID)
	for CohortIndex In 
		(
		[1], 
        [2], 
        [3], 
        [4], 
        [5], 
        [6], 
        [7],
		[8], 
        [9], 
        [10], 
        [11], 
        [12],
		[13])

)AS CohortPivot
ORDER BY CohortDate
-- COHORT RETENTION RATE 
SELECT * 
FROM #CohortPivot
ORDER BY CohortDate
```
**Tạo bảng để toán tỷ lệ (%) giữ chân khách hàng qua các tháng và biểu đồ hóa chúng thành một biểu đồ thể hiện sự thay đổi của tỷ lệ này theo thời gian.**
```sql
SELECT CohortDate ,
		(1.0 * [1]/[1] * 100) AS [1], 
		1.0 * [2]/[1] * 100 AS [2], 
		1.0 * [3]/[1] * 100 AS [3],  
		1.0 * [4]/[1] * 100 AS [4],  
		1.0 * [5]/[1] * 100 AS [5], 
		1.0 * [6]/[1] * 100 AS [6], 
		1.0 * [7]/[1] * 100 AS [7], 
		1.0 * [8]/[1] * 100 AS [8], 
		1.0 * [9]/[1] * 100 AS [9], 
		1.0 * [10]/[1] * 100 AS [10],   
		1.0 * [11]/[1] * 100 AS [11],  
		1.0 * [12]/[1] * 100 AS [12],  
		1.0 * [13]/[1] * 100 AS [13]
FROM #CohortPivot
```
[File Code SQL](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/OnlineRetail_Query.sql)
#### Bước 3: Trực Quan bằng Tableau
Thực hiện kết nối CSDL và tiến hành trực quan bằng [Tableau Public](https://public.tableau.com/app/profile/hai7497/viz/CohortAnalysis_16890938668340/CohortAnalysis)
### 2.3 Thực hành phân tích nhóm bằng Python

![Number Retention Customers](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/NumberRetentionCustomers.png)








