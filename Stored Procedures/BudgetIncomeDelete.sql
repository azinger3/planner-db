USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetIncomeDelete`;

DELIMITER ;;

CREATE PROCEDURE `BudgetIncomeDelete`(BudgetIncomeID INT)
BEGIN
	DECLARE BudgetNumber INT(10);
    
    SET BudgetNumber = (SELECT BudgetIncome.BudgetNumber FROM BudgetIncome BudgetIncome WHERE BudgetIncome.BudgetIncomeID = BudgetIncomeID);
	
    
	DELETE FROM	BudgetIncome
    WHERE		BudgetIncome.BudgetIncomeID = BudgetIncomeID;
    
        
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END;;
DELIMITER ;