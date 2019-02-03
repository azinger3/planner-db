USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetIncomeUpdate`;

DELIMITER ;;

CREATE PROCEDURE `BudgetIncomeUpdate`(BudgetIncomeID INT, BudgetNumber INT, IncomeName VARCHAR(100), IncomeTypeID INT, IncomeType VARCHAR(100), PayCycleID INT, PayCycle VARCHAR(100), TakeHomePay DECIMAL(10, 4), HourlyRate DECIMAL(10, 4), PlannedHours INT, Salary DECIMAL(10, 4), YearDeduct DECIMAL(10, 4))
BEGIN
	UPDATE 	BudgetIncome
	SET		BudgetIncome.BudgetNumber 	= BudgetNumber
			,BudgetIncome.IncomeName 	= IncomeName
			,BudgetIncome.IncomeTypeID 	= IncomeTypeID
			,BudgetIncome.IncomeType 	= IncomeType
			,BudgetIncome.PayCycleID 	= PayCycleID
			,BudgetIncome.PayCycle 		= PayCycle
			,BudgetIncome.TakeHomePay 	= TakeHomePay
			,BudgetIncome.HourlyRate 	= HourlyRate
			,BudgetIncome.PlannedHours 	= PlannedHours
			,BudgetIncome.Salary 		= Salary
			,BudgetIncome.YearDeduct 	= YearDeduct
			,BudgetIncome.ModifyDT 		= NOW()
			,BudgetIncome.ModifyBy 		= 'User'
	WHERE	BudgetIncome.BudgetIncomeID = BudgetIncomeID
    ;
    
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END;;
DELIMITER ;