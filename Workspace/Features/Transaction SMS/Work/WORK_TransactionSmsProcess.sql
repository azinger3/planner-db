USE planner;


-- SET i INT DEFAULT(0);


-- pull messages
DROP TEMPORARY TABLE IF EXISTS tmpTransactionSms;

CREATE TEMPORARY TABLE tmpTransactionSms
(
	KeyID						INT(10) NOT NULL AUTO_INCREMENT
	,TransactionSmsID	INT(10)
	,Body						VARCHAR(100)
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


SELECT 	* 
FROM 	tmpTransactionSms;








-- parse by the delimiter into tmpTransactionQueue

CALL TransactionSmsSplit('boy
girl
tranny
shim', CHAR(10));


CALL TransactionSmsSplit('Target, 30.30', ',');

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