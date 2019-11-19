USE `planner`;



DROP PROCEDURE IF EXISTS `TransactionSpotlightGet`;

DELIMITER ;;
CREATE PROCEDURE `TransactionSpotlightGet`(prmEffectiveDT DATETIME)
BEGIN


/********************************************************************************************** 
PURPOSE:		Get Transaction Spotlight
AUTHOR:		Rob Azinger
DATE:				11/16/2019
NOTES:			Temporary Session Table - tmpTransactionSpotlight
CHANGE CONTROL:		 
***********************************************************************************************/

/**********************************************************************************************
	Open Session
***********************************************************************************************/

SET @varSessionID = UUID();



/**********************************************************************************************
	STEP 01:		Create temporary structure to store parameter & scope data
***********************************************************************************************/

SET @varEffectiveDT = CONVERT_TZ(@prmEffectiveDT, '+00:00','-05:00');
SET @varStartDT = DATE_ADD(@varEffectiveDT, INTERVAL -30 DAY);


DROP TEMPORARY TABLE IF EXISTS tmpParameter;

CREATE TEMPORARY TABLE tmpParameter
(
	KeyID                   	INT(10) NOT NULL AUTO_INCREMENT
    ,SessionID				VARCHAR(100)
    ,EffectiveDT			DATETIME
    ,StartWeekID			INT(10)
    ,EndWeekID			INT(10)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpParameter
(
	SessionID
    ,EffectiveDT
)
SELECT 	@varSessionID 		AS SessionID
				,@varEffectiveDT	AS EffectiveDT
;


-- Update Start Week ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 		Calendar.WeekID	AS StartWeekID
							FROM			Calendar Calendar
							WHERE		DATEDIFF(Calendar.EffectiveDT, @varStartDT) = 0
						) RS
SET					tmpParameter.StartWeekID = RS.StartWeekID
;


-- Update End Week ID
UPDATE 			tmpParameter
INNER JOIN	(
							SELECT 		Calendar.WeekID	AS EndWeekID
							FROM			Calendar Calendar
							WHERE		DATEDIFF(Calendar.EffectiveDT, @varEffectiveDT) = 0
						) RS
SET					tmpParameter.EndWeekID = RS.EndWeekID
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

-- Weekly (raw)
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


-- Weekly (formatted - same month)
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID																						AS SessionID
													,tmpTransactionSpotlight.KeyID																								AS KeyID
													,tmpTransactionSpotlight.DateRangeWeekBegin 																	AS DateRangeWeekBegin
													,DAY(CalendarWeekEnd) 																										AS CalendarWeekEndDay
													,CONCAT(tmpTransactionSpotlight.DateRangeWeekBegin, ' - ', DAY(CalendarWeekEnd))	AS DateRangeWeek
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							WHERE			MONTH(CalendarWeekBegin) = MONTH(CalendarWeekEnd)
						) RS
ON          			tmpTransactionSpotlight.SessionID 				= RS.SessionID
AND				tmpTransactionSpotlight.KeyID 						= RS.KeyID
SET					tmpTransactionSpotlight.DateRangeWeek		= RS.DateRangeWeek
;


-- Weekly (formatted - overlap month)
UPDATE      	tmpTransactionSpotlight
INNER JOIN 	(
							SELECT      	tmpTransactionSpotlight.SessionID																															AS SessionID
													,tmpTransactionSpotlight.KeyID																																	AS KeyID
													,tmpTransactionSpotlight.DateRangeWeekBegin 																										AS DateRangeWeekBegin
													,tmpTransactionSpotlight.DateRangeWeekEnd																											AS CalendarWeekEndDay
													,CONCAT(tmpTransactionSpotlight.DateRangeWeekBegin, ' - ', tmpTransactionSpotlight.DateRangeWeekEnd)	AS DateRangeWeek
							FROM        		tmpTransactionSpotlight tmpTransactionSpotlight
							INNER JOIN	tmpParameter tmpParameter
							ON					tmpParameter.SessionID = tmpTransactionSpotlight.SessionID
							WHERE			MONTH(CalendarWeekBegin) <> MONTH(CalendarWeekEnd)
						) RS
ON          			tmpTransactionSpotlight.SessionID 				= RS.SessionID
AND				tmpTransactionSpotlight.KeyID 						= RS.KeyID
SET					tmpTransactionSpotlight.DateRangeWeek		= RS.DateRangeWeek
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
                        ,tmpTransactionSpotlight.DateRangeWeek					AS DateRangeWeek
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





