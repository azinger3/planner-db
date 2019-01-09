CREATE PROCEDURE `TransactionRecentGet`()
BEGIN
	SELECT		Transaction.TransactionID					AS TransactionID
				,Transaction.TransactionTypeID				AS TransactionTypeID
				,DateMask(Transaction.TransactionDT)		AS TransactionDT
				,Transaction.TransactionNumber				AS TransactionNumber
				,Transaction.Description					AS Description
				,CAST(Transaction.Amount AS DECIMAL(10,2)) 	AS Amount
				,Transaction.Note							AS Note
				,BudgetCategory.BudgetCategoryID			AS BudgetCategoryID
				,BudgetCategory.BudgetCategory				AS BudgetCategory
                ,Transaction.CreateBy						AS CreateBy
                ,Transaction.CreateDT						AS CreateDT
                ,Transaction.ModifyBy						AS ModifyBy
                ,Transaction.ModifyDT						AS ModifyDT
                ,Transaction.ActiveFlg						AS ActiveFlg
                ,CASE 
					WHEN Transaction.TransactionTypeID = 2 
						THEN 1
					ELSE NULL
				END 										AS IsExpenseFlg
				,CASE 
					WHEN Transaction.TransactionTypeID = 3 
						THEN 1
					ELSE NULL
				END 										AS IsSavedFlg
				,CASE 
					WHEN Transaction.TransactionTypeID = 4 
						THEN 1
					ELSE NULL
				END 										AS IsSpentFlg
	FROM		Transaction Transaction
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    WHERE		Transaction.TransactionDT > DATE_SUB(NOW(), INTERVAL 1 MONTH)
    ORDER BY	Transaction.TransactionDT DESC
				,Transaction.CreateDT DESC
                ,Transaction.TransactionID DESC
				,Transaction.Description ASC
	;
END