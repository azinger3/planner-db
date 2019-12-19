USE planner;


DROP TABLE IF EXISTS snpBudgetAverageMonthly;

CREATE TABLE snpBudgetAverageMonthly
(
	KeyID							INT(10) NOT NULL AUTO_INCREMENT
	,BudgetAverageMonthlyID 		INT(20)
	,IncomeActual 					DECIMAL(10, 4)
	,IncomeAverage 					DECIMAL(10, 4)
	,ExpenseActual 					DECIMAL(10, 4)
	,ExpenseAverage 				DECIMAL(10, 4)
	,TotalIncomeVsExpenseActual 	DECIMAL(10, 4)
	,TotalIncomeVsExpenseAverage 	DECIMAL(10, 4)
	,SnapshotDT 					DATETIME
	,CreateDT 						DATETIME
	,CreateBy 						VARCHAR(100)
	,ModifyDT 						DATETIME
	,ModifyBy 						VARCHAR(100)
	,ActiveFlg 						INT(1) DEFAULT 1
	,PRIMARY KEY (`KeyID`)
);



select * from snpBudgetAverageMonthly;