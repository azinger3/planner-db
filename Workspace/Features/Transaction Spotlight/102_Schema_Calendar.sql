USE planner;


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
