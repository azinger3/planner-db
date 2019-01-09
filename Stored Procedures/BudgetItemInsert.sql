CREATE PROCEDURE `BudgetItemInsert`(BudgetNumber INT, BudgetCategoryID INT, BudgetTypeID INT, Amount DECIMAL(10, 4))
BEGIN
	INSERT INTO BudgetItem
    (
		BudgetNumber
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetCategoryID
            ,BudgetTypeID
            ,Amount
            ,NOW()
            ,'User'
	;
END