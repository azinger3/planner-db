USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetGroupByKeywordGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetGroupByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		BudgetGroupID
				,BudgetGroup
                ,Sort
                ,CreateBy
                ,CreateDT
                ,ActiveFlg
    FROM		BudgetGroup BudgetGroup
     WHERE		(BudgetGroup.BudgetGroup LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	BudgetGroup.BudgetGroup
	;
END;;
DELIMITER ;