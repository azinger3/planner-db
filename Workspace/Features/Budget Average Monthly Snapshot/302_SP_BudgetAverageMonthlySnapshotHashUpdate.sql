USE `planner`;



DROP PROCEDURE IF EXISTS `BudgetAverageMonthlySnapshotHashUpdate`;

DELIMITER ;;
CREATE PROCEDURE `BudgetAverageMonthlySnapshotHashUpdate`(prmStartDT DATETIME, prmEndDT DATETIME)
BEGIN


/********************************************************************************************** 
PURPOSE:		Update Budget Average Monthly Snapshot Hashes
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
WHERE 		snpBudgetAverageMonthly.KeyID = RS.KeyID
; 



END;;
DELIMITER ;