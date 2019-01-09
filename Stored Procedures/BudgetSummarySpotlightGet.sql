CREATE PROCEDURE `BudgetSummarySpotlightGet`()
BEGIN
	SELECT 		Budget.BudgetID
				,Budget.BudgetNumber
				,Budget.BudgetMonth
				,DATE_FORMAT(Budget.BudgetMonth,'%M %Y') AS BudgetMonthSummary
                ,DATE_FORMAT(Budget.BudgetMonth,'%Y-%m-%d') AS BudgetMonthSummaryUrl
				,Budget.CreateDT
				,Budget.CreateBy
				,Budget.ModifyDT
				,Budget.ModifyBy
				,Budget.ActiveFlg
	FROM 		Budget Budget
	WHERE		TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, NOW()) <= 12
	ORDER BY	Budget.BudgetMonth DESC
    LIMIT 		13
	;
END