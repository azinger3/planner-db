USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionQueueInsert`;

CREATE PROCEDURE `TransactionQueueInsert`
(
    prmQueueID				VARCHAR(100)
    ,prmTransactionTypeID	INT(10)
    ,prmTransactionNumber	VARCHAR(100)		    
    ,prmTransactionDT		DATETIME			
    ,prmBudgetNumber 		INT(10)			
    ,prmBudgetCategoryID 	INT(10)		    
    ,prmAmount 				DECIMAL(10, 4)			
    ,prmDescription 		VARCHAR(1000)			
    ,prmNote 				VARCHAR(1000)			
    ,prmCreateBy  			VARCHAR(100)
)
BEGIN

/********************************************************************************************** 
PURPOSE:		Insert Transaction Queue
AUTHOR:			Rob Azinger
DATE:			03/08/2020
NOTES:			
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 01:	Initialize variables to store parameter & scope data
***********************************************************************************************/

SET @varQueueID = prmQueueID;
SET @varTransactionTypeID = prmTransactionTypeID;
SET @varTransactionNumber = prmTransactionNumber;
SET @varTransactionDT = prmTransactionDT;
SET @varBudgetNumber = prmBudgetNumber;
SET @varBudgetCategoryID = prmBudgetCategoryID;
SET @varAmount = prmAmount;
SET @varDescription = prmDescription;
SET @varNote = prmNote;
SET @varCreateBy = prmCreateBy;



/**********************************************************************************************
	STEP 02:	Validate Transaction
***********************************************************************************************/

SET @varIsQueued = 0;
SET @varIsProcessed = 0;

SET @varIsQueued = (IFNULL((SELECT '1' FROM TransactionQueue WHERE QueueID = @varQueueID LIMIT 1), 0));
SET @varIsProcessed = (IFNULL((SELECT '1' FROM logTransactionQueue WHERE QueueID = @varQueueID LIMIT 1), 0));



/**********************************************************************************************
	STEP 02:	Insert Transaction
***********************************************************************************************/

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
SELECT  prmQueueID 				AS QueueID
        ,prmTransactionTypeID 	AS TransactionTypeID
        ,prmTransactionNumber 	AS TransactionNumber			    
        ,prmTransactionDT	 	AS TransactionDT					
        ,prmBudgetNumber 	 	AS BudgetNumber 					
        ,prmBudgetCategoryID  	AS BudgetCategoryID 			    
        ,prmAmount 			 	AS Amount 						
        ,prmDescription 		AS Description 					
        ,prmNote 			 	AS Note 							
        ,prmCreateBy           	AS CreateBy 
WHERE   @varIsQueued = 0
AND     @varIsProcessed = 0                  
;


END;