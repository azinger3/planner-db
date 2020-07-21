USE planner;


-- pull messages
DROP TEMPORARY TABLE IF EXISTS tmpTransactionSms;

CREATE TEMPORARY TABLE tmpTransactionSms
(
	KeyID						INT(10) NOT NULL AUTO_INCREMENT
	,TransactionSmsID	INT(10)
	,Sender					VARCHAR(100)
	,Body						VARCHAR(100)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpTransactionSms
(
	TransactionSmsID
	,Sender
	,Body
)
SELECT	TransactionSms.TransactionSmsID	AS TransactionSmsID
				,TransactionSms.Sender 					AS Sender
                ,TransactionSms.Body 						AS Body
FROM 	TransactionSms TransactionSms
;

SELECT 	* 
FROM 	tmpTransactionSms;


SELECT 	LOCATE(Body, CHAR(13))
FROM 	tmpTransactionSms;


-- parse by the delimiter into tmpTransactionQueue

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