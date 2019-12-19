USE `planner`;

-- DROP PROCEDURE IF EXISTS `BudgetAverageMonthlyGenerate`;

-- DELIMITER ;;
-- CREATE PROCEDURE `BudgetAverageMonthlyGenerate`(prmEffectiveDT DATETIME)
-- BEGIN


SET @prmStartDT = '2019-04-01';
SET @prmEndDT = '2019-07-01';


/********************************************************************************************** 
PURPOSE:		Get Budget Average Monthly Snapshot
AUTHOR:		Rob Azinger
DATE:				12/19/2019
NOTES:			Snapshot Table - tmpTransactionSpotlight
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 01:		Create temporary structure to store parameter & scope data
***********************************************************************************************/

SET @varStartDT = @prmStartDT;
SET @varEndDT = @prmEndDT;


DROP TEMPORARY TABLE IF EXISTS tmpParameter;

CREATE TEMPORARY TABLE tmpParameter
(
	KeyID										INT(10) NOT NULL AUTO_INCREMENT
    ,StartDT									DATETIME
	,EndDT									DATETIME
	,StartID									VARCHAR(10)
	,EndID										VARCHAR(10)
	,BudgetAverageMonthlyID		VARCHAR(20)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpParameter
(
	StartDT
    ,EndDT
)
SELECT 	@varStartDT 	AS StartDT
				,@varEndDT	AS EndDT
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


select * from tmpParameter;



/**********************************************************************************************
	STEP 02:		Get base Budget Average Monthly data
***********************************************************************************************/

DROP TEMPORARY TABLE IF EXISTS tmpBudgetAverageMonthly;

CREATE TEMPORARY TABLE tmpBudgetAverageMonthly
(
	KeyID 																INT(10)
	,SessionID 														VARCHAR(100) 
	,TransactionID 												INT(10) 
	,TransactionDT 												DATETIME 
	,TransactionTypeID 										INT(10) 
	,TransactionType 											VARCHAR(100) 
	,TransactionNumber 										VARCHAR(100) 
	,Description 													VARCHAR(1000) 
	,Amount 															DECIMAL(10,2) 
	,Note 																VARCHAR(1000) 
	,BudgetNumber 												INT(10) 
	,BudgetTypeID 												INT(10) 
	,BudgetGroupID 												INT(10) 
	,BudgetGroup 													VARCHAR(100) 
	,BudgetCategoryID 										INT(10) 
	,BudgetCategory 											VARCHAR(100) 
	,Sort 																INT(3) 
	,CategoryActual 												DECIMAL(10,2) 
	,CategoryAverage 											DECIMAL(10,2) 
	,IncomeActual 												DECIMAL(10,2) 
	,IncomeAverage 												DECIMAL(10,2) 
	,ExpenseActual 												DECIMAL(10,2) 
	,ExpenseAverage 											DECIMAL(10,2) 
	,TotalIncomeVsExpenseActual 						DECIMAL(10,2) 
	,TotalIncomeVsExpenseAverage 					DECIMAL(10,2) 
	,IsTotalIncomeVsExpenseActualNegative 		INT(1) 
	,IsTotalIncomeVsExpenseAverageNegative 	INT(1) 
	,IsExpenseFlg 												INT(1)
	,PRIMARY KEY (`KeyID`)
);


INSERT INTO tmpBudgetAverageMonthly
(
	KeyID 									
	,SessionID 								
	,TransactionID 							
	,TransactionDT 							
	,TransactionTypeID 						
	,TransactionType 							
	,TransactionNumber 						
	,Description 								
	,Amount 									
	,Note 									
	,BudgetNumber 							
	,BudgetTypeID 							
	,BudgetGroupID 							
	,BudgetGroup 								
	,BudgetCategoryID 						
	,BudgetCategory 							
	,Sort 									
	,CategoryActual 							
	,CategoryAverage 							
	,IncomeActual 							
	,IncomeAverage 							
	,ExpenseActual 							
	,ExpenseAverage 							
	,TotalIncomeVsExpenseActual 				
	,TotalIncomeVsExpenseAverage 				
	,IsTotalIncomeVsExpenseActualNegative 	
	,IsTotalIncomeVsExpenseAverageNegative 	
	,IsExpenseFlg 							
)
CALL BudgetAverageGet (
	/*StartDT*/ '2019-04-01'
    ,/*EndDT*/ '2019-07-01'
);


select * from tmpBudgetAverageMonthly;





