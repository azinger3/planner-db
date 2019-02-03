USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetGroupUpdate`;

DELIMITER ;;

CREATE PROCEDURE `BudgetGroupUpdate`(BudgetGroupID INT, BudgetGroup VARCHAR(100))
BEGIN
	UPDATE	BudgetGroup
    SET		BudgetGroup.BudgetGroup 	= BudgetGroup
			,BudgetGroup.ModifyDT		= NOW()
            ,BudgetGroup.ModifyBy		= 'User'
	WHERE	BudgetGroup.BudgetGroupID = BudgetGroupID
    ;
END;;
DELIMITER ;