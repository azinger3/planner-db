-- select * from TransactionQueue order by 1 desc limit 100;


-- select * from logTransactionQueue order by 1 desc limit 100;


-- ++++++++++++++++++++++DONE++++++++++++++++++++++++ TransactionSms

-- TransactionSmsInsert
-- TransactionSmsProcess

-- POST budget/transaction/sms
-- POST budget/transaction/sms/process


USE planner;


-- transaction sms
DROP TABLE IF EXISTS TransactionSms;

CREATE TABLE TransactionSms
(
	TransactionSmsID		INT(10) NOT NULL AUTO_INCREMENT
	,Sender						VARCHAR(1000)
    ,Body							VARCHAR(1000)
	,CreateDT      				DATETIME DEFAULT(NOW())
	,CreateBy      				VARCHAR(100)
	,ModifyDT					DATETIME
	,ModifyBy					VARCHAR(100)
	,ActiveFlg					INT(10) DEFAULT '1'
	,PRIMARY KEY (`TransactionSmsID`)
);


-- transaction sms log
DROP TABLE IF EXISTS logTransactionSms;

CREATE TABLE logTransactionSms
(
	logTransactionSmsID	INT(10) NOT NULL AUTO_INCREMENT
    ,TransactionSmsID		INT(10)
	,Sender						VARCHAR(1000)
    ,Body							VARCHAR(1000)
	,CreateDT      				DATETIME DEFAULT(NOW())
	,CreateBy      				VARCHAR(100)
	,ModifyDT					DATETIME
	,ModifyBy					VARCHAR(100)
	,ActiveFlg					INT(10) DEFAULT '1'
	,PRIMARY KEY (`logTransactionSmsID`)
);




-- test data
INSERT INTO TransactionSms
(
	Sender					
	,Body
    ,CreateBy
)
SELECT  '15029302955'        			AS Sender						
        ,'tes test test
        test'	AS Body,
        'Bot' AS CreateBy
;


INSERT INTO logTransactionSms
(
	TransactionSmsID
    ,Sender					
	,Body
    ,CreateBy
)
SELECT  999 AS TransactionSmsID
				,'15029302955' AS Sender						
				,'tes test test
					test'	AS Body
                    ,'Bot' AS CreateBy
;


-- verify
select * from TransactionSms order by 1 desc limit 5;
select * from logTransactionSms order by 1 desc limit 5;

