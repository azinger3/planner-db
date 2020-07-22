USE planner;

DROP PROCEDURE IF EXISTS `TransactionSmsProcess`;

DELIMITER ;;
CREATE PROCEDURE `TransactionSmsProcess`()
BEGIN

DECLARE varTransactionSmsID INT;
DECLARE varHasTransaction INT DEFAULT 0;
DECLARE varTransactionSmsCount INT;
DECLARE varSmsSid VARCHAR(1000);
DECLARE varBody VARCHAR(1000);
DECLARE i INT DEFAULT 0;


DROP TEMPORARY TABLE IF EXISTS tmpTransactionSms;

CREATE TEMPORARY TABLE tmpTransactionSms
(
	KeyID						INT NOT NULL AUTO_INCREMENT
	,TransactionSmsID	INT
	,Body						VARCHAR(1000)
    ,IsProcessFlg			INT DEFAULT 0
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpTransactionSms
(
	TransactionSmsID
	,Body
)
SELECT	TransactionSms.TransactionSmsID	AS TransactionSmsID
                ,TransactionSms.Body 						AS Body
FROM 	TransactionSms TransactionSms
;


DROP TEMPORARY TABLE IF EXISTS tmpTransactionQueue;

CREATE TEMPORARY TABLE tmpTransactionQueue
(
	KeyID								INT NOT NULL AUTO_INCREMENT
	,QueueID							VARCHAR(100)
	,TransactionTypeID			INT DEFAULT 2
    ,TransactionNumber		VARCHAR(100)
    ,TransactionDT  				DATETIME
    ,BudgetCategoryID 		INT DEFAULT 103
    ,Amount 							DECIMAL(10, 4) DEFAULT 0
    ,Description 					VARCHAR(1000)
    ,Note 								VARCHAR(1000)
    ,Body								VARCHAR(1000)
    ,TransactionSmsCount	INT
	,PRIMARY KEY (`KeyID`)
);


SET varHasTransaction = (IFNULL((SELECT '1' FROM tmpTransactionSms WHERE IsProcessFlg = 0 LIMIT 1), 0));


IF varHasTransaction = 1 THEN
	WHILE i = 0 DO
		
		SELECT 	tmpTransactionSms.TransactionSmsID	AS varTransactionSmsID
						,tmpTransactionSms.Body 						AS varBody
		FROM 	tmpTransactionSms tmpTransactionSms
		WHERE	tmpTransactionSms.IsProcessFlg = 0
		LIMIT 		1
		INTO		varTransactionSmsID
						,varBody
		;
		
		
		UPDATE 	tmpTransactionSms
		SET			tmpTransactionSms.IsProcessFlg = 1
		WHERE 	tmpTransactionSms.TransactionSmsID = varTransactionSmsID
		;
		
		
		SELECT 	COUNT(tmpTransactionSms.KeyID) AS varTransactionSmsCount
		FROM 	tmpTransactionSms tmpTransactionSms
		WHERE	tmpTransactionSms.IsProcessFlg = 0
		INTO		varTransactionSmsCount
		;
		
		
		CALL TransactionSmsSplit(varBody, CHAR(10));
		
		
		INSERT INTO tmpTransactionQueue
		(
			QueueID
			,TransactionNumber
			,TransactionDT
			,Amount
			,Description
			,Note
			,Body
			,TransactionSmsCount
		)
		SELECT	RS.QueueID						AS QueueID
						,RS.TransactionNumber		AS TransactionNumber
						,RS.TransactionDT				AS TransactionDT
						,RS.Amount							AS Amount
						,RS.Description					AS Description
						,RS.Note								AS Note
						,RS.Body								AS Body
						,RS.TransactionSmsCount	AS TransactionSmsCount
		FROM		(
							SELECT 	UUID()																																							AS QueueID
											,tmpTransactionSmsSplit.KeyID																													AS TransactionNumber
											,DATE_FORMAT(NOW() ,'%Y-%m-%d')																										AS TransactionDT
											,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(tmpTransactionSmsSplit.varSegment, ',', 2), ',', -1))	AS Amount
											,TRIM((SUBSTRING_INDEX(tmpTransactionSmsSplit.varSegment, ',', 1)))												AS Description
											,'CC - Split - XX Total'																																	AS Note
											,tmpTransactionSmsSplit.varSegment																										AS Body
											,varTransactionSmsCount																															AS TransactionSmsCount
							FROM 	tmpTransactionSmsSplit tmpTransactionSmsSplit
						) RS
		WHERE 	RS.Amount REGEXP '^[0-9]'
		;
		
		
		IF varTransactionSmsCount = 0 THEN
			SET i = 1;
		END IF;
		
	END WHILE;


	INSERT INTO TransactionQueue
	(
		QueueID
		,TransactionTypeID
		,TransactionNumber			    
		,TransactionDT					
		,BudgetNumber 					
		,BudgetCategoryID 			    
		,Amount 						
		,Description 					
		,Note 							
		,CreateBy                       
	)
	SELECT  tmpTransactionQueue.QueueID 		                											AS QueueID
					,tmpTransactionQueue.TransactionTypeID 	            									AS TransactionTypeID
					,tmpTransactionQueue.TransactionNumber 	            									AS TransactionNumber			    
					,tmpTransactionQueue.TransactionDT	 	            										AS TransactionDT					
					,EXTRACT(YEAR_MONTH FROM tmpTransactionQueue.TransactionDT)	AS BudgetNumber 					
					,tmpTransactionQueue.BudgetCategoryID  	            									AS BudgetCategoryID 			    
					,tmpTransactionQueue.Amount 			            												AS Amount 						
					,REPLACE(tmpTransactionQueue.Description, '''', '') 									AS Description 					
					,tmpTransactionQueue.Note 			 	            												AS Note 							
					,'Bot'           	                																					AS CreateBy 
	FROM 	tmpTransactionQueue tmpTransactionQueue
	; 


	INSERT INTO logTransactionSms
	(
		TransactionSmsID
		,Sender
		,Receiver
		,Body
		,SmsSid
		,SmsMessageSid
		,SmsStatus
		,AccountSid
		,MessageSid
		,FromCity
		,FromState
		,FromZip
		,FromCountry
		,ToState
		,ToCity
		,ToZip
		,ToCountry
		,NumMedia
		,NumSegments
		,ApiVersion
	)
	SELECT 			TransactionSms.TransactionSmsID	AS TransactionSmsID
							,TransactionSms.Sender					AS Sender
							,TransactionSms.Receiver					AS Receiver
							,TransactionSms.Body						AS Body
							,TransactionSms.SmsSid					AS SmsSid
							,TransactionSms.SmsMessageSid		AS SmsMessageSid
							,TransactionSms.SmsStatus				AS SmsStatus
							,TransactionSms.AccountSid				AS AccountSid
							,TransactionSms.MessageSid			AS MessageSid
							,TransactionSms.FromCity					AS FromCity
							,TransactionSms.FromState				AS FromState
							,TransactionSms.FromZip					AS FromZip
							,TransactionSms.FromCountry			AS FromCountry
							,TransactionSms.ToState					AS ToState
							,TransactionSms.ToCity						AS ToCity
							,TransactionSms.ToZip						AS ToZip
							,TransactionSms.ToCountry				AS ToCountry
							,TransactionSms.NumMedia				AS NumMedia
							,TransactionSms.NumSegments		AS NumSegments
							,TransactionSms.ApiVersion				AS ApiVersion
	FROM				TransactionSms TransactionSms
	INNER JOIN 	tmpTransactionSms tmpTransactionSms
	ON					tmpTransactionSms.TransactionSmsID = TransactionSms.TransactionSmsID
	;


	DELETE      	TransactionSms
	FROM        		TransactionSms TransactionSms
	INNER JOIN	tmpTransactionSms tmpTransactionSms
	ON          			tmpTransactionSms.TransactionSmsID = TransactionSms.TransactionSmsID
	;

END IF;

    
END;;
DELIMITER ;


/*
select * from TransactionSms order by 1 desc limit 50;
select * from logTransactionSms order by 1 desc limit 50;
select * from TransactionQueue order by 1 desc limit 50;
select * from logTransactionQueue order by 1 desc limit 50;
*/



CALL TransactionSmsProcess();


-- parse by the delimiter into tmpTransactionQueue
/*
CALL TransactionSmsSplit('boy
girl
tranny
shim', CHAR(10));
*/
/*
CALL TransactionSmsSplit('Target, 30.30', ',');
*/
/*
SELECT 
	(SUBSTRING_INDEX('Target, 30.30', ',', 1)) AS testColumn1
	,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX('Target, 30.30', ',', 2), ',', -1)) AS testColumn2

*/


-- if can't parse, dump single line

-- category = pending

-- description = body

-- queue id = timecode + sms id

-- transaction number = 1 of 3 by row

-- note = CC - Split - 12.34 Total by top row

-- transaction type = 2 (expense)

-- RUN TransactionQueueInsert


/*
select * from TransactionSms order by 1 desc limit 5;
select * from logTransactionSms order by 1 desc limit 5;
*/