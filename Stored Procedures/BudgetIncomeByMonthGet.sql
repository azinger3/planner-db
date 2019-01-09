CREATE PROCEDURE `BudgetIncomeByMonthGet`(BudgetMonth DATETIME)
BEGIN
    DECLARE BudgetNumber	INT(10);

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth);
       

    DROP TEMPORARY TABLE IF EXISTS tmpBudgetIncome;

	CREATE TEMPORARY TABLE tmpBudgetIncome
	(
		KeyID                   INT(10) NOT NULL AUTO_INCREMENT
        ,BudgetIncomeID			INT(10)
        ,IncomeName				VARCHAR(100)
		,IncomeTypeID			INT(10)
		,IncomeType				VARCHAR(100)
        ,PayCycleID				INT(10)
        ,PayCycle				VARCHAR(100)
        ,TakeHomePay			DECIMAL(10, 0)
        ,HourlyRate				DECIMAL(10, 2)
        ,PlannedHours			INT(10)
		,Salary					DECIMAL(10, 0)
		,YearDeduct				DECIMAL(10, 2)
        ,Sort					INT(3)
		,BudgetID               INT(10)
        ,BudgetItemID			INT(10)
		,BudgetNumber           INT(10)
		,BudgetMonth            DATETIME
		,BudgetGroupID          INT(10)
		,BudgetGroup            VARCHAR(100)
		,BudgetCategoryID       INT(10)
		,BudgetCategory         VARCHAR(100)
		,BudgetTypeID           INT(10)
		,BudgetType             VARCHAR(100)
		,ColorHighlight         VARCHAR(1000)
		,IncomeMonthly     		DECIMAL(10, 0)
		,IncomeBiWeekly    		DECIMAL(10, 0)
		,IncomeWeekly      		DECIMAL(10, 0)
		,IncomeBiYearly    		DECIMAL(10, 0)
		,IncomeYearly      		DECIMAL(10, 0)
		,TotalIncomeMonthly     DECIMAL(10, 0)
		,TotalIncomeBiWeekly    DECIMAL(10, 0)
		,TotalIncomeWeekly      DECIMAL(10, 0)
		,TotalIncomeBiYearly    DECIMAL(10, 0)
		,TotalIncomeYearly      DECIMAL(10, 0)
        ,TotalIncomeYearlyGross	DECIMAL(10, 0)
		,PRIMARY KEY (`KeyID`)
	);
    
    INSERT INTO tmpBudgetIncome
	(
		BudgetIncomeID
        ,IncomeName
		,IncomeTypeID
		,IncomeType
        ,PayCycleID
        ,PayCycle
        ,TakeHomePay
        ,HourlyRate
        ,PlannedHours
		,Salary
		,YearDeduct
        ,Sort
		,BudgetID
		,BudgetNumber
		,BudgetMonth
	)
	SELECT		BudgetIncome.BudgetIncomeID
				,BudgetIncome.IncomeName
				,BudgetIncome.IncomeTypeID
				,BudgetIncome.IncomeType
				,BudgetIncome.PayCycleID
				,BudgetIncome.PayCycle
                ,BudgetIncome.TakeHomePay
                ,BudgetIncome.HourlyRate
                ,BudgetIncome.PlannedHours
				,BudgetIncome.Salary
				,BudgetIncome.YearDeduct
                ,BudgetIncome.Sort
				,Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
    FROM		Budget Budget
    INNER JOIN	BudgetIncome BudgetIncome
    ON			BudgetIncome.BudgetNumber = Budget.BudgetNumber
    WHERE		Budget.BudgetNumber = BudgetNumber
	;
    
    
	UPDATE      tmpBudgetIncome
	INNER JOIN  (
					SELECT  	Budget.BudgetNumber
								,BudgetItem.BudgetItemID
								,BudgetGroup.BudgetGroupID
								,BudgetGroup.BudgetGroup
								,BudgetCategory.BudgetCategoryID
								,BudgetCategory.BudgetCategory
								,BudgetType.BudgetTypeID
								,BudgetType.BudgetType
								,BudgetCategory.ColorHighlight   
								,BudgetItem.Amount AS TotalIncomeMonthly
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
					AND			BudgetCategory.BudgetCategoryID = 29
				) RS
	ON          tmpBudgetIncome.BudgetNumber = RS.BudgetNumber
	SET         tmpBudgetIncome.BudgetItemID = RS.BudgetItemID
				,tmpBudgetIncome.BudgetGroupID = RS.BudgetGroupID
                ,tmpBudgetIncome.BudgetGroup = RS.BudgetGroup
                ,tmpBudgetIncome.BudgetCategoryID = RS.BudgetCategoryID
                ,tmpBudgetIncome.BudgetCategory = RS.BudgetCategory
                ,tmpBudgetIncome.BudgetTypeID = RS.BudgetTypeID
                ,tmpBudgetIncome.BudgetType = RS.BudgetType
                ,tmpBudgetIncome.ColorHighlight = RS.ColorHighlight
                ,tmpBudgetIncome.TotalIncomeMonthly = RS.TotalIncomeMonthly
    ;
    
	
	UPDATE      tmpBudgetIncome
	SET         TotalIncomeYearly = TotalIncomeMonthly * 12;


	UPDATE      tmpBudgetIncome
	SET         TotalIncomeBiWeekly = TotalIncomeYearly / 26
				,TotalIncomeWeekly = TotalIncomeYearly / 52
				,TotalIncomeBiYearly = TotalIncomeYearly / 2;
       
       
	UPDATE		tmpBudgetIncome
    INNER JOIN	(
					SELECT 	BudgetIncomeID				AS BudgetIncomeID
							,(TakeHomePay * 26) / 12 	AS IncomeMonthly
							,TakeHomePay 				AS IncomeBiWeekly
							,(TakeHomePay * 26) / 52 	AS IncomeWeekly
							,(TakeHomePay * 26) / 2 	AS IncomeBiYearly
							,(TakeHomePay * 26) 		AS IncomeYearly
					FROM	BudgetIncome
					WHERE 	BudgetIncome.BudgetNumber = BudgetNumber
				) RS
	ON			tmpBudgetIncome.BudgetIncomeID = RS.BudgetIncomeID
    SET			tmpBudgetIncome.IncomeMonthly = RS.IncomeMonthly
				,tmpBudgetIncome.IncomeBiWeekly = RS.IncomeBiWeekly
                ,tmpBudgetIncome.IncomeWeekly = RS.IncomeWeekly
                ,tmpBudgetIncome.IncomeBiYearly = RS.IncomeBiYearly
                ,tmpBudgetIncome.IncomeYearly = RS.IncomeYearly;
                
	UPDATE		tmpBudgetIncome
    SET			TotalIncomeYearlyGross = (SELECT SUM(BudgetIncome.Salary) FROM BudgetIncome BudgetIncome WHERE BudgetIncome.BudgetNumber = BudgetNumber);
                

	SELECT 		tmpBudgetIncome.KeyID                  
				,tmpBudgetIncome.BudgetIncomeID
                ,tmpBudgetIncome.IncomeName
				,tmpBudgetIncome.IncomeTypeID			
				,tmpBudgetIncome.IncomeType				
				,tmpBudgetIncome.PayCycleID				
				,tmpBudgetIncome.PayCycle				
				,tmpBudgetIncome.TakeHomePay			
				,tmpBudgetIncome.HourlyRate				
				,tmpBudgetIncome.PlannedHours			
				,tmpBudgetIncome.Salary					
				,tmpBudgetIncome.YearDeduct				
				,tmpBudgetIncome.BudgetID              
				,tmpBudgetIncome.BudgetItemID			
				,tmpBudgetIncome.BudgetNumber          
				,tmpBudgetIncome.BudgetMonth           
				,tmpBudgetIncome.BudgetGroupID
				,tmpBudgetIncome.BudgetGroup
				,tmpBudgetIncome.BudgetCategoryID
				,tmpBudgetIncome.BudgetCategory
				,tmpBudgetIncome.BudgetTypeID
				,tmpBudgetIncome.BudgetType
				,tmpBudgetIncome.ColorHighlight
				,tmpBudgetIncome.IncomeMonthly
				,tmpBudgetIncome.IncomeBiWeekly
				,tmpBudgetIncome.IncomeWeekly
				,tmpBudgetIncome.IncomeBiYearly
				,tmpBudgetIncome.IncomeYearly	
				,tmpBudgetIncome.TotalIncomeMonthly
				,tmpBudgetIncome.TotalIncomeBiWeekly
				,tmpBudgetIncome.TotalIncomeWeekly
				,tmpBudgetIncome.TotalIncomeBiYearly
				,tmpBudgetIncome.TotalIncomeYearly
                ,tmpBudgetIncome.TotalIncomeYearlyGross
	FROM 		tmpBudgetIncome tmpBudgetIncome				
	ORDER BY 	tmpBudgetIncome.Sort
				,tmpBudgetIncome.IncomeMonthly
	;
END