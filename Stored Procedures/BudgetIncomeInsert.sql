CREATE PROCEDURE `BudgetIncomeInsert`(BudgetNumber INT, IncomeName VARCHAR(100), IncomeTypeID INT, IncomeType VARCHAR(100), PayCycleID INT, PayCycle VARCHAR(100), TakeHomePay DECIMAL(10, 4), HourlyRate DECIMAL(10, 4), PlannedHours INT, Salary DECIMAL(10, 4), YearDeduct DECIMAL(10, 4))
BEGIN
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
		,CreateDT
		,CreateBy
	)
	SELECT	BudgetNumber
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
			,NOW()
			,'User'
	;
    
    
    CALL BudgetIncomeCalculate(BudgetNumber);
END