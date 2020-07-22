USE planner;


-- clean up
DROP TABLE IF EXISTS TransactionChaseBankAccount;


-- table
DROP TABLE IF EXISTS TransactionQueue;

CREATE TABLE TransactionQueue
(
	TransactionQueueID              INT(10) NOT NULL AUTO_INCREMENT
    ,QueueID						VARCHAR(100)
    ,TransactionTypeID				INT(10)
    ,TransactionNumber			    VARCHAR(100)
    ,TransactionDT					DATETIME
    ,BudgetNumber 					INT(10)
    ,BudgetCategoryID 			    INT(10)
    ,Amount 						DECIMAL(10, 4)
    ,Description 					VARCHAR(1000)
    ,Note 							VARCHAR(1000)
	,CreateDT                       DATETIME DEFAULT(NOW())
    ,CreateBy                       VARCHAR(100)
    ,ModifyDT                       DATETIME
    ,ModifyBy                       VARCHAR(100)
	,ActiveFlg		                INT(10) DEFAULT '1'
	,PRIMARY KEY (`TransactionQueueID`)
);

CREATE INDEX ixTransactionQueue001 ON TransactionQueue(QueueID);


-- test data
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
SELECT  'test1'             AS QueueID
        ,2                  AS TransactionTypeID
        ,''                 AS TransactionNumber			    
        ,'2020-03-08'       AS TransactionDT					
        ,202003             AS BudgetNumber 					
        ,103                AS BudgetCategoryID 			    
        ,65.19              AS Amount 						
        ,'COSTCO test1'    AS Description 					
        ,'CC'               AS Note 							
        ,'Bot'              AS CreateBy                       
;


-- verify
select * from TransactionQueue;

