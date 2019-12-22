USE `planner`;


SET @prmStartDT = '2019-04-01';
SET @prmEndDT = '2019-06-01';




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
	STEP 01:		Initialize variables to store parameter & scope data
***********************************************************************************************/

SET @varStartDT = @prmStartDT;
SET @varEndDT = @prmEndDT;
SET @varLastDT = DATE_ADD(@varEndDT, INTERVAL -1 DAY);
SET @varStartID = CONCAT(YEAR(@varStartDT), LPAD(MONTH(@varStartDT), 2, '0' ));
SET @varEndID = CONCAT(YEAR(@varEndDT), LPAD(MONTH(@varEndDT), 2, '0' ));
SET @varBudgetAverageMonthlyID = CONCAT(@varStartID, @varEndID);
SET @varTimeSpanMonth = TIMESTAMPDIFF(MONTH, @varStartDT, @varEndDT);
SET @varSnapshotHash = '';

/*
SELECT	@varStartDT 									AS StartDT
				,@varEndDT 									AS EndDT
                ,@varLastDT 									AS LastDT
				,@varStartID 									AS StartID
				,@varEndID 									AS EndID
				,@varBudgetAverageMonthlyID		AS BudgetAverageMonthlyID
				,@varTimeSpanMonth 					AS TimeSpanMonth
				,@varSnapshotHash						AS SnapshotHash
;
*/



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
SELECT			@varSessionID										AS SessionID
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
WHERE			Transaction.TransactionDT BETWEEN @varStartDT AND @varLastDT
AND				Transaction.TransactionTypeID IN (1, 2)
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
	STEP 03:		Set Row Hash
***********************************************************************************************/

SELECT 			MD5(CONCAT(
							RS.BudgetAverageMonthlyID 					
							,RS.IncomeActual 								
							,RS.IncomeAverage 								
							,RS.ExpenseActual 								
							,RS.ExpenseAverage 							
							,RS.TotalIncomeVsExpenseActual 		
							,RS.TotalIncomeVsExpenseAverage
						))	AS SnapshotHash 
INTO				@varSnapshotHash
FROM 			(
							SELECT 			DISTINCT
													@varBudgetAverageMonthlyID															AS BudgetAverageMonthlyID
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
							WHERE			tmpBudgetAverage.SessionID = @varSessionID
						) RS
WHERE			RS.BudgetAverageMonthlyID = @varBudgetAverageMonthlyID
;



SELECT 	* 
FROM 	snpBudgetAverageMonthly
WHERE	SnapshotHash = @varSnapshotHash
;



/**********************************************************************************************
	STEP 03:		Delete Budget Average Monthly data (if exists)
***********************************************************************************************/

DELETE FROM	snpBudgetAverageMonthly
WHERE				BudgetAverageMonthlyID = @varBudgetAverageMonthlyID	
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
SELECT 		DISTINCT
					@varBudgetAverageMonthlyID															AS BudgetAverageMonthlyID
					,IFNULL(tmpBudgetAverage.IncomeActual, 0) 									AS IncomeActual
					,IFNULL(tmpBudgetAverage.IncomeAverage, 0) 								AS IncomeAverage
					,IFNULL(tmpBudgetAverage.ExpenseActual, 0) 								AS ExpenseActual
					,IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 							AS ExpenseAverage
					,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseActual, 0) 		AS TotalIncomeVsExpenseActual
					,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseAverage, 0)		AS TotalIncomeVsExpenseAverage
					,CONVERT_TZ(NOW(), '+00:00','-00:00')											AS SnapshotDT
					,CONVERT_TZ(NOW(), '+00:00','-00:00')											AS CreateDT
					,'Snapshot' 																							AS CreateBy
FROM 		tmpBudgetAverage tmpBudgetAverage
WHERE		tmpBudgetAverage.SessionID = @varSessionID
;



/**********************************************************************************************
	STEP xx:		Set Row Hash
***********************************************************************************************/

UPDATE			snpBudgetAverageMonthly
INNER JOIN	(
							SELECT 		snpBudgetAverageMonthly.KeyID 	AS KeyID
												,MD5(CONCAT(
													snpBudgetAverageMonthly.BudgetAverageMonthlyID 					
													,snpBudgetAverageMonthly.IncomeActual 								
													,snpBudgetAverageMonthly.IncomeAverage 								
													,snpBudgetAverageMonthly.ExpenseActual 								
													,snpBudgetAverageMonthly.ExpenseAverage 							
													,snpBudgetAverageMonthly.TotalIncomeVsExpenseActual 		
													,snpBudgetAverageMonthly.TotalIncomeVsExpenseAverage	
												))	AS SnapshotHash 
							FROM 		snpBudgetAverageMonthly snpBudgetAverageMonthly	
                            WHERE		snpBudgetAverageMonthly.BudgetAverageMonthlyID = @varBudgetAverageMonthlyID
						) RS
SET					snpBudgetAverageMonthly.SnapshotHash = RS.SnapshotHash
WHERE 			snpBudgetAverageMonthly.KeyID = RS.KeyID
; 



select * from tmpBudgetAverage;
select * from snpBudgetAverageMonthly;



/**********************************************************************************************
	Close Session
***********************************************************************************************/

DELETE FROM	tmpBudgetAverage
WHERE				tmpBudgetAverage.SessionID = @varSessionID
;



select * from tmpBudgetAverage;


SELECT	@varStartDT 									AS StartDT
				,@varEndDT 									AS EndDT
                ,@varLastDT 									AS LastDT
				,@varStartID 									AS StartID
				,@varEndID 									AS EndID
				,@varBudgetAverageMonthlyID		AS BudgetAverageMonthlyID
				,@varTimeSpanMonth 					AS TimeSpanMonth
				,@varSnapshotHash						AS SnapshotHash
;



/*

update snpBudgetAverageMonthly set IncomeAverage = 0;

truncate table tmpBudgetAverage;

truncate table snpBudgetAverageMonthly;

*/
