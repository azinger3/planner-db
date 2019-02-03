USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetCategoryByKeywordGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetCategoryByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,BudgetCategory.Description
				,BudgetCategory.Note
				,BudgetCategory.HasSpotlight
				,BudgetCategory.IsEssential
				,Fund.FundID
				,Fund.FundName
                ,CAST(Fund.StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
				,CASE WHEN Fund.FundID > 0 THEN 1 ELSE 0 END AS HasFundFlg
	FROM		BudgetCategory BudgetCategory
	INNER JOIN	BudgetGroup BudgetGroup
	ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	LEFT JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
    WHERE		BudgetGroup.ActiveFlg = 1
    AND			BudgetCategory.ActiveFlg = 1
    AND			BudgetCategory.BudgetCategoryID <> 29 -- Income
    AND			(BudgetCategory.BudgetCategory LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	BudgetCategory.BudgetCategory ASC
    ;
    

END;;
DELIMITER ;