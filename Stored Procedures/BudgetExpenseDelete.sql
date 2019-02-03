USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetExpenseDelete`;

DELIMITER ;;

CREATE PROCEDURE `BudgetExpenseDelete`(BudgetItemID INT)
BEGIN
	DELETE FROM	BudgetItem
    WHERE		BudgetItem.BudgetItemID = BudgetItemID
    ;
END;;
DELIMITER ;