USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetSummaryGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetSummaryGet`(BudgetMonth DATETIME)
BEGIN

    DECLARE SessionID VARCHAR(100);
    DECLARE StartDT DATETIME;
    DECLARE EndDT DATETIME;
    DECLARE BudgetNumber INT(10);
    
    SET SessionID = UUID();
	SET StartDT = CAST(DATE_FORMAT(BudgetMonth ,'%Y-%m-01') AS DATE);
	SET EndDT = LAST_DAY(BudgetMonth);
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);    

	INSERT INTO tmpBudgetSummary
	(
		SessionID
		,TransactionID
		,TransactionDT
		,TransactionTypeID
		,TransactionType
		,TransactionNumber
		,Description
		,Amount
		,Note
		,BudgetNumber
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
    SELECT		SessionID							AS SessionID
				,Transaction.TransactionID			AS TransactionID
				,Transaction.TransactionDT			AS TransactionDT
				,TransactionType.TransactionTypeID	AS TransactionTypeID
				,TransactionType.TransactionType	AS TransactionType
				,Transaction.TransactionNumber		AS TransactionNumber
				,Transaction.Description			AS Description
				,Transaction.Amount					AS Amount
				,Transaction.Note					AS Note
                ,Transaction.BudgetNumber			AS BudgetNumber
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
	FROM		Transaction Transaction
    INNER JOIN	TransactionType TransactionType
    ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
    AND			Transaction.TransactionTypeID IN (1, 2)
	;
   
    INSERT INTO tmpBudgetSummary
	(
		SessionID
		,BudgetNumber
        ,CategoryActual
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
	SELECT		SessionID							AS SessionID
				,BudgetItem.BudgetNumber			AS BudgetNumber
                ,0									AS CategoryActual
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
    FROM 		BudgetItem BudgetItem
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		BudgetItem.BudgetNumber = BudgetNumber
    AND			BudgetItem.Amount > 0
    AND			BudgetItem.BudgetCategoryID NOT IN 	(
														SELECT 	tmpBudgetSummary.BudgetCategoryID 
                                                        FROM 	tmpBudgetSummary tmpBudgetSummary
													)
	;
	    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetTypeID			AS BudgetTypeID	
								,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
								,BudgetItem.Amount				AS CategoryBudget 
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetSummary tmpBudgetSummary	
                    ON			tmpBudgetSummary.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetSummary.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetSummary.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryBudget = RS.CategoryBudget
				,tmpBudgetSummary.BudgetTypeID = RS.BudgetTypeID
	WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		tmpBudgetSummary.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetSummary.Amount)		AS CategoryActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
					AND			tmpBudgetSummary.BudgetTypeID = 1
                    AND			tmpBudgetSummary.TransactionTypeID = 1
					GROUP BY	tmpBudgetSummary.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		tmpBudgetSummary.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetSummary.Amount)		AS CategoryActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
					AND			tmpBudgetSummary.BudgetTypeID = 2
                    AND			tmpBudgetSummary.TransactionTypeID = 2
					GROUP BY	tmpBudgetSummary.BudgetCategoryID
				) RS
	ON			tmpBudgetSummary.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetSummary.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.CategoryActualVsBudget = IFNULL(tmpBudgetSummary.CategoryActual, 0) - IFNULL(tmpBudgetSummary.CategoryBudget, 0)
    WHERE		tmpBudgetSummary.BudgetTypeID = 1
    AND			tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.CategoryActualVsBudget = IFNULL(tmpBudgetSummary.CategoryBudget, 0) - IFNULL(tmpBudgetSummary.CategoryActual, 0)
    WHERE		tmpBudgetSummary.BudgetTypeID = 2
    AND			tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetSummary.Amount)	AS IncomeActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
                    AND			tmpBudgetSummary.BudgetTypeID = 1
                    AND			tmpBudgetSummary.TransactionTypeID = 1
					GROUP BY	tmpBudgetSummary.BudgetTypeID
				) RS
	SET			tmpBudgetSummary.IncomeActual = RS.IncomeActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(rsBudgetSummary.CategoryBudget)	AS IncomeBudget 
					FROM 		(
									SELECT	DISTINCT
											tmpBudgetSummary.CategoryBudget	AS CategoryBudget
									FROM	tmpBudgetSummary tmpBudgetSummary
                                    WHERE 	tmpBudgetSummary.SessionID = SessionID
                                    AND 	tmpBudgetSummary.BudgetTypeID = 1
								) rsBudgetSummary
				) RS
	SET			tmpBudgetSummary.IncomeBudget = RS.IncomeBudget
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IncomeActualVsBudget = IFNULL(tmpBudgetSummary.IncomeActual, 0) - IFNULL(tmpBudgetSummary.IncomeBudget, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetSummary.Amount)	AS ExpenseActual 
					FROM 		tmpBudgetSummary tmpBudgetSummary	
                    WHERE 		tmpBudgetSummary.SessionID = SessionID
                    AND			tmpBudgetSummary.BudgetTypeID = 2
                    AND			tmpBudgetSummary.TransactionTypeID = 2
					GROUP BY	tmpBudgetSummary.BudgetTypeID
				) RS
	SET			tmpBudgetSummary.ExpenseActual = RS.ExpenseActual
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    INNER JOIN	(
					SELECT 		SUM(rsBudgetSummary.CategoryBudget)	AS ExpenseBudget 
					FROM 		(
									SELECT	DISTINCT
											tmpBudgetSummary.CategoryBudget	AS CategoryBudget
                                            ,tmpBudgetSummary.BudgetCategoryID AS BudgetCategoryID
									FROM	tmpBudgetSummary tmpBudgetSummary
                                    WHERE 	tmpBudgetSummary.SessionID = SessionID
                                    AND 	tmpBudgetSummary.BudgetTypeID = 2
								) rsBudgetSummary
				) RS
	SET			tmpBudgetSummary.ExpenseBudget = RS.ExpenseBudget
    WHERE 		tmpBudgetSummary.SessionID = SessionID
    ;

	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.ExpenseActualVsBudget = IFNULL(tmpBudgetSummary.ExpenseBudget, 0) - IFNULL(tmpBudgetSummary.ExpenseActual, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    -- Final totals
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseActual = IFNULL(tmpBudgetSummary.IncomeActual, 0) - IFNULL(tmpBudgetSummary.ExpenseActual, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseBudget = IFNULL(tmpBudgetSummary.IncomeBudget, 0) - IFNULL(tmpBudgetSummary.ExpenseBudget, 0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget = IFNULL(tmpBudgetSummary.IncomeActualVsBudget, 0) + IFNULL(tmpBudgetSummary.ExpenseActualVsBudget ,0)
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;
    
    -- Negative flags
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsCategoryActualVsBudgetNegative = 1
    WHERE		tmpBudgetSummary.CategoryActualVsBudget < 0
    ;
    
    UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseActualNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseActual < 0
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseBudgetNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseBudget < 0
    ;
    
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsTotalIncomeVsExpenseActualVsBudgetNegative = 1
    WHERE		tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget < 0
    ;
    
    -- Flags
	UPDATE		tmpBudgetSummary
    SET			tmpBudgetSummary.IsExpenseFlg = 1
    WHERE		tmpBudgetSummary.BudgetTypeID = 2
    ;
    
	SELECT 		tmpBudgetSummary.KeyID 											AS KeyID
				,tmpBudgetSummary.SessionID 									AS SessionID
				,tmpBudgetSummary.TransactionID 								AS TransactionID
				,DateMask(tmpBudgetSummary.TransactionDT) 						AS TransactionDT
				,tmpBudgetSummary.TransactionTypeID 							AS TransactionTypeID
				,tmpBudgetSummary.TransactionType 								AS TransactionType
				,tmpBudgetSummary.TransactionNumber 							AS TransactionNumber
				,tmpBudgetSummary.Description 									AS Description
				,tmpBudgetSummary.Amount 										AS Amount
				,tmpBudgetSummary.Note 											AS Note
                ,DATE_FORMAT(BudgetMonth,'%M %Y') 								AS BudgetMonth
				,tmpBudgetSummary.BudgetNumber 									AS BudgetNumber
                ,tmpBudgetSummary.BudgetTypeID 									AS BudgetTypeID
				,tmpBudgetSummary.BudgetGroupID 								AS BudgetGroupID
				,tmpBudgetSummary.BudgetGroup 									AS BudgetGroup
				,tmpBudgetSummary.BudgetCategoryID 								AS BudgetCategoryID
				,tmpBudgetSummary.BudgetCategory 								AS BudgetCategory
				,tmpBudgetSummary.Sort 											AS Sort
				,IFNULL(tmpBudgetSummary.CategoryActual, 0) 					AS CategoryActual
				,IFNULL(tmpBudgetSummary.CategoryBudget, 0) 					AS CategoryBudget
				,IFNULL(tmpBudgetSummary.CategoryActualVsBudget, 0) 			AS CategoryActualVsBudget
				,IFNULL(tmpBudgetSummary.IncomeActual, 0) 						AS IncomeActual
				,IFNULL(tmpBudgetSummary.IncomeBudget, 0) 						AS IncomeBudget
				,IFNULL(tmpBudgetSummary.IncomeActualVsBudget, 0) 				AS IncomeActualVsBudget
				,IFNULL(tmpBudgetSummary.ExpenseActual, 0) 						AS ExpenseActual
				,IFNULL(tmpBudgetSummary.ExpenseBudget, 0) 						AS ExpenseBudget
				,IFNULL(tmpBudgetSummary.ExpenseActualVsBudget, 0) 				AS ExpenseActualVsBudget
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseActual, 0) 		AS TotalIncomeVsExpenseActual
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseBudget, 0) 		AS TotalIncomeVsExpenseBudget
				,IFNULL(tmpBudgetSummary.TotalIncomeVsExpenseActualVsBudget, 0)	AS TotalIncomeVsExpenseActualVsBudget
                ,tmpBudgetSummary.IsCategoryActualVsBudgetNegative				AS IsCategoryActualVsBudgetNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseActualNegative			AS IsTotalIncomeVsExpenseActualNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseBudgetNegative			AS IsTotalIncomeVsExpenseBudgetNegative
                ,tmpBudgetSummary.IsTotalIncomeVsExpenseActualVsBudgetNegative	AS IsTotalIncomeVsExpenseActualVsBudgetNegative
                ,tmpBudgetSummary.IsExpenseFlg									AS IsExpenseFlg
	FROM 		tmpBudgetSummary tmpBudgetSummary
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ORDER BY	tmpBudgetSummary.BudgetTypeID ASC
                ,tmpBudgetSummary.BudgetCategory ASC
                ,tmpBudgetSummary.TransactionDT ASC
	;

	DELETE FROM	tmpBudgetSummary 
    WHERE		tmpBudgetSummary.SessionID = SessionID
    ;


END;;
DELIMITER ;