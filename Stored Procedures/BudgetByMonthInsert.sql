CREATE PROCEDURE `BudgetByMonthInsert`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetNumberPrevious INT;
    DECLARE BudgetIDNew INT;
    DECLARE BudgetNumber INT(10);
    
    SET BudgetNumberPrevious = (SELECT Budget.BudgetNumber FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, DATE_ADD(BudgetMonth, INTERVAL -1 MONTH)) = 0);
    SET BudgetNumber =  EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
    
    INSERT INTO Budget
    (
		BudgetNumber
        ,BudgetMonth
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetMonth
            ,NOW()
            ,'User'
	FROM DUAL
	WHERE NOT EXISTS (SELECT Budget.BudgetNumber FROM Budget Budget WHERE Budget.BudgetNumber = BudgetNumber)
    ;

    SET BudgetIDNew = LAST_INSERT_ID();
    
    
	INSERT INTO BudgetItem
    (
		BudgetNumber
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,Sort
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber					AS BudgetNumber
            ,BudgetItem.BudgetCategoryID	AS BudgetCategoryID
            ,BudgetItem.BudgetTypeID		AS BudgetTypeID
            ,BudgetItem.Amount				AS Amount
            ,BudgetItem.Sort				AS Sort
            ,NOW()							AS CreateDT
            ,'User'							AS CreateBy
    FROM 	BudgetItem BudgetItem
    WHERE	BudgetItem.BudgetNumber = BudgetNumberPrevious 
    AND 	BudgetNumberPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
    INSERT INTO BudgetIncome
    (
		BudgetNumber
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
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber					AS BudgetNumber
            ,BudgetIncome.IncomeName		AS IncomeName
            ,BudgetIncome.IncomeTypeID		AS IncomeTypeID
            ,BudgetIncome.IncomeType		AS IncomeType
            ,BudgetIncome.PayCycleID		AS PayCycleID
            ,BudgetIncome.PayCycle			AS PayCycle
            ,BudgetIncome.TakeHomePay		AS TakeHomePay
            ,BudgetIncome.HourlyRate		AS HourlyRate
            ,BudgetIncome.PlannedHours		AS PlannedHours
            ,BudgetIncome.Salary			AS Salary
            ,BudgetIncome.YearDeduct		AS YearDeduct
            ,BudgetIncome.Sort				AS Sort
            ,NOW()							AS CreateDT
            ,'User'							AS CreateBy
    FROM 	BudgetIncome BudgetIncome
    WHERE	BudgetIncome.BudgetNumber = BudgetNumberPrevious 
    AND 	BudgetNumberPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
    
END