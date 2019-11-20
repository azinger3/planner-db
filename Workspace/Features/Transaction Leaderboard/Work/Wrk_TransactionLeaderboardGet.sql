USE planner;


-- *** past month
-- top 3 transactions



SET @prmEffectiveDT = '2019-11-20';



/********************************************************************************************** 
PURPOSE:		Get Transaction Leaderboard
AUTHOR:		Rob Azinger
DATE:				11/20/2019
NOTES:			
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 01:		Create temporary structure to store parameter & scope data
***********************************************************************************************/

SET @varEffectiveDT = CONVERT_TZ(@prmEffectiveDT, '+00:00','-05:00');
SET @varStartDT = DATE_ADD(@varEffectiveDT, INTERVAL -1 MONTH);


DROP TEMPORARY TABLE IF EXISTS tmpParameter;

CREATE TEMPORARY TABLE tmpParameter
(
	KeyID                   	INT(10) NOT NULL AUTO_INCREMENT
    ,EffectiveDT			DATETIME
    ,StartDT					DATETIME
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpParameter
(
	EffectiveDT
    ,StartDT
)
SELECT 	@varEffectiveDT	AS EffectiveDT
				,@varStartDT		AS StartDT
;



/**********************************************************************************************
	Final Result
***********************************************************************************************/

SELECT 			Transaction.TransactionID					AS TransactionID
						,Transaction.TransactionTypeID			AS TransactionTypeID
						,Transaction.TransactionNumber		AS TransactionNumber
						,Transaction.TransactionDT 				AS TransactionDT
						,Transaction.BudgetNumber 				AS BudgetNumber
						,Transaction.BudgetCategoryID 			AS BudgetCategoryID
						,BudgetCategory.BudgetCategory 		AS BudgetCategory
						,BudgetGroup.BudgetGroupID 			AS BudgetGroupID
						,BudgetGroup.BudgetGroup 				AS BudgetGroup
						,Transaction.Amount 							AS Amount
						,Transaction.Description 					AS Description
						,Transaction.Note 								AS Note
						,Transaction.CreateDT 						AS CreateDT
						,Transaction.CreateBy 						AS CreateBy
						,Transaction.ModifyDT 						AS ModifyDT
						,Transaction.ModifyBy 						AS ModifyBy
						,Transaction.ActiveFlg 						AS ActiveFlg
FROM				Transaction Transaction
INNER JOIN	tmpParameter tmpParameter
ON					tmpParameter.StartDT < Transaction.TransactionDT
INNER JOIN	BudgetCategory BudgetCategory
ON					BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
INNER JOIN	BudgetGroup BudgetGroup
ON					BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
WHERE			Transaction.TransactionTypeID = 2
AND				BudgetGroup.BudgetGroupID IN 	(
																					23 -- Flexible
																				)
ORDER BY		Transaction.Amount 				DESC
						,Transaction.TransactionDT	ASC
						,Transaction.TransactionID		ASC
LIMIT				10
;



