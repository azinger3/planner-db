USE planner;


-- clean up
DROP TABLE IF EXISTS TransactionChaseBankAccount;
DROP TABLE IF EXISTS TransactionChaseCreditCard;
DROP TABLE IF EXISTS Upload;
DROP TABLE IF EXISTS UploadStatus;
DROP TABLE IF EXISTS UploadTransaction;
DROP TABLE IF EXISTS TransactionStage;
DROP TABLE IF EXISTS ApplicationUser;
DROP TABLE IF EXISTS ApplicationLog;
DROP TABLE IF EXISTS Application;



-- transaction queue
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


-- transaction queue log
DROP TABLE IF EXISTS logTransactionQueue;

CREATE TABLE logTransactionQueue
(
	logTransactionQueueID           INT(10) NOT NULL AUTO_INCREMENT
    ,TransactionQueueID             INT(10)
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
	,PRIMARY KEY (`logTransactionQueueID`)
);

CREATE INDEX ixlogTransactionQueue001 ON logTransactionQueue(QueueID);



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


INSERT INTO logTransactionQueue
(
    TransactionQueueID
    ,QueueID
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
SELECT  9                   AS TransactionQueueID
        ,'test2'            AS QueueID
        ,2                  AS TransactionTypeID
        ,''                 AS TransactionNumber			    
        ,'2020-03-08'       AS TransactionDT					
        ,202003             AS BudgetNumber 					
        ,103                AS BudgetCategoryID 			    
        ,65.19              AS Amount 						
        ,'COSTCO test2'    AS Description 					
        ,'CC'               AS Note 							
        ,'Bot'              AS CreateBy                       
;



select * from TransactionQueue;
select * from logTransactionQueue;

