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
END