USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionQueueInsert`;

-- DELIMITER ;;
CREATE PROCEDURE `TransactionQueueInsert`
(
    prmKeyID				VARCHAR(100)
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


SET @varKeyID = prmKeyID;
SET @varTransactionTypeID = prmTransactionTypeID;
SET @varTransactionNumber = prmTransactionNumber;
SET @varTransactionDT = prmTransactionDT;
SET @varBudgetNumber = prmBudgetNumber;
SET @varBudgetCategoryID = prmBudgetCategoryID;
SET @varAmount = prmAmount;
SET @varDescription = prmDescription;
SET @varNote = prmNote;
SET @varCreateBy = prmCreateBy;
SET @varIsExisting = 0;


SET @varIsExisting = ISNULL((SELECT 1 FROM TransactionQueue WHERE KeyID = @varKeyID)), 0;
SET @varIsExisting = (SELECT 1 FROM logTransactionQueue WHERE KeyID = @varKeyID);


INSERT INTO TransactionQueue
(
    KeyID
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
SELECT  prmKeyID 				AS KeyID
        ,prmTransactionTypeID 	AS TransactionTypeID
        ,prmTransactionNumber 	AS TransactionNumber			    
        ,prmTransactionDT	 	AS TransactionDT					
        ,prmBudgetNumber 	 	AS BudgetNumber 					
        ,prmBudgetCategoryID  	AS BudgetCategoryID 			    
        ,prmAmount 			 	AS Amount 						
        ,prmDescription 		AS Description 					
        ,prmNote 			 	AS Note 							
        ,prmCreateBy           	AS CreateBy 
-- WHERE   @varIsExisting = 0                      
;


END;
-- DELIMITER ;





