USE `planner`;



DROP PROCEDURE IF EXISTS `BudgetAverageMonthlySnapshot`;

DELIMITER ;;
CREATE PROCEDURE `BudgetAverageMonthlySnapshot`(prmStartDT DATETIME, prmEndDT DATETIME)
BEGIN


/********************************************************************************************** 
PURPOSE:		Generate Budget Average Monthly Snapshot
AUTHOR:		Rob Azinger
DATE:				12/19/2019
NOTES:			Snapshot Table - tmpTransactionSpotlight
CHANGE CONTROL:		 
***********************************************************************************************/

/**********************************************************************************************
	Open Session
***********************************************************************************************/

SET @varSessionID = UUID();



/**********************************************************************************************
	STEP 01:		Create temporary structure to store parameter & scope data
***********************************************************************************************/

SET @varStartDT = prmStartDT;
SET @varEndDT = prmEndDT;
SET @varTimeSpanMonth = TIMESTAMPDIFF(MONTH, prmStartDT, prmEndDT);


DROP TEMPORARY TABLE IF EXISTS tmpParameter;

CREATE TEMPORARY TABLE tmpParameter
(
	KeyID										INT(10) NOT NULL AUTO_INCREMENT
	,SessionID								VARCHAR(100)
    ,TimeSpanMonth 					INT
    ,StartDT									DATETIME
	,EndDT									DATETIME
	,StartID									VARCHAR(10)
	,EndID										VARCHAR(10)
	,BudgetAverageMonthlyID		VARCHAR(20)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpParameter
(
	SessionID
	,StartDT
    ,EndDT
)
SELECT 	@varSessionID 													AS SessionID
				,@varStartDT 														AS StartDT
                ,DATE_ADD(@varEndDT, INTERVAL -1 DAY) 	AS EndDT
;


-- Update Time Span Month
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT @varTimeSpanMonth AS TimeSpanMonth
						) RS
SET					tmpParameter.TimeSpanMonth = RS.TimeSpanMonth
;

-- Update Start ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 	CONCAT(YEAR(@varStartDT), LPAD(MONTH(@varStartDT), 2, '0' )) AS StartID
						) RS
SET					tmpParameter.StartID = RS.StartID
;

-- Update End ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 	CONCAT(YEAR(@varEndDT), LPAD(MONTH(@varEndDT), 2, '0' )) AS EndID
						) RS
SET					tmpParameter.EndID = RS.EndID
;

-- Update Budget Average Monthly ID
UPDATE 			tmpParameter
SET					tmpParameter.BudgetAverageMonthlyID = CONCAT(StartID, EndID)
;



/**********************************************************************************************
	STEP 02:		Get base Transaction data 
***********************************************************************************************/

INSERT INTO tmpBudgetAverage
(
	SessionID
	,TransactionID
	,TransactionDT
	,TransactionTypeID
	,TransactionType
	,TransactionNumber
	,Description
	,Amount
	,Note
	,BudgetNumber
	,BudgetGroupID
	,BudgetGroup
	,BudgetCategoryID
	,BudgetCategory
	,Sort
)
SELECT			tmpParameter.SessionID						AS SessionID
						,Transaction.TransactionID						AS TransactionID
						,Transaction.TransactionDT					AS TransactionDT
						,TransactionType.TransactionTypeID		AS TransactionTypeID
						,TransactionType.TransactionType			AS TransactionType
						,Transaction.TransactionNumber			AS TransactionNumber
						,Transaction.Description							AS Description
						,Transaction.Amount								AS Amount
						,Transaction.Note									AS Note
						,Transaction.BudgetNumber					AS BudgetNumber
						,BudgetGroup.BudgetGroupID				AS BudgetGroupID
						,BudgetGroup.BudgetGroup					AS BudgetGroup
						,BudgetCategory.BudgetCategoryID		AS BudgetCategoryID
						,BudgetCategory.BudgetCategory			AS BudgetCategory
						,BudgetCategory.Sort								AS Sort
FROM				Transaction Transaction
INNER JOIN	TransactionType TransactionType
ON					TransactionType.TransactionTypeID = Transaction.TransactionTypeID
INNER JOIN	BudgetCategory BudgetCategory
ON					BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
INNER JOIN	BudgetGroup BudgetGroup
ON					BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
INNER JOIN	tmpParameter tmpParameter
ON					Transaction.TransactionDT BETWEEN tmpParameter.StartDT AND tmpParameter.EndDT
WHERE			Transaction.TransactionTypeID IN (1, 2)
;


UPDATE			tmpBudgetAverage
INNER JOIN	(
							SELECT 			BudgetItem.BudgetTypeID			AS BudgetTypeID	
													,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
							FROM 			BudgetItem BudgetItem
							INNER JOIN	tmpBudgetAverage tmpBudgetAverage	
							ON					tmpBudgetAverage.BudgetCategoryID = BudgetItem.BudgetCategoryID
							AND				tmpBudgetAverage.BudgetNumber = BudgetItem.BudgetNumber
							WHERE			tmpBudgetAverage.SessionID = @varSessionID
							GROUP BY		BudgetItem.BudgetCategoryID
						) RS
ON					tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
SET					tmpBudgetAverage.BudgetTypeID = RS.BudgetTypeID
WHERE			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
INNER JOIN	(
							SELECT 			SUM(tmpBudgetAverage.Amount)	AS IncomeActual 
							FROM 			tmpBudgetAverage tmpBudgetAverage	
							WHERE 			tmpBudgetAverage.SessionID = @varSessionID
							AND				tmpBudgetAverage.BudgetTypeID = 1
							GROUP BY		tmpBudgetAverage.BudgetTypeID
						) RS
SET					tmpBudgetAverage.IncomeActual = RS.IncomeActual
WHERE 			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
SET					tmpBudgetAverage.IncomeAverage = IFNULL(tmpBudgetAverage.IncomeActual, 1) / @varTimeSpanMonth
WHERE			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
INNER JOIN	(
							SELECT 			SUM(tmpBudgetAverage.Amount)	AS ExpenseActual 
							FROM 			tmpBudgetAverage tmpBudgetAverage	
							WHERE 			tmpBudgetAverage.SessionID = @varSessionID
							AND				tmpBudgetAverage.BudgetTypeID = 2
							GROUP BY		tmpBudgetAverage.BudgetTypeID
						) RS
SET					tmpBudgetAverage.ExpenseActual = RS.ExpenseActual
WHERE 			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
SET					tmpBudgetAverage.ExpenseAverage = IFNULL(tmpBudgetAverage.ExpenseActual, 1) / @varTimeSpanMonth
WHERE			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
SET					tmpBudgetAverage.TotalIncomeVsExpenseActual = IFNULL(tmpBudgetAverage.IncomeActual, 0) - IFNULL(tmpBudgetAverage.ExpenseActual, 0)
WHERE			tmpBudgetAverage.SessionID = @varSessionID
;


UPDATE			tmpBudgetAverage
SET					tmpBudgetAverage.TotalIncomeVsExpenseAverage = IFNULL(tmpBudgetAverage.IncomeAverage, 0)  - IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 
WHERE			tmpBudgetAverage.SessionID = @varSessionID
;



/**********************************************************************************************
	STEP xx:		Delete Budget Average Monthly data (if exists)
***********************************************************************************************/

DELETE 				snpBudgetAverageMonthly 
FROM					snpBudgetAverageMonthly
INNER JOIN		tmpParameter tmpParameter
ON						tmpParameter.BudgetAverageMonthlyID = snpBudgetAverageMonthly.BudgetAverageMonthlyID			
;



/**********************************************************************************************
	STEP xx:		Get base Budget Average Monthly data 
***********************************************************************************************/

INSERT INTO snpBudgetAverageMonthly
(
	BudgetAverageMonthlyID
	,IncomeActual
	,IncomeAverage
	,ExpenseActual
	,ExpenseAverage
	,TotalIncomeVsExpenseActual
	,TotalIncomeVsExpenseAverage
	,SnapshotDT
	,CreateDT
	,CreateBy
)
SELECT 			DISTINCT
						tmpParameter.BudgetAverageMonthlyID											AS BudgetAverageMonthlyID
						,IFNULL(tmpBudgetAverage.IncomeActual, 0) 									AS IncomeActual
						,IFNULL(tmpBudgetAverage.IncomeAverage, 0) 								AS IncomeAverage
						,IFNULL(tmpBudgetAverage.ExpenseActual, 0) 								AS ExpenseActual
						,IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 							AS ExpenseAverage
						,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseActual, 0) 		AS TotalIncomeVsExpenseActual
						,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseAverage, 0)		AS TotalIncomeVsExpenseAverage
                        ,CONVERT_TZ(NOW(), '+00:00','-00:00')											AS SnapshotDT
						,CONVERT_TZ(NOW(), '+00:00','-00:00')											AS CreateDT
                        ,'Snapshot' 																							AS CreateBy
FROM 			tmpBudgetAverage tmpBudgetAverage
INNER JOIN	tmpParameter tmpParameter
ON					tmpParameter.SessionID = tmpBudgetAverage.SessionID
;



/**********************************************************************************************
	Close Session
***********************************************************************************************/

DELETE 				tmpBudgetAverage 
FROM					tmpBudgetAverage
INNER JOIN		tmpParameter tmpParameter
ON						tmpParameter.SessionID = tmpBudgetAverage.SessionID
;



END;;
DELIMITER ;