USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetCategoryGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetCategoryGet`()
BEGIN
	SELECT		BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
	FROM		BudgetGroup BudgetGroup
    INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetGroupID = BudgetGroup.BudgetGroupID
    WHERE		BudgetGroup.ActiveFlg = 1
    AND			BudgetCategory.ActiveFlg = 1
    AND			BudgetCategory.BudgetCategoryID <> 29 -- Income
    ORDER BY	BudgetCategory.BudgetCategory ASC
    ;
END;;
DELIMITER ;