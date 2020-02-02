USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetAverageMonthlySnapshotHashUpdate`;

DELIMITER ;;
CREATE PROCEDURE `BudgetAverageMonthlySnapshotHashUpdate`()
BEGIN


/********************************************************************************************** 
PURPOSE:		Update Budget Average Monthly Snapshot Hash
AUTHOR:			Rob Azinger
DATE:			12/22/2019
NOTES:			Snapshot Table - snpBudgetAverageMonthly
CHANGE CONTROL:		 
***********************************************************************************************/

UPDATE		snpBudgetAverageMonthly
INNER JOIN	(
				SELECT	snpBudgetAverageMonthly.KeyID AS KeyID
						,MD5(CONCAT(
							snpBudgetAverageMonthly.BudgetAverageMonthlyID 					
							,snpBudgetAverageMonthly.IncomeActual 								
							,snpBudgetAverageMonthly.IncomeAverage 								
							,snpBudgetAverageMonthly.ExpenseActual 								
							,snpBudgetAverageMonthly.ExpenseAverage 							
							,snpBudgetAverageMonthly.TotalIncomeVsExpenseActual 		
							,snpBudgetAverageMonthly.TotalIncomeVsExpenseAverage	
						)) AS SnapshotHash 
				FROM 	snpBudgetAverageMonthly snpBudgetAverageMonthly	
			) RS
SET			snpBudgetAverageMonthly.SnapshotHash = RS.SnapshotHash
			,snpBudgetAverageMonthly.ModifyDT = NOW()
			,snpBudgetAverageMonthly.ModifyBy = 'Hash Update'
WHERE 		snpBudgetAverageMonthly.KeyID = RS.KeyID
; 



END;;
DELIMITER ;