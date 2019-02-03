USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetIncomeDetailGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetIncomeDetailGet`(BudgetIncomeID INT)
BEGIN
	SELECT	BudgetIncome.BudgetIncomeID
			,BudgetIncome.BudgetNumber
            ,BudgetIncome.IncomeName
			,BudgetIncome.IncomeTypeID
			,BudgetIncome.IncomeType
			,BudgetIncome.PayCycleID
			,BudgetIncome.PayCycle
            ,CASE BudgetIncome.PayCycleID 
				WHEN 1 THEN 'Every 2 Weeks' 
                WHEN 2 THEN 'Every Week' 
			END AS PayCycleDescription
			,CAST(BudgetIncome.TakeHomePay AS DECIMAL(10, 0)) AS TakeHomePay
			,CAST(BudgetIncome.HourlyRate AS DECIMAL(10, 2)) AS HourlyRate
			,BudgetIncome.PlannedHours
			,CAST(BudgetIncome.Salary AS DECIMAL(10, 0)) AS Salary
			,CAST(BudgetIncome.YearDeduct AS DECIMAL(10, 2)) AS YearDeduct
			,BudgetIncome.Sort
			,BudgetIncome.CreateDT
			,BudgetIncome.CreateBy
			,BudgetIncome.ModifyDT
			,BudgetIncome.ModifyBy
			,BudgetIncome.ActiveFlg
	FROM 	BudgetIncome BudgetIncome
    WHERE	BudgetIncome.BudgetIncomeID = BudgetIncomeID
    ;
END;;
DELIMITER ;