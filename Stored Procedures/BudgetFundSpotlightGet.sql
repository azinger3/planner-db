CREATE PROCEDURE `BudgetFundSpotlightGet`()
BEGIN
	DECLARE SessionID VARCHAR(100);

	SET SessionID = UUID();

	INSERT INTO tmpBudgetFundSpotlight
	(
		SessionID
		,BudgetCategoryID
		,BudgetCategory
		,Sort
        ,FundID
        ,FundName
        ,StartingBalance
	)
	SELECT 		SessionID							AS SessionID
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
				,Fund.FundID 						AS FundID
				,Fund.FundName 						AS FundName
				,Fund.StartingBalance 				AS StartingBalance
	FROM 		BudgetCategory BudgetCategory
    INNER JOIN	Fund Fund
    ON			Fund.FundID = BudgetCategory.FundID
	WHERE 		BudgetCategory.HasSpotlight = 1
	;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(ABS(Transaction.Amount))		AS FundSpent 
					FROM 		Transaction Transaction	
                    INNER JOIN	tmpBudgetFundSpotlight tmpBudgetFundSpotlight
                    ON			tmpBudgetFundSpotlight.BudgetCategoryID = Transaction.BudgetCategoryID
                    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID 
                    AND			Transaction.TransactionTypeID = 4
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetFundSpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetFundSpotlight.FundSpent = RS.FundSpent
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(Transaction.Amount)		AS FundReceived 
					FROM 		Transaction Transaction	
                    INNER JOIN	tmpBudgetFundSpotlight tmpBudgetFundSpotlight
                    ON			tmpBudgetFundSpotlight.BudgetCategoryID = Transaction.BudgetCategoryID
                    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID 
                    AND			Transaction.TransactionTypeID = 3
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetFundSpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetFundSpotlight.FundReceived = RS.FundReceived
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
	SET			tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance = IFNULL(tmpBudgetFundSpotlight.FundReceived, 0) + IFNULL(tmpBudgetFundSpotlight.StartingBalance, 0)
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
	SET			tmpBudgetFundSpotlight.FundSpentVsReceived = IFNULL(tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance, 0) - IFNULL(tmpBudgetFundSpotlight.FundSpent, 0)
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetFundSpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetFundSpotlight.FundSpentVsReceived)	AS TotalFundSpentVsReceived 
					FROM 		tmpBudgetFundSpotlight tmpBudgetFundSpotlight	
				) RS
	SET			tmpBudgetFundSpotlight.TotalFundSpentVsReceived = RS.TotalFundSpentVsReceived
    WHERE 		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
    
    SELECT 		tmpBudgetFundSpotlight.KeyID 										AS KeyID
				,tmpBudgetFundSpotlight.SessionID 									AS SessionID
				,tmpBudgetFundSpotlight.BudgetCategoryID 							AS BudgetCategoryID
				,tmpBudgetFundSpotlight.BudgetCategory 								AS BudgetCategory
				,tmpBudgetFundSpotlight.Sort 										AS Sort
				,tmpBudgetFundSpotlight.FundID 										AS FundID
				,tmpBudgetFundSpotlight.FundName 									AS FundName
				,tmpBudgetFundSpotlight.StartingBalance 							AS StartingBalance
				,IFNULL(tmpBudgetFundSpotlight.FundSpent, 0)						AS FundSpent
				,IFNULL(tmpBudgetFundSpotlight.FundReceived, 0)						AS FundReceived
				,IFNULL(tmpBudgetFundSpotlight.FundReceivedPlusStartingBalance, 0)	AS FundReceivedPlusStartingBalance
				,IFNULL(tmpBudgetFundSpotlight.FundSpentVsReceived, 0)				AS FundSpentVsReceived
				,IFNULL(tmpBudgetFundSpotlight.TotalFundSpentVsReceived, 0)			AS TotalFundSpentVsReceived
	FROM 		tmpBudgetFundSpotlight tmpBudgetFundSpotlight
    WHERE		tmpBudgetFundSpotlight.SessionID = SessionID
    ORDER BY	tmpBudgetFundSpotlight.FundName ASC
    ;

	DELETE FROM	tmpBudgetFundSpotlight 
	WHERE		tmpBudgetFundSpotlight.SessionID = SessionID
    ;
END