USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionQueueProcess`;

CREATE PROCEDURE `TransactionQueueProcess`()
BEGIN

/********************************************************************************************** 
PURPOSE:		Process Transaction Queue
AUTHOR:			Rob Azinger
DATE:			03/08/2020
NOTES:			
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 02:    Get base Transaction Queue data
***********************************************************************************************/

DROP TEMPORARY TABLE IF EXISTS tmpTransactionQueue;

CREATE TEMPORARY TABLE tmpTransactionQueue
(
	KeyID                   INT(10) NOT NULL AUTO_INCREMENT
    ,TransactionQueueID     INT(10)
    ,QueueID				VARCHAR(100)
    ,TransactionTypeID	    INT(10)
    ,TransactionNumber	    VARCHAR(100)
    ,TransactionDT		    DATETIME
    ,BudgetNumber 		    INT(10)
    ,BudgetCategoryID 	    INT(10)
    ,Amount 			    DECIMAL(10, 4)
    ,Description 		    VARCHAR(1000)
    ,Note 				    VARCHAR(1000)
    ,CreateBy               VARCHAR(100)
	,PRIMARY KEY (`KeyID`)
);

INSERT INTO tmpTransactionQueue
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
SELECT  TransactionQueue.TransactionQueueID     AS TransactionQueueID
        ,TransactionQueue.QueueID			    AS QueueID
        ,TransactionQueue.TransactionTypeID     AS TransactionTypeID
        ,TransactionQueue.TransactionNumber     AS TransactionNumber
        ,TransactionQueue.TransactionDT	        AS TransactionDT
        ,TransactionQueue.BudgetNumber 	        AS BudgetNumber
        ,TransactionQueue.BudgetCategoryID      AS BudgetCategoryID
        ,TransactionQueue.Amount 		        AS Amount
        ,TransactionQueue.Description 	        AS Description
        ,TransactionQueue.Note 			        AS Note
        ,TransactionQueue.CreateBy              AS CreateBy
FROM    TransactionQueue TransactionQueue
;



/**********************************************************************************************
	STEP 03:    Insert Transaction Core
***********************************************************************************************/

INSERT INTO Transaction
(		
    TransactionTypeID
    ,TransactionNumber
    ,TransactionDT	
    ,BudgetNumber 	
    ,BudgetCategoryID 
    ,Amount 		
    ,Description 	
    ,Note 			
    ,CreateBy
    ,CreateDT
)
SELECT  tmpTransactionQueue.TransactionTypeID   AS TransactionTypeID
        ,tmpTransactionQueue.TransactionNumber  AS TransactionNumber
        ,tmpTransactionQueue.TransactionDT	    AS TransactionDT	
        ,tmpTransactionQueue.BudgetNumber 	    AS BudgetNumber 	
        ,tmpTransactionQueue.BudgetCategoryID   AS BudgetCategoryID 
        ,tmpTransactionQueue.Amount 		    AS Amount 		
        ,tmpTransactionQueue.Description 	    AS Description 	
        ,tmpTransactionQueue.Note 			    AS Note 			
        ,tmpTransactionQueue.CreateBy           AS CreateBy 
        ,CONVERT_TZ(NOW(),'+00:00','+00:00') 	AS CreateDT                
FROM    tmpTransactionQueue tmpTransactionQueue
;



/**********************************************************************************************
	STEP 03:    Insert Transaction Queue Log
***********************************************************************************************/

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
SELECT  tmpTransactionQueue.TransactionQueueID     AS TransactionQueueID
        ,tmpTransactionQueue.QueueID			   AS QueueID
        ,tmpTransactionQueue.TransactionTypeID     AS TransactionTypeID
        ,tmpTransactionQueue.TransactionNumber     AS TransactionNumber
        ,tmpTransactionQueue.TransactionDT	       AS TransactionDT
        ,tmpTransactionQueue.BudgetNumber 	       AS BudgetNumber
        ,tmpTransactionQueue.BudgetCategoryID      AS BudgetCategoryID
        ,tmpTransactionQueue.Amount 		       AS Amount
        ,tmpTransactionQueue.Description 	       AS Description
        ,tmpTransactionQueue.Note 			       AS Note
        ,tmpTransactionQueue.CreateBy              AS CreateBy
FROM    tmpTransactionQueue tmpTransactionQueue
;



/**********************************************************************************************
	STEP 04:    Delete Transactions from Queue
***********************************************************************************************/

DELETE      TransactionQueue
FROM        TransactionQueue TransactionQueue
INNER JOIN  tmpTransactionQueue tmpTransactionQueue
ON          tmpTransactionQueue.TransactionQueueID = TransactionQueue.TransactionQueueID
;


END;





