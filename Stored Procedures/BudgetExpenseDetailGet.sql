CREATE PROCEDURE `BudgetExpenseDetailGet`(BudgetItemID INT)
BEGIN
	SELECT		BudgetItem.BudgetItemID
				,BudgetItem.BudgetNumber
				,BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,CAST(BudgetItem.Amount AS DECIMAL(10, 0)) AS Amount
				,BudgetCategory.Description
				,BudgetCategory.Note
				,BudgetCategory.HasSpotlight
				,BudgetCategory.IsEssential
				,Fund.FundID
				,Fund.FundName
                ,CAST(Fund.StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
				,CASE WHEN Fund.FundID > 0 THEN 1 ELSE 0 END AS HasFundFlg
	FROM		BudgetItem BudgetItem
	INNER JOIN	BudgetCategory BudgetCategory
	ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
	INNER JOIN	BudgetGroup BudgetGroup
	ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	LEFT JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
	WHERE		BudgetItem.BudgetItemID = BudgetItemID
	;
END