USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetItemDelete`;

DELIMITER ;;

CREATE PROCEDURE `BudgetItemDelete`(BudgetItemID INT)
BEGIN
	DELETE FROM	BudgetItem
    WHERE		BudgetItem.BudgetItemID = BudgetItemID
    ;
END;;
DELIMITER ;