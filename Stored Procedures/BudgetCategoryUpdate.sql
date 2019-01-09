CREATE PROCEDURE `BudgetCategoryUpdate`(IN BudgetCategoryID INT, IN BudgetGroupID INT, IN FundID INT, BudgetCategory VARCHAR(100), IN Description VARCHAR(1000), IN Note VARCHAR(1000), IN IsEssential INT, IN HasSpotlight INT)
BEGIN
	UPDATE 	BudgetCategory
	SET		BudgetCategory.BudgetGroupID 	= BudgetGroupID
			,BudgetCategory.FundID 			= FundID
			,BudgetCategory.BudgetCategory 	= BudgetCategory
			,BudgetCategory.Description 	= Description
			,BudgetCategory.Note 			= Note
			,BudgetCategory.IsEssential 	= IsEssential
			,BudgetCategory.HasSpotlight 	= HasSpotlight
			,BudgetCategory.ModifyDT 		= NOW()
			,BudgetCategory.ModifyBy 		= 'User'
	WHERE	BudgetCategory.BudgetCategoryID = BudgetCategoryID
    ;
END