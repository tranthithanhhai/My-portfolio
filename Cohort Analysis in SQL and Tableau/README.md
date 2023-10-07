# Cohort Analysis using SQL, Tableau and Python (Phân tích khách hàng theo nhóm)
[![Jupyter Notebook](https://img.shields.io/badge/Jupyter%20Notebook-F37626?style=flat-square&logo=jupyter&logoColor=white)](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/Cohort_Analysis.ipynb)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat-square&logo=sql&logoColor=white)](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/OnlineRetail_Query.sql)

- Lý thuyết về Cohort Analysis (Khách hàng theo nhóm)
    - 1.1 Khái niệm
    - 1.2 Phân loại
- Thực hành phân tích nhóm
    - 2.1 Dataset
    - 2.2 Thực hành phân tích nhóm bằng Python
    - 2.3 Thực hành phân tích nhóm bằng SQL, Tableau 

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
- Cách 1: [Sử dụng Python](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/Cohort_Analysis.ipynb)
- Cách 2: [Sử dụng SQL](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/OnlineRetail_Query.sql) và [Trực Quan bằng Tableau](https://public.tableau.com/app/profile/hai7497/viz/CohortAnalysis_16890938668340/CohortAnalysis)

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

### 2.2 Thực hành phân tích nhóm bằng Python ([Full Code](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/Cohort_Analysis.ipynb))
#### 2.1.1 EDA
Xem 5 dòng đầu tiên của dữ liệu

|   InvoiceNo | StockCode   | Description                         |   Quantity | InvoiceDate   |   UnitPrice |   CustomerID | Country        |
|------------:|:------------|:------------------------------------|-----------:|:--------------|------------:|-------------:|:---------------|
|      536365 | 85123A      | WHITE HANGING HEART T-LIGHT HOLDER  |          6 | 01-12-10 8:26 |        2.55 |        17850 | United Kingdom |
|      536365 | 71053       | WHITE METAL LANTERN                 |          6 | 01-12-10 8:26 |        3.39 |        17850 | United Kingdom |
|      536365 | 84406B      | CREAM CUPID HEARTS COAT HANGER      |          8 | 01-12-10 8:26 |        2.75 |        17850 | United Kingdom |
|      536365 | 84029G      | KNITTED UNION FLAG HOT WATER BOTTLE |          6 | 01-12-10 8:26 |        3.39 |        17850 | United Kingdom |
|      536365 | 84029E      | RED WOOLLY HOTTIE WHITE HEART.      |          6 | 01-12-10 8:26 |        3.39 |        17850 | United Kingdom |

Kiểm tra các giá trị null
|   InvoiceNo |   StockCode | Description                     |   Quantity | InvoiceDate    |   UnitPrice |   CustomerID | Country        |
|------------:|------------:|:--------------------------------|-----------:|:---------------|------------:|-------------:|:---------------|
|      536414 |       22139 | nan                             |         56 | 01-12-10 11:52 |        0    |          nan | United Kingdom |
|      536544 |       21773 | DECORATIVE ROSE BATHROOM BOTTLE |          1 | 01-12-10 14:32 |        2.51 |          nan | United Kingdom |
|      536544 |       21774 | DECORATIVE CATS BATHROOM BOTTLE |          2 | 01-12-10 14:32 |        2.51 |          nan | United Kingdom |
|      536544 |       21786 | POLKADOT RAIN HAT               |          4 | 01-12-10 14:32 |        0.85 |          nan | United Kingdom |
|      536544 |       21787 | RAIN PONCHO RETROSPOT           |          2 | 01-12-10 14:32 |        1.66 |          nan | United Kingdom |

Sau khi làm sạch dữ liệu, báo cáo EDA chi tiết cho từng thuộc tính, bao gồm các giá trị thống kê, phân tích tương quan tại [File report HTML](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/report.html).
#### 2.1.2 Thực hành phân tích nhóm
Để thực hiện cohort analysis, thì chúng ta cần tạo ra những cột dữ liệu sau:
- Invoice period: Đại diện cho năm-tháng xảy ra giao dịch. Trong project này, tôi sẽ sử dụng `CohortMonth`, đại diện cho tháng xảy ra giao dịch. 
- Cohort group: Chuỗi đại diện cho năm và tháng khách hàng mua hàng lần đầu tiên cho mỗi khách hàng
- Cohort Index: 1 số tự nhiên ghi lại giai đoạn trong vòng đời của mỗi khách hàng (có thể là số ngày, số tuần, số tháng, số năm ...) số tháng trôi qua kể từ khi khách hàng mua hàng lần đầu tiên. Trong project này, `CohortIndex` đại diện cho số tháng trôi qua kể từ khi khách hàng lần đầu tiên sử dụng dịch vụ. 
 
**Tạo cột InvoiceMonth và CohortMonth**

|   InvoiceNo | StockCode   | Description                         |   Quantity | InvoiceDate         |   UnitPrice |   CustomerID | Country        | InvoiceMonth        | CohortMonth         |
|------------:|:------------|:------------------------------------|-----------:|:--------------------|------------:|-------------:|:---------------|:--------------------|:--------------------|
|      536365 | 85123A      | WHITE HANGING HEART T-LIGHT HOLDER  |          6 | 2010-12-01 08:26:00 |        2.55 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |
|      536365 | 71053       | WHITE METAL LANTERN                 |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |
|      536365 | 84406B      | CREAM CUPID HEARTS COAT HANGER      |          8 | 2010-12-01 08:26:00 |        2.75 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |
|      536365 | 84029G      | KNITTED UNION FLAG HOT WATER BOTTLE |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |
|      536365 | 84029E      | RED WOOLLY HOTTIE WHITE HEART.      |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |

**Tạo cột CohortIndex**

|   InvoiceNo | StockCode   | Description                         |   Quantity | InvoiceDate         |   UnitPrice |   CustomerID | Country        | InvoiceMonth        | CohortMonth         |   CohortIndex |
|------------:|:------------|:------------------------------------|-----------:|:--------------------|------------:|-------------:|:---------------|:--------------------|:--------------------|--------------:|
|      536365 | 85123A      | WHITE HANGING HEART T-LIGHT HOLDER  |          6 | 2010-12-01 08:26:00 |        2.55 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |             1 |
|      536365 | 71053       | WHITE METAL LANTERN                 |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |             1 |
|      536365 | 84406B      | CREAM CUPID HEARTS COAT HANGER      |          8 | 2010-12-01 08:26:00 |        2.75 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |             1 |
|      536365 | 84029G      | KNITTED UNION FLAG HOT WATER BOTTLE |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |             1 |
|      536365 | 84029E      | RED WOOLLY HOTTIE WHITE HEART.      |          6 | 2010-12-01 08:26:00 |        3.39 |        17850 | United Kingdom | 2010-12-01 00:00:00 | 2010-12-01 00:00:00 |             1 |

**Thống kê số lượng khách hàng "active" cho mỗi cohort**

![cohort data](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/cohort_data.PNG)

**Sử dụng pivot table  chuyển đổi bảng sang dạng wide để dễ quan sát**

![cohort count](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/cohort_count_2.PNG)

**Trực quan dữ liệu**

![Number Retention Customers](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/NumberRetentionCustomers.png)

Nhìn vào biểu đồ, ta có thể thấy:
- Tháng 12/2010: Doanh nghiệp có 885 khách hàng mới. Tuy nhiên, sau 1 tháng, tức vào thời điểm tháng 11/2010 chỉ còn 324 trong số 885 khách hàng này còn sử dụng dịch vụ,...Sau 13 tháng, vào tháng 12/2011 chỉ còn 235 khách hàng còn sử dụng dịch vụ.
- Tương tự như vậy, xét tháng 11/2011: Doanh nghiệp có 323 khách hàng mới, sau 1 tháng, tức tháng 12/2011: có 36 khách hàng trong tổng số 323 khách hàng quay trở lại sử dụng dịch vụ. Tuy nhiên, ở các tháng tiếp theo, không có khách hàng nào trong nhóm khách hàng mới của tháng 11/2011 còn sử dụng dịch vụ. 
- Nhìn chung, số lượng khách hàng quay lại sử dụng dịch vụ sau 1 tháng giảm đi rất nhiều. 

![No. Monthly New Users In This Period](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/NewUsers.png)

Dựa vào biểu đồ đường theo dõi lượng khách hàng mới mà doanh nghiệp đạt được mỗi tháng, ta thấy:
- Tháng 12/2010, số lượng khách hàng mới cao nhất (885 khách hàng), đây có thể là một tháng khá tích cực về chiến dịch tiếp thị. 
- Giai đoạn 01/2011 - 03/2011 sau đó đã có sự giảm mạnh, và giảm dần qua từng tháng cho đến 08/2011, doanh nghiệp chỉ đạt 169 khách hàng mới. Trong giai đoạn này doanh nghiệp nên tạo các chương trình khuyến mãi và ưu đãi để thu hút sự quan tâm của các khách hàng tiềm năng.
- Giai đoạn 11/2011 - 12/2011: Số lượng khách hàng mới đáng kể giảm đi và thậm chí tháng 12/2011 không có khách hàng mới. Doanh nghiệp cần xem xét lại nguyên nhân, có thể kể đến bao gồm: chất lượng sản phẩm giảm sút, đối thủ cạnh tranh tung ra các chiến dịch ưu đãi hấp dẫn hơn ?

![Retention rates](https://github.com/tranthithanhhai/My-portfolio/blob/main/Cohort%20Analysis%20in%20SQL%20and%20Tableau/images/RetentionRates.png)

Nhìn vào biểu đồ tỷ lệ giữ chân khách hàng, ta có thể thấy thời điểm sau 6 tháng là thời điểm vàng để doanh nghiệp có thể tung ra các chiến lược marketing để thu hút khách hàng quay trở lại sử dụng dịch vụ. Vì tỷ lệ giữ chân khách hàng ở sau thời điểm này thường ổn định. Cụ thể, ở Cohort tháng 12/2011, ta có thể thấy tỷ lệ khách hàng quay lại đa phần > 35% so với các tỷ lệ biến động trước đó. 


### 2.3 Thực hành phân tích nhóm bằng SQL, Tableau. 
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









