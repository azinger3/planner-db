CREATE PROCEDURE `BudgetExpenseByMonthGet`(BudgetMonth DATETIME)
BEGIN    

	DECLARE BudgetNumber	INT(10);
    DECLARE MonthNumber		INT(10);
    DECLARE MonthInterval	INT(10);
    DECLARE StartDT			DATETIME;
    DECLARE EndDT			DATETIME;

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
	SET MonthNumber = MonthNumberGet(NOW());
	SET MonthInterval = (MonthNumber * -1) + 1;
    
	SET StartDT = DATE_ADD(CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') AS DATE), INTERVAL MonthInterval MONTH);
	SET EndDT = LAST_DAY(NOW());


    DROP TEMPORARY TABLE IF EXISTS tmpBudget;

	CREATE TEMPORARY TABLE tmpBudget
	(
		KeyID                   	INT(10) NOT NULL AUTO_INCREMENT
		,BudgetItemID           	INT(10)
		,BudgetID               	INT(10)
		,BudgetNumber           	INT(10)
		,BudgetMonth            	DATETIME
		,BudgetGroupID          	INT(10)
		,BudgetGroup            	VARCHAR(100)
		,BudgetCategoryID       	INT(10)
		,BudgetCategory         	VARCHAR(100)
		,BudgetTypeID           	INT(10)
		,BudgetType             	VARCHAR(100)
		,Note                   	VARCHAR(1000)
		,Description            	VARCHAR(1000)
		,IsEssential            	INT(1)
		,HasSpotlight           	INT(1)
		,ColorHighlight         	VARCHAR(1000)
		,FundID                 	INT(10)
		,Percentage             	DECIMAL(10, 2)
		,AmountMonthly          	DECIMAL(10, 0)
		,AmountBiWeekly         	DECIMAL(10, 0)
		,AmountWeekly           	DECIMAL(10, 0)
		,AmountBiYearly         	DECIMAL(10, 0)
		,AmountYearly           	DECIMAL(10, 0)        
		,TotalIncomeMonthly     	DECIMAL(10, 0)
		,TotalIncomeBiWeekly    	DECIMAL(10, 0)
		,TotalIncomeWeekly      	DECIMAL(10, 0)
		,TotalIncomeBiYearly    	DECIMAL(10, 0)
		,TotalIncomeYearly      	DECIMAL(10, 0)
		,TotalExpenseMonthly    	DECIMAL(10, 0)
		,TotalExpenseBiWeekly   	DECIMAL(10, 0)
		,TotalExpenseWeekly     	DECIMAL(10, 0)
		,TotalExpenseBiYearly   	DECIMAL(10, 0)
		,TotalExpenseYearly     	DECIMAL(10, 0)
		,BalanceMonthly         	DECIMAL(10, 0)
		,BalanceBiWeekly        	DECIMAL(10, 0)
		,BalanceWeekly          	DECIMAL(10, 0)
		,BalanceBiYearly        	DECIMAL(10, 0)
		,BalanceYearly          	DECIMAL(10, 0)
        ,TransactionActual			DECIMAL(10, 2)
		,TransactionAverage			DECIMAL(10, 2)
        ,RANK						INT(10)
        ,IsBalanceMonthlyNegative	INT(1)
		,PRIMARY KEY (`KeyID`)
	);

	INSERT INTO tmpBudget
	(
		BudgetItemID
		,BudgetID
		,BudgetNumber
		,BudgetMonth
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,BudgetTypeID
		,BudgetType
		,Note
		,Description
		,IsEssential
		,HasSpotlight
		,ColorHighlight
		,FundID
		,AmountMonthly
	)
	SELECT      BudgetItem.BudgetItemID
				,Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
				,BudgetGroup.BudgetGroupID
				,BudgetGroup.BudgetGroup
				,BudgetCategory.BudgetCategoryID
				,BudgetCategory.BudgetCategory
				,BudgetType.BudgetTypeID
				,BudgetType.BudgetType
				,BudgetCategory.Note
				,BudgetCategory.Description
				,BudgetCategory.IsEssential
				,BudgetCategory.HasSpotlight
				,BudgetCategory.ColorHighlight
				,BudgetCategory.FundID
				,BudgetItem.Amount AS AmountMonthly
	FROM        Budget Budget
	INNER JOIN  BudgetItem BudgetItem
	ON          Budget.BudgetNumber = BudgetItem.BudgetNumber
	INNER JOIN  BudgetType BudgetType
	ON          BudgetType.BudgetTypeID = BudgetItem.BudgetTypeID
	INNER JOIN  BudgetCategory BudgetCategory
	ON          BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
	INNER JOIN  BudgetGroup BudgetGroup
	ON          BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
	WHERE       Budget.BudgetNumber = BudgetNumber
    AND			Budget.ActiveFlg = 1
    ORDER BY	BudgetItem.Amount DESC
	;



	UPDATE      tmpBudget
	INNER JOIN  (
				  SELECT      BudgetItem.BudgetItemID
							  ,BudgetItem.Amount * 12 AS AmountYearly
				  FROM        Budget Budget
				  INNER JOIN  BudgetItem BudgetItem
				  ON          Budget.BudgetNumber = BudgetItem.BudgetNumber
				  WHERE       Budget.BudgetNumber = BudgetNumber
				) RS
	ON          tmpBudget.BudgetItemID = RS.BudgetItemID
	SET         tmpBudget.AmountYearly = RS.AmountYearly
	;



	UPDATE      tmpBudget
	SET         AmountBiWeekly = AmountYearly / 26
				,AmountWeekly = AmountYearly / 52
				,AmountBiYearly = AmountYearly / 2
	;



	UPDATE      tmpBudget
	SET         TotalIncomeMonthly = (
										SELECT      SUM(Amount) AS IncomeTotal
										FROM        Budget Budget
										INNER JOIN  BudgetItem BudgetItem ON Budget.BudgetNumber = BudgetItem.BudgetNumber
										WHERE       BudgetTypeID = 1
										AND         Budget.BudgetNumber = BudgetNumber
										)
	;



	UPDATE      tmpBudget
	SET         TotalIncomeYearly = TotalIncomeMonthly * 12
    ;



	UPDATE      tmpBudget
	SET         TotalIncomeBiWeekly = TotalIncomeYearly / 26
				,TotalIncomeWeekly = TotalIncomeYearly / 52
				,TotalIncomeBiYearly = TotalIncomeYearly / 2
	;



	UPDATE      tmpBudget
	SET         TotalExpenseMonthly = (
										SELECT      SUM(Amount) AS ExpenseTotal
										FROM        Budget Budget
										INNER JOIN  BudgetItem BudgetItem ON Budget.BudgetNumber = BudgetItem.BudgetNumber
										WHERE       BudgetTypeID = 2
										AND         Budget.BudgetNumber = BudgetNumber
										)
	;



	UPDATE      tmpBudget
	SET         TotalExpenseYearly = TotalExpenseMonthly * 12
    ;



	UPDATE      tmpBudget
	SET         TotalExpenseBiWeekly = TotalExpenseYearly / 26
				,TotalExpenseWeekly = TotalExpenseYearly / 52
				,TotalExpenseBiYearly = TotalExpenseYearly / 2
	;



	UPDATE      tmpBudget
	SET         BalanceMonthly = TotalIncomeMonthly - TotalExpenseMonthly
				,BalanceBiWeekly = TotalIncomeBiWeekly - TotalExpenseBiWeekly
				,BalanceWeekly = TotalIncomeWeekly - TotalExpenseWeekly
				,BalanceBiYearly = TotalIncomeBiYearly - TotalExpenseBiYearly
				,BalanceYearly = TotalIncomeYearly - TotalExpenseYearly
	;



	UPDATE      tmpBudget
	SET         Percentage = (AmountYearly / TotalIncomeYearly) * 100
    ;
    
    
    
    SET @i = 0;
    UPDATE		tmpBudget
    INNER JOIN	(	
					SELECT  RSRank.Amount
							,RSRank.BudgetItemID
							,RSRank.BudgetCategory
							,RSRank.RANK
					FROM
					(
						SELECT  RSBudgetItem.Amount
								,RSBudgetItem.BudgetItemID
								,RSBudgetItem.BudgetCategory
								,@i :=  @i + 1 AS RANK
						FROM
						(
							SELECT  	BudgetItem.Amount
										,BudgetItem.BudgetItemID
										,BudgetCategory.BudgetCategory
							FROM    	BudgetItem BudgetItem
							INNER JOIN	BudgetCategory BudgetCategory
							ON			BudgetCategory.BudgetCategoryID = BudgetItem.BudgetCategoryID
							WHERE		BudgetItem.BudgetNumber = BudgetNumber
							AND			BudgetTypeID = 2
							ORDER BY	BudgetItem.Amount 			DESC
										,BudgetItem.BudgetItemID 	ASC
						) RSBudgetItem
					) RSRank
				) RS
    ON			tmpBudget.BudgetItemID = RS.BudgetItemID
    SET			tmpBudget.RANK = RS.RANK
	;
    
    
    
	UPDATE		tmpBudget
    INNER JOIN	(	
					SELECT		Transaction.BudgetCategoryID
								,IFNULL(SUM(Transaction.Amount), 0) AS TransactionActual
					FROM		Transaction Transaction
					WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					AND			Transaction.TransactionTypeID IN (2)
					GROUP BY	Transaction.BudgetCategoryID
				) RS
    ON			tmpBudget.BudgetCategoryID = RS.BudgetCategoryID
    SET			tmpBudget.TransactionActual = RS.TransactionActual
	;
    
    
    
    UPDATE		tmpBudget
    SET			TransactionAverage = tmpBudget.TransactionActual / MonthNumber
    ;
    
	UPDATE		tmpBudget
    SET			tmpBudget.IsBalanceMonthlyNegative = 1
    WHERE		tmpBudget.BalanceMonthly < 0
    ;
    

	DELETE FROM	tmpBudget
    WHERE		tmpBudget.BudgetCategoryID = 29
    ;
    
	SELECT 		tmpBudget.KeyID
				,tmpBudget.BudgetItemID
				,tmpBudget.BudgetID
				,tmpBudget.BudgetNumber
				,tmpBudget.BudgetMonth
				,tmpBudget.BudgetGroupID
				,tmpBudget.BudgetGroup
				,tmpBudget.BudgetCategoryID
				,tmpBudget.BudgetCategory
				,tmpBudget.BudgetTypeID
				,tmpBudget.BudgetType
				,tmpBudget.Note
				,tmpBudget.Description
				,tmpBudget.IsEssential
				,tmpBudget.HasSpotlight
				,tmpBudget.ColorHighlight
				,tmpBudget.FundID
				,tmpBudget.Percentage
                ,IFNULL(tmpBudget.AmountMonthly, 0) 	AS AmountMonthly
                ,IFNULL(tmpBudget.AmountBiWeekly, 0) 	AS AmountBiWeekly
                ,IFNULL(tmpBudget.AmountWeekly, 0) 		AS AmountWeekly
                ,IFNULL(tmpBudget.AmountBiYearly, 0) 	AS AmountBiYearly
                ,IFNULL(tmpBudget.AmountYearly, 0) 		AS AmountYearly
				,tmpBudget.TotalIncomeMonthly
				,tmpBudget.TotalIncomeBiWeekly
				,tmpBudget.TotalIncomeWeekly
				,tmpBudget.TotalIncomeBiYearly
				,tmpBudget.TotalIncomeYearly
				,tmpBudget.TotalExpenseMonthly
				,tmpBudget.TotalExpenseBiWeekly
				,tmpBudget.TotalExpenseWeekly
				,tmpBudget.TotalExpenseBiYearly
				,tmpBudget.TotalExpenseYearly
				,tmpBudget.BalanceMonthly
				,tmpBudget.BalanceBiWeekly
				,tmpBudget.BalanceWeekly
				,tmpBudget.BalanceBiYearly
				,tmpBudget.BalanceYearly
                ,tmpBudget.TransactionActual
                ,IFNULL(tmpBudget.TransactionAverage, 0) AS TransactionAverage
                ,tmpBudget.RANK
                ,tmpBudget.IsBalanceMonthlyNegative
	FROM 		tmpBudget tmpBudget				
	ORDER BY 	tmpBudget.BudgetGroup
				,tmpBudget.BudgetCategory
	;
    
END