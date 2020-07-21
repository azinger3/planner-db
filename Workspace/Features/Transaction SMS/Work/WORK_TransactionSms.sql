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
	,Sender						VARCHAR(100)
    ,Receiver 					VARCHAR(100)
    ,Body							VARCHAR(1000)
    ,SmsSid 						VARCHAR(1000)
	,SmsMessageSid 		VARCHAR(1000)
    ,SmsStatus 					VARCHAR(100)
    ,AccountSid 				VARCHAR(1000)
    ,MessageSid 				VARCHAR(1000)
    ,FromCity 					VARCHAR(100)
	,FromState 					VARCHAR(100)
	,FromZip 						VARCHAR(100)
	,FromCountry 				VARCHAR(100)
	,ToState 						VARCHAR(100)
    ,ToCity 						VARCHAR(100)
    ,ToZip 							VARCHAR(100)
    ,ToCountry 					VARCHAR(100)
	,NumMedia 					VARCHAR(100)
    ,NumSegments 			VARCHAR(100)
	,ApiVersion 					VARCHAR(100)
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
	,Sender						VARCHAR(100)
    ,Receiver 					VARCHAR(100)
    ,Body							VARCHAR(1000)
    ,SmsSid 						VARCHAR(1000)
	,SmsMessageSid 		VARCHAR(1000)
    ,SmsStatus 					VARCHAR(100)
    ,AccountSid 				VARCHAR(1000)
    ,MessageSid 				VARCHAR(1000)
    ,FromCity 					VARCHAR(100)
	,FromState 					VARCHAR(100)
	,FromZip 						VARCHAR(100)
	,FromCountry 				VARCHAR(100)
	,ToState 						VARCHAR(100)
    ,ToCity 						VARCHAR(100)
    ,ToZip 							VARCHAR(100)
    ,ToCountry 					VARCHAR(100)
	,NumMedia 					VARCHAR(100)
    ,NumSegments 			VARCHAR(100)
	,ApiVersion 					VARCHAR(100)
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
SELECT  '15029302955' AS Sender						
        ,'Walmart, 90.88
        Needs, 23.32
        Shoes for Vi, 33.93
        Groceries, 33.63'	AS Body
        ,'Bot' AS CreateBy
UNION
SELECT  '15025724735' AS Sender						
        ,'walmart 
        test'	AS Body
        ,'Bot' AS CreateBy
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



/*

ToCountry = US
ToState = DC
SmsMessageSid = SMd82d5b77c303c4150174c9f07fceedfe
NumMedia = 0
ToCity
FromZip = 40359
SmsSid=SMd82d5b77c303c4150174c9f07fceedfe
FromState=KY
SmsStatus=received
FromCity=LOUISVILLE
Body=Hello \xf0\x9f\x91\x8b
FromCountry = US
To = +12029722265
ToZip = 
NumSegments = 1
MessageSid = SMd82d5b77c303c4150174c9f07fceedfe
AccountSid = AC49e7e50cf672d78967f723afbd982e20
From = +15029302955
ApiVersion = 2010-04-01

*/
