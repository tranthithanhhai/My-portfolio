USE DB_RETAIL
-- view data 
SELECT * FROM OnlineRetail -- 541.909 rows
-- cleaning data 
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
-- SELECT * FROM t_dup_check
-- WHERE DUP_CHECK > 1
--> 392.669  cleaned rows
--> 5.215 duplicated rows 
SELECT *
INTO #main_table 
FROM t_dup_check
WHERE DUP_CHECK = 1
--
SELECT * FROM #main_table -- 392.669 rows 
----- COHORT ANALYSIS ------
SELECT * FROM #main_table 
-- create first date of invoice 
SELECT CustomerID, 
       MIN(InvoiceDate) FirstPurchaseDate,
       DATEFROMPARTS(YEAR(MIN(InvoiceDate)), MONTH(MIN(InvoiceDate)), 1) CohortDate
INTO #Cohort
FROM #main_table
GROUP BY CustomerID
--
SELECT * FROM #Cohort
---- Create Cohort Index: the number of months that has passed since the first purchase
-- SELECT m.*, 
--        c.CohortDate, 
--        YEAR(m.InvoiceDate) YearInvoice,
--        MONTH(m.InvoiceDate) MonthInvoice,
--        YEAR(c.CohortDate) YearCohort,
--        MONTH(c.CohortDate) MonthCohort
-- FROM #main_table m
-- LEFT JOIN #Cohort c ON m.CustomerID = c.CustomerID
-- ======================================================
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
-- ====================
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
----------------------------
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
ORDER BY CohortDate
