USE Superstore_RFM;

-- -- -- OVERVIEW -- -- --
SELECT * FROM customer
SELECT * FROM sales
SELECT * FROM scores
-- -- -- OVERVIEW -- -- --
/*
Vì dữ liệu từ 01.2014 --> 12.2017. Chọn ngày phân tích sau 3 tháng kể từ 31.12.2017
--> 31.03.2018
*/
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



