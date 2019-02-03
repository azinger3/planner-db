USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetItemUpdate`;

DELIMITER ;;

CREATE PROCEDURE `BudgetItemUpdate`(BudgetItemID INT, BudgetNumber INT, BudgetCategoryID INT, BudgetTypeID INT, Amount DECIMAL(10, 4))
BEGIN
	UPDATE	BudgetItem
	SET		BudgetItem.BudgetNumber			= BudgetNumber
			,BudgetItem.BudgetCategoryID	= BudgetCategoryID
			,BudgetItem.BudgetTypeID 		= BudgetTypeID
	       	,BudgetItem.Amount 				= Amount
	       	,BudgetItem.ModifyDT			= NOW()
			,BudgetItem.ModifyBy			= 'User'
	WHERE	BudgetItem.BudgetItemID = BudgetItemID
    ;
END;;
DELIMITER ;