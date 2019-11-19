USE planner;


DROP TABLE IF EXISTS tmpTransactionSpotlight;

CREATE TABLE tmpTransactionSpotlight
(
	KeyID                   				INT(10) NOT NULL AUTO_INCREMENT
    ,SessionID							VARCHAR(100)
	,TransactionID           			INT(10)
    ,TransactionTypeID				INT(10)
    ,TransactionNumber			VARCHAR(100)
    ,TransactionDT					DATETIME
    ,TransactionYear					INT(10)
    ,TransactionMonth 				INT(10)
    ,TransactionWeek 				INT(10)
    ,TransactionDay 					INT(10)
    ,CalendarWeekID				INT(10)
    ,CalendarWeekBegin			DATETIME
	,CalendarWeekEnd				DATETIME
    ,CalendarDayName			VARCHAR(100)
    ,BudgetNumber 					INT(10)
    ,BudgetCategoryID 			INT(10)
    ,Amount 								DECIMAL(10, 4)
    ,Description 						VARCHAR(1000)
    ,Note 									VARCHAR(1000)
	,AmountYearly 					DECIMAL(10, 0)
    ,AmountMonthly 					DECIMAL(10, 0)
    ,AmountWeekly 					DECIMAL(10, 0)
    ,AmountDaily						DECIMAL(10, 0)
    ,DateRangeWeekBegin		VARCHAR(100)
    ,DateRangeWeekEnd			VARCHAR(100)
    ,DateRangeWeek				VARCHAR(100)
    ,DateRangeDaily					VARCHAR(100)
    ,TransactionCountYearly		INT(10)
	,TransactionCountMonthly	INT(10)
	,TransactionCountWeekly	INT(10)
	,TransactionCountDaily		INT(10)
	,PRIMARY KEY (`KeyID`)
);



select * from tmpTransactionSpotlight;