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
    ,DateRangeWeekly				VARCHAR(100)
    ,DateRangeDaily					VARCHAR(100)
    ,TransactionCountYearly		INT(10)
	,TransactionCountMonthly	INT(10)
	,TransactionCountWeekly	INT(10)
	,TransactionCountDaily		INT(10)
	,PRIMARY KEY (`KeyID`)
);



select * from tmpTransactionSpotlight;



DROP TABLE IF EXISTS Calendar;

CREATE TABLE Calendar
(
	CalendarID          	INT(10) NOT NULL AUTO_INCREMENT
    ,EffectiveDT 			DATETIME
    ,YearNumber 			INT(10)
    ,MonthNumber  		INT(10)
	,MonthID 				INT(10)
	,MonthName 			VARCHAR(100)
	,MonthBegin			DATETIME
    ,MonthEnd				DATETIME
    ,WeekNumber  		INT(10)
	,WeekDayNumber	INT(10)
	,WeekID 					INT(10)
	,WeekBegin				DATETIME
    ,WeekEnd				DATETIME
    ,DayNumber  			INT(10)
    ,DayID 					INT(10)
    ,DayName	 			VARCHAR(100)
    ,QuarterNumber		INT(10)
    ,QuarterID				INT(10)
    ,CreateDT 				DATETIME DEFAULT NOW()
    ,CreateBy 				VARCHAR(100) DEFAULT 'User'
    ,ModifyDT 				DATETIME DEFAULT NOW()
    ,ModifyBy 				VARCHAR(100) DEFAULT 'User'
    ,ActiveFlg 				INT(10) DEFAULT 1
    ,PRIMARY KEY (`CalendarID`)
);

CREATE  INDEX ixCalendar001 ON Calendar(EffectiveDT);
CREATE  INDEX ixCalendar002 ON Calendar(WeekID);


select * from Calendar;
