

  KeyID 									INT(10)
  ,SessionID 								VARCHAR(100) 
  ,TransactionID 							INT(10) 
  ,TransactionDT 							DATETIME 
  ,TransactionTypeID 						INT(10) 
  ,TransactionType 							VARCHAR(100) 
  ,TransactionNumber 						VARCHAR(100) 
  ,Description 								VARCHAR(1000) 
  ,Amount 									DECIMAL(10,2) 
  ,Note 									VARCHAR(1000) 
  ,BudgetNumber 							INT(10) 
  ,BudgetTypeID 							INT(10) 
  ,BudgetGroupID 							INT(10) 
  ,BudgetGroup 								VARCHAR(100) 
  ,BudgetCategoryID 						INT(10) 
  ,BudgetCategory 							VARCHAR(100) 
  ,Sort 									INT(3) 
  ,CategoryActual 							DECIMAL(10,2) 
  ,CategoryAverage 							DECIMAL(10,2) 
  ,IncomeActual 							DECIMAL(10,2) 
  ,IncomeAverage 							DECIMAL(10,2) 
  ,ExpenseActual 							DECIMAL(10,2) 
  ,ExpenseAverage 							DECIMAL(10,2) 
  ,TotalIncomeVsExpenseActual 				DECIMAL(10,2) 
  ,TotalIncomeVsExpenseAverage 				DECIMAL(10,2) 
  ,IsTotalIncomeVsExpenseActualNegative 	INT(1) 
  ,IsTotalIncomeVsExpenseAverageNegative 	INT(1) 
  ,IsExpenseFlg 							INT(1)

-- select * from Transaction order by 1 desc limit 10;

-- select * from Budget limit 100;

-- cmd + e, cmd + q

