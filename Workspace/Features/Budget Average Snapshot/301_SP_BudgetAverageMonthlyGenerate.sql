USE `planner`;

-- DROP PROCEDURE IF EXISTS `BudgetAverageMonthlyGenerate`;

-- DELIMITER ;;
-- CREATE PROCEDURE `BudgetAverageMonthlyGenerate`(prmEffectiveDT DATETIME)
-- BEGIN


SET @prmStartDT = '2019-04-01';
SET @prmEndDT = '2019-07-01';

select @prmStartDT, @prmEndDT;
/********************************************************************************************** 
PURPOSE:		Get Budget Average Monthly Snapshot
AUTHOR:			Rob Azinger
DATE:			12/19/2019
NOTES:			Snapshot Table - tmpTransactionSpotlight
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 01:		Create temporary structure to store parameter & scope data
***********************************************************************************************/

SET @varStartDT = @prmStartDT;
SET @varEndDT = @prmEndDT;


DROP TEMPORARY TABLE IF EXISTS tmpParameter;

CREATE TEMPORARY TABLE tmpParameter
(
	KeyID						INT(10) NOT NULL AUTO_INCREMENT
    ,StartDT					DATETIME
	,EndDT						DATETIME
	,StartID					INT(10)
	,EndID						INT(10)
	,BudgetAverageMonthlyID		INT(20)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpParameter
(
	StartDT
    ,EndDT
)
SELECT 	@varStartDT 	AS StartDT
		,@varEndDT		AS EndDT
;

select * from tmpParameter;

-- Update Start ID

-- UPDATE 		tmpParameter
-- INNER JOIN	(
-- 							SELECT 		Calendar.WeekID	AS StartWeekID
-- 							FROM			Calendar Calendar
-- 							WHERE		DATEDIFF(Calendar.EffectiveDT, @varStartDT) = 0
-- 						) RS
-- SET					tmpParameter.StartWeekID = RS.StartWeekID
-- ;

-- Update End ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 		Calendar.WeekID	AS StartWeekID
							FROM			Calendar Calendar
							WHERE		DATEDIFF(Calendar.EffectiveDT, @varStartDT) = 0
						) RS
SET					tmpParameter.StartWeekID = RS.StartWeekID
;

-- Update Budget Average Monthly ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 		Calendar.WeekID	AS StartWeekID
							FROM			Calendar Calendar
							WHERE		DATEDIFF(Calendar.EffectiveDT, @varStartDT) = 0
						) RS
SET					tmpParameter.StartWeekID = RS.StartWeekID
;



/**********************************************************************************************
	STEP 02:		Get base Transaction data
***********************************************************************************************/

INSERT INTO	tmpTransactionSpotlight
(
	SessionID
	,TransactionID
    ,TransactionTypeID
    ,TransactionNumber
    ,TransactionDT
    ,TransactionYear
    ,TransactionMonth
    ,TransactionWeek
    ,TransactionDay
	,CalendarWeekID
	,CalendarWeekBegin
	,CalendarWeekEnd
    ,CalendarDayName
    ,BudgetNumber
    ,BudgetCategoryID
    ,Amount
    ,Description
    ,Note
)
SELECT 			tmpParameter.SessionID						AS SessionID
						,Transaction.TransactionID						AS TransactionID
						,Transaction.TransactionTypeID				AS TransactionTypeID
						,Transaction.TransactionNumber			AS TransactionNumber
						,Transaction.TransactionDT					AS TransactionDT
						,YEAR(Transaction.TransactionDT)		AS TransactionYear
						,MONTH(Transaction.TransactionDT)	AS TransactionMonth
						,WEEK(Transaction.TransactionDT)		AS TransactionWeek
						,DAY(Transaction.TransactionDT)			AS TransactionDay
						,Calendar.WeekID									AS CalendarWeekID
						,Calendar.WeekBegin								AS CalendarWeekBegin
						,Calendar.WeekEnd								AS CalendarWeekEnd
                        ,Calendar.DayName								AS CalendarDayName
						,Transaction.BudgetNumber					AS BudgetNumber
						,Transaction.BudgetCategoryID				AS BudgetCategoryID
						,Transaction.Amount								AS Amount
						,Transaction.Description							AS Description
						,Transaction.Note									AS Note
FROM				Transaction Transaction
INNER JOIN	Calendar Calendar
ON					Calendar.EffectiveDT = Transaction.TransactionDT
INNER JOIN	tmpParameter tmpParameter
ON					tmpParameter.StartWeekID <= Calendar.WeekID		-- Start less than all weeks --> Give me these <-- End greater than all weeks
AND 				tmpParameter.EndWeekID >= Calendar.WeekID
WHERE			Transaction.TransactionTypeID = 2
ORDER BY		Transaction.TransactionDT 	ASC
						,Transaction.TransactionID		ASC
;



/**********************************************************************************************
	STEP 03:		Update Amounts (by date part)
***********************************************************************************************/

-- Yearly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionYear		AS TransactionYear
													,SUM(tmpTransactionSpotlight.Amount) 		AS AmountYearly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionYear
						) RS
ON          			tmpTransactionSpotlight.SessionID 			= RS.SessionID
AND				tmpTransactionSpotlight.TransactionYear 	= RS.TransactionYear
SET					tmpTransactionSpotlight.AmountYearly 		= RS.AmountYearly
;


-- Monthly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionMonth	AS TransactionMonth
													,SUM(tmpTransactionSpotlight.Amount) 		AS AmountMonthly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionMonth
						) RS
ON          			tmpTransactionSpotlight.SessionID 				= RS.SessionID
AND				tmpTransactionSpotlight.TransactionMonth 	= RS.TransactionMonth
SET					tmpTransactionSpotlight.AmountMonthly 		= RS.AmountMonthly
;


-- Weekly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionWeek	AS TransactionWeek
													,SUM(tmpTransactionSpotlight.Amount) 		AS AmountWeekly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionWeek
						) RS
ON          			tmpTransactionSpotlight.SessionID 				= RS.SessionID
AND				tmpTransactionSpotlight.TransactionWeek 	= RS.TransactionWeek
SET					tmpTransactionSpotlight.AmountWeekly 		= RS.AmountWeekly
;
    

-- Daily
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionMonth	AS TransactionMonth
													,tmpTransactionSpotlight.TransactionDay		AS TransactionDay
													,SUM(tmpTransactionSpotlight.Amount) 		AS AmountDaily
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionMonth
													,tmpTransactionSpotlight.TransactionDay
						) RS
ON          			tmpTransactionSpotlight.SessionID 				= RS.SessionID
AND				tmpTransactionSpotlight.TransactionMonth 	= RS.TransactionMonth
AND				tmpTransactionSpotlight.TransactionDay 		= RS.TransactionDay
SET					tmpTransactionSpotlight.AmountDaily 			= RS.AmountDaily
;



/**********************************************************************************************
	STEP 04:		Update Date Ranges (by date part)
***********************************************************************************************/

-- Weekly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID																																														AS SessionID
													,tmpTransactionSpotlight.KeyID																																																AS KeyID
													,tmpTransactionSpotlight.CalendarWeekBegin																																										AS CalendarWeekBegin
													,tmpTransactionSpotlight.CalendarWeekEnd																																											AS CalendarWeekEnd
                                                    ,CONCAT(SUBSTRING(MONTHNAME(tmpTransactionSpotlight.CalendarWeekBegin), 1, 3), ' ',DAY(tmpTransactionSpotlight.CalendarWeekBegin))	AS DateRangeWeekBegin
                                                    ,CONCAT(SUBSTRING(MONTHNAME(tmpTransactionSpotlight.CalendarWeekEnd), 1, 3), ' ',DAY(tmpTransactionSpotlight.CalendarWeekEnd))			AS DateRangeWeekEnd
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
						) RS
ON          			tmpTransactionSpotlight.SessionID 						= RS.SessionID
AND				tmpTransactionSpotlight.KeyID 								= RS.KeyID
SET					tmpTransactionSpotlight.DateRangeWeekBegin	= RS.DateRangeWeekBegin
						,tmpTransactionSpotlight.DateRangeWeekEnd 		= RS.DateRangeWeekEnd
;


-- Daily
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID													AS SessionID
													,tmpTransactionSpotlight.KeyID															AS KeyID
													,tmpTransactionSpotlight.CalendarDayName										AS CalendarDayName
                                                    ,SUBSTRING(tmpTransactionSpotlight.CalendarDayName, 1, 3)		AS DateRangeDaily
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
						) RS
ON          			tmpTransactionSpotlight.SessionID 			= RS.SessionID
AND				tmpTransactionSpotlight.KeyID					= RS.KeyID
SET					tmpTransactionSpotlight.DateRangeDaily	= RS.DateRangeDaily
;



/**********************************************************************************************
	STEP 05:		Update Transaction Counts (by date part)
***********************************************************************************************/
    

-- Yearly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionYear		AS TransactionYear
													,COUNT(tmpTransactionSpotlight.KeyID) 		AS TransactionCountYearly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionYear
						) RS
ON          			tmpTransactionSpotlight.SessionID 						= RS.SessionID
AND				tmpTransactionSpotlight.TransactionYear 				= RS.TransactionYear
SET					tmpTransactionSpotlight.TransactionCountYearly 	= RS.TransactionCountYearly
;



-- Monthly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionMonth	AS TransactionMonth
													,COUNT(tmpTransactionSpotlight.KeyID) 		AS TransactionCountMonthly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionMonth
						) RS
ON          			tmpTransactionSpotlight.SessionID 							= RS.SessionID
AND				tmpTransactionSpotlight.TransactionMonth 				= RS.TransactionMonth
SET					tmpTransactionSpotlight.TransactionCountMonthly 	= RS.TransactionCountMonthly
;
    

    
-- Weekly
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionWeek	AS TransactionWeek
													,COUNT(tmpTransactionSpotlight.KeyID) 		AS TransactionCountWeekly
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionWeek
						) RS
ON          			tmpTransactionSpotlight.SessionID 							= RS.SessionID
AND				tmpTransactionSpotlight.TransactionWeek 				= RS.TransactionWeek
SET					tmpTransactionSpotlight.TransactionCountWeekly 	= RS.TransactionCountWeekly
;    



-- Daily
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID				AS SessionID
													,tmpTransactionSpotlight.TransactionDT		AS TransactionDT
													,COUNT(tmpTransactionSpotlight.KeyID) 		AS TransactionCountDaily
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							GROUP BY		tmpTransactionSpotlight.TransactionDT
						) RS
ON          			tmpTransactionSpotlight.SessionID 						= RS.SessionID
AND				tmpTransactionSpotlight.TransactionDT 				= RS.TransactionDT
SET					tmpTransactionSpotlight.TransactionCountDaily 	= RS.TransactionCountDaily
;  



/**********************************************************************************************
	Final Result
***********************************************************************************************/

SELECT			tmpTransactionSpotlight.KeyID 										AS KeyID
						,tmpTransactionSpotlight.SessionID 								AS SessionID
						,tmpTransactionSpotlight.TransactionID 						AS TransactionID
						,tmpTransactionSpotlight.TransactionTypeID 				AS TransactionTypeID
						,tmpTransactionSpotlight.TransactionNumber 				AS TransactionNumber
						,tmpTransactionSpotlight.TransactionDT 						AS TransactionDT
						,tmpTransactionSpotlight.TransactionYear 					AS TransactionYear
						,tmpTransactionSpotlight.TransactionMonth 					AS TransactionMonth
						,tmpTransactionSpotlight.TransactionWeek 					AS TransactionWeek
						,tmpTransactionSpotlight.TransactionDay 						AS TransactionDay
						,tmpTransactionSpotlight.CalendarWeekID 					AS CalendarWeekID
						,tmpTransactionSpotlight.CalendarWeekBegin 				AS CalendarWeekBegin
						,tmpTransactionSpotlight.CalendarWeekEnd 				AS CalendarWeekEnd
						,tmpTransactionSpotlight.CalendarDayName 				AS CalendarDayName
						,tmpTransactionSpotlight.BudgetNumber 						AS BudgetNumber
						,tmpTransactionSpotlight.BudgetCategoryID 					AS BudgetCategoryID
						,tmpTransactionSpotlight.Amount 									AS Amount
						,tmpTransactionSpotlight.Description 							AS Description
						,tmpTransactionSpotlight.Note 										AS Note
						,tmpTransactionSpotlight.AmountYearly 						AS AmountYearly
						,tmpTransactionSpotlight.AmountMonthly 						AS AmountMonthly
						,tmpTransactionSpotlight.AmountWeekly 						AS AmountWeekly
						,tmpTransactionSpotlight.AmountDaily 							AS AmountDaily
						,tmpTransactionSpotlight.DateRangeWeekBegin 			AS DateRangeWeekBegin
						,tmpTransactionSpotlight.DateRangeWeekEnd 				AS DateRangeWeekEnd
						,tmpTransactionSpotlight.DateRangeDaily 					AS DateRangeDaily
						,tmpTransactionSpotlight.TransactionCountYearly 		AS TransactionCountYearly
						,tmpTransactionSpotlight.TransactionCountMonthly 		AS TransactionCountMonthly
						,tmpTransactionSpotlight.TransactionCountWeekly 		AS TransactionCountWeekly
						,tmpTransactionSpotlight.TransactionCountDaily 			AS TransactionCountDaily
FROM				tmpTransactionSpotlight tmpTransactionSpotlight
INNER JOIN	tmpParameter tmpParameter
ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
;



/**********************************************************************************************
	Close Session
***********************************************************************************************/

DELETE 				tmpTransactionSpotlight 
FROM					tmpTransactionSpotlight
INNER JOIN		tmpParameter tmpParameter
ON						tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
;


END;;
DELIMITER ;





