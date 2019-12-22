USE planner;


DROP TABLE IF EXISTS snpBudgetAverageMonthly;

CREATE TABLE snpBudgetAverageMonthly
(
	KeyID							INT(10) NOT NULL AUTO_INCREMENT
	,BudgetAverageMonthlyID 				VARCHAR(20)
	,IncomeActual 								DECIMAL(10, 4)
	,IncomeAverage 								DECIMAL(10, 4)
	,ExpenseActual 								DECIMAL(10, 4)
	,ExpenseAverage 							DECIMAL(10, 4)
	,TotalIncomeVsExpenseActual 		DECIMAL(10, 4)
	,TotalIncomeVsExpenseAverage	DECIMAL(10, 4)
    ,SnapshotHash								VARCHAR(100)						
	,SnapshotDT 									DATETIME
	,CreateDT 										DATETIME
	,CreateBy 										VARCHAR(100)
	,ModifyDT 										DATETIME
	,ModifyBy 										VARCHAR(100)
	,ActiveFlg 										INT(1) DEFAULT 1
	,PRIMARY KEY (`KeyID`)
);


CREATE  INDEX ixBudgetAverageMonthly001 ON snpBudgetAverageMonthly(BudgetAverageMonthlyID);
CREATE  INDEX ixBudgetAverageMonthly002 ON snpBudgetAverageMonthly(SnapshotHash);



select * from snpBudgetAverageMonthly;