USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetByMonthDelete`;

DELIMITER ;;

CREATE PROCEDURE `BudgetByMonthDelete`(BudgetNumber INT)
BEGIN
	DELETE FROM	Budget 
    WHERE		Budget.BudgetNumber = BudgetNumber
    ;
    
    DELETE FROM BudgetItem
    WHERE		BudgetItem.BudgetNumber = BudgetNumber
    ;
    
    DELETE FROM	BudgetIncome
    WHERE		BudgetIncome.BudgetNumber = BudgetNumber
    ;
END;;
DELIMITER ;