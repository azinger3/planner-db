CREATE PROCEDURE `BudgetCategorySpotlightGet`()
BEGIN
	DECLARE SessionID VARCHAR(100);
    DECLARE NowDT DATETIME;
	DECLARE StartDT DATETIME;
	DECLARE EndDT DATETIME;
    DECLARE BudgetNumber INT(10);
	
	SET SessionID = UUID();
    SET NowDT = CONVERT_TZ(NOW(), '+00:00','-05:00');
	SET StartDT = CAST(DATE_FORMAT(NowDT ,'%Y-%m-01') AS DATE);
	SET EndDT = LAST_DAY(NowDT);
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM StartDT);

	INSERT INTO tmpBudgetCategorySpotlight
	(
		SessionID
		,BudgetCategoryID
		,BudgetCategory
		,Sort
	)
	SELECT 		SessionID							AS SessionID
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.Sort				AS Sort
	FROM 		BudgetCategory BudgetCategory
    INNER JOIN	BudgetItem	BudgetItem
    ON			BudgetItem.BudgetCategoryID = BudgetCategory.BudgetCategoryID
	WHERE 		BudgetCategory.HasSpotlight = 1 
	AND 		BudgetCategory.FundID IS NULL
    AND			BudgetItem.BudgetNumber = BudgetNumber
	;
	
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		Budget.BudgetNumber	AS BudgetNumber
								,Budget.BudgetMonth	AS BudgetMonth
					FROM 		Budget Budget
                    WHERE		Budget.BudgetNumber = BudgetNumber
				) RS
	SET			tmpBudgetCategorySpotlight.BudgetNumber = RS.BudgetNumber
				,tmpBudgetCategorySpotlight.BudgetMonth = RS.BudgetMonth
	WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
    -- Category
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		BudgetItem.BudgetCategoryID	AS BudgetCategoryID
								,SUM(BudgetItem.Amount)		AS CategoryBudget 
					FROM 		BudgetItem BudgetItem
                    INNER JOIN	tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight
                    ON			tmpBudgetCategorySpotlight.BudgetCategoryID = BudgetItem.BudgetCategoryID
					AND			tmpBudgetCategorySpotlight.BudgetNumber = BudgetItem.BudgetNumber
                    WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
					GROUP BY	BudgetItem.BudgetCategoryID
				) RS
	ON			tmpBudgetCategorySpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetCategorySpotlight.CategoryBudget = RS.CategoryBudget
	WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		Transaction.BudgetCategoryID	AS BudgetCategoryID
								,SUM(Transaction.Amount)		AS CategoryActual 
					FROM 		Transaction Transaction	
                    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					GROUP BY	Transaction.BudgetCategoryID
				) RS
	ON			tmpBudgetCategorySpotlight.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetCategorySpotlight.CategoryActual = RS.CategoryActual
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryActualVsBudget = IFNULL(CategoryBudget, 0) - IFNULL(CategoryActual, 0)
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryPercentageSpent = (CategoryActual / IFNULL(CategoryBudget, 1)) * 100
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'success'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 25
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;	
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'info'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 26
    AND			tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 50
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'warning'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 51
    AND			tmpBudgetCategorySpotlight.CategoryPercentageSpent <= 75
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.CategoryProgressBarStyle = 'danger'
    WHERE 		tmpBudgetCategorySpotlight.CategoryPercentageSpent >= 76
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.IsCategoryNegativeFlg = 1
    WHERE 		tmpBudgetCategorySpotlight.CategoryActualVsBudget < 0
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
    -- Total
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryActual)	AS TotalCategoryActual 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryActual = RS.TotalCategoryActual
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryBudget)	AS TotalCategoryBudget 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryBudget = RS.TotalCategoryBudget
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
    INNER JOIN	(
					SELECT 		SUM(tmpBudgetCategorySpotlight.CategoryActualVsBudget)	AS TotalCategoryActualVsBudget 
					FROM 		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight	
				) RS
	SET			tmpBudgetCategorySpotlight.TotalCategoryActualVsBudget = RS.TotalCategoryActualVsBudget
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent = (TotalCategoryActual / IFNULL(TotalCategoryBudget, 1)) * 100
    WHERE 		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'success'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 25
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;	
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'info'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 26
    AND			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 50
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'warning'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 51
    AND			tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent <= 75
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.TotalCategoryProgressBarStyle = 'danger'
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryPercentageSpent >= 76
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	UPDATE		tmpBudgetCategorySpotlight
	SET			tmpBudgetCategorySpotlight.IsTotalCategoryNegativeFlg = 1
    WHERE 		tmpBudgetCategorySpotlight.TotalCategoryActualVsBudget < 0
    AND			tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
    
	SELECT		KeyID										AS KeyID
				,SessionID									AS SessionID
				,DATE_FORMAT(NowDT,'%M %e, %Y')				AS BudgetMonth
				,tmpBudgetCategorySpotlight.BudgetNumber	AS BudgetNumber
				,BudgetCategoryID							AS BudgetCategoryID
				,BudgetCategory								AS BudgetCategory
				,Sort										AS Sort
				,IFNULL(CategoryActual, 0)					AS CategoryActual
				,IFNULL(CategoryBudget, 0)					AS CategoryBudget
				,IFNULL(CategoryActualVsBudget, 0)			AS CategoryActualVsBudget
				,IFNULL(CategoryPercentageSpent, 0)			AS CategoryPercentageSpent
                ,CategoryProgressBarStyle					AS CategoryProgressBarStyle
                ,IsCategoryNegativeFlg						AS IsCategoryNegativeFlg
				,IFNULL(TotalCategoryActual, 0)				AS TotalCategoryActual
				,IFNULL(TotalCategoryBudget, 0)				AS TotalCategoryBudget
				,IFNULL(TotalCategoryActualVsBudget, 0)		AS TotalCategoryActualVsBudget
				,IFNULL(TotalCategoryPercentageSpent, 0)	AS TotalCategoryPercentageSpent
                ,TotalCategoryProgressBarStyle				AS TotalCategoryProgressBarStyle
                ,IsTotalCategoryNegativeFlg					AS IsTotalCategoryNegativeFlg
	FROM		tmpBudgetCategorySpotlight tmpBudgetCategorySpotlight
    WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
    ORDER BY	tmpBudgetCategorySpotlight.BudgetCategory ASC
	;
    
	DELETE FROM	tmpBudgetCategorySpotlight 
	WHERE		tmpBudgetCategorySpotlight.SessionID = SessionID
    ;
END