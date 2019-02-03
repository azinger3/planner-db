USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetGroupGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetGroupGet`()
BEGIN
	SELECT		BudgetGroupID
				,BudgetGroup
                ,Sort
                ,CreateBy
                ,CreateDT
                ,ActiveFlg
    FROM		BudgetGroup BudgetGroup
    ORDER BY	BudgetGroup.BudgetGroup
	;
END;;
DELIMITER ;