USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetAverageMonthlySnapshotGet`;

DELIMITER ;;
CREATE PROCEDURE `BudgetAverageMonthlySnapshotGet`()
BEGIN


/********************************************************************************************** 
PURPOSE:		Get list of Budget Average Monthly Snapshots
AUTHOR:			Rob Azinger
DATE:			12/31/2019
NOTES:			Snapshot Table - snpBudgetAverageMonthly
CHANGE CONTROL:		 
***********************************************************************************************/


SELECT 	snpBudgetAverageMonthly.KeyID							AS KeyID
		,snpBudgetAverageMonthly.BudgetAverageMonthlyID			AS BudgetAverageMonthlyID	
		,snpBudgetAverageMonthly.IncomeActual					AS IncomeActual
		,snpBudgetAverageMonthly.IncomeAverage					AS IncomeAverage
		,snpBudgetAverageMonthly.ExpenseActual					AS ExpenseActual
		,snpBudgetAverageMonthly.ExpenseAverage					AS ExpenseAverage
		,snpBudgetAverageMonthly.TotalIncomeVsExpenseActual		AS TotalIncomeVsExpenseActual
		,snpBudgetAverageMonthly.TotalIncomeVsExpenseAverage	AS TotalIncomeVsExpenseAverage
		,snpBudgetAverageMonthly.SnapshotHash					AS SnapshotHash
		,snpBudgetAverageMonthly.SnapshotDT						AS SnapshotDT
		,snpBudgetAverageMonthly.CreateDT						AS CreateDT
		,snpBudgetAverageMonthly.CreateBy						AS CreateBy
		,snpBudgetAverageMonthly.ModifyDT						AS ModifyDT
		,snpBudgetAverageMonthly.ModifyBy						AS ModifyBy
		,snpBudgetAverageMonthly.ActiveFlg						AS ActiveFlg
FROM 	snpBudgetAverageMonthly snpBudgetAverageMonthly;

END;;
DELIMITER ;
