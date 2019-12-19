USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetAverageGet`;

DELIMITER ;;
CREATE PROCEDURE `BudgetAverageGet`(StartDT DATETIME, EndDT DATETIME)
BEGIN
	DECLARE SessionID VARCHAR(100);
	DECLARE TimeSpanMonth INT;
    
    SET SessionID = UUID();
    SET TimeSpanMonth = TIMESTAMPDIFF(MONTH, StartDT, EndDT);

    INSERT INTO tmpBudgetAverage
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
    
	UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetTypeID			AS BudgetTypeID	
								,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetAverage tmpBudgetAverage	
                    ON			tmpBudgetAverage.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetAverage.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetAverage.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.BudgetTypeID = RS.BudgetTypeID
	WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		tmpBudgetAverage.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetAverage.Amount)		AS CategoryActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
					AND			tmpBudgetAverage.BudgetTypeID = 1
                    AND			tmpBudgetAverage.TransactionTypeID = 1
					GROUP BY	tmpBudgetAverage.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		tmpBudgetAverage.BudgetCategoryID	AS BudgetCategoryID
								,SUM(tmpBudgetAverage.Amount)		AS CategoryActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
					AND			tmpBudgetAverage.BudgetTypeID = 2
                    AND			tmpBudgetAverage.TransactionTypeID = 2
					GROUP BY	tmpBudgetAverage.BudgetCategoryID
				) RS
	ON			tmpBudgetAverage.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetAverage.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.CategoryAverage = IFNULL(tmpBudgetAverage.CategoryActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetAverage.Amount)	AS IncomeActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
                    AND			tmpBudgetAverage.BudgetTypeID = 1
					GROUP BY	tmpBudgetAverage.BudgetTypeID
				) RS
	SET			tmpBudgetAverage.IncomeActual = RS.IncomeActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IncomeAverage = IFNULL(tmpBudgetAverage.IncomeActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
    UPDATE		tmpBudgetAverage
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetAverage.Amount)	AS ExpenseActual 
					FROM 		tmpBudgetAverage tmpBudgetAverage	
                    WHERE 		tmpBudgetAverage.SessionID = SessionID
                    AND			tmpBudgetAverage.BudgetTypeID = 2
					GROUP BY	tmpBudgetAverage.BudgetTypeID
				) RS
	SET			tmpBudgetAverage.ExpenseActual = RS.ExpenseActual
    WHERE 		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.ExpenseAverage = IFNULL(tmpBudgetAverage.ExpenseActual, 1) / TimeSpanMonth
    WHERE		tmpBudgetAverage.SessionID = SessionID
	;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.TotalIncomeVsExpenseActual = IFNULL(tmpBudgetAverage.IncomeActual, 0) - IFNULL(tmpBudgetAverage.ExpenseActual, 0)
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.TotalIncomeVsExpenseAverage = IFNULL(tmpBudgetAverage.IncomeAverage, 0)  - IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsTotalIncomeVsExpenseActualNegative = 1
    WHERE		tmpBudgetAverage.TotalIncomeVsExpenseActual < 0
    ;
    
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsTotalIncomeVsExpenseAverageNegative = 1
    WHERE		tmpBudgetAverage.TotalIncomeVsExpenseAverage < 0
    ;
    
    -- Flags
	UPDATE		tmpBudgetAverage
    SET			tmpBudgetAverage.IsExpenseFlg = 1
    WHERE		tmpBudgetAverage.BudgetTypeID = 2
    ;
    
	SELECT 		tmpBudgetAverage.KeyID 										AS KeyID
				,tmpBudgetAverage.SessionID 								AS SessionID
				,tmpBudgetAverage.TransactionID 							AS TransactionID
				,DateMask(tmpBudgetAverage.TransactionDT) 					AS TransactionDT
				,tmpBudgetAverage.TransactionTypeID 						AS TransactionTypeID
				,tmpBudgetAverage.TransactionType 							AS TransactionType
				,tmpBudgetAverage.TransactionNumber 						AS TransactionNumber
				,tmpBudgetAverage.Description 								AS Description
				,tmpBudgetAverage.Amount 									AS Amount
				,tmpBudgetAverage.Note 										AS Note
				,tmpBudgetAverage.BudgetNumber 								AS BudgetNumber
                ,tmpBudgetAverage.BudgetTypeID 								AS BudgetTypeID
				,tmpBudgetAverage.BudgetGroupID 							AS BudgetGroupID
				,tmpBudgetAverage.BudgetGroup 								AS BudgetGroup
				,tmpBudgetAverage.BudgetCategoryID 							AS BudgetCategoryID
				,tmpBudgetAverage.BudgetCategory 							AS BudgetCategory
				,tmpBudgetAverage.Sort 										AS Sort
				,IFNULL(tmpBudgetAverage.CategoryActual, 0) 				AS CategoryActual
				,IFNULL(tmpBudgetAverage.CategoryAverage, 0) 				AS CategoryAverage
				,IFNULL(tmpBudgetAverage.IncomeActual, 0) 					AS IncomeActual
				,IFNULL(tmpBudgetAverage.IncomeAverage, 0) 					AS IncomeAverage
				,IFNULL(tmpBudgetAverage.ExpenseActual, 0) 					AS ExpenseActual
				,IFNULL(tmpBudgetAverage.ExpenseAverage, 0) 				AS ExpenseAverage
				,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseActual, 0) 	AS TotalIncomeVsExpenseActual
				,IFNULL(tmpBudgetAverage.TotalIncomeVsExpenseAverage, 0)	AS TotalIncomeVsExpenseAverage
                ,tmpBudgetAverage.IsTotalIncomeVsExpenseActualNegative		AS IsTotalIncomeVsExpenseActualNegative
                ,tmpBudgetAverage.IsTotalIncomeVsExpenseAverageNegative		AS IsTotalIncomeVsExpenseAverageNegative
                ,tmpBudgetAverage.IsExpenseFlg								AS IsExpenseFlg
	FROM 		tmpBudgetAverage tmpBudgetAverage
    WHERE		tmpBudgetAverage.SessionID = SessionID
    ORDER BY	tmpBudgetAverage.BudgetTypeID ASC
                ,tmpBudgetAverage.BudgetCategory ASC
                ,tmpBudgetAverage.TransactionDT ASC;

	DELETE FROM	tmpBudgetAverage 
    WHERE		tmpBudgetAverage.SessionID = SessionID;
END;;
DELIMITER ;