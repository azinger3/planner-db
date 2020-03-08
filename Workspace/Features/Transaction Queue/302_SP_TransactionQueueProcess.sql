USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionQueueProcess`;

CREATE PROCEDURE `TransactionQueueProcess`
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
PURPOSE:		Process Transction Queue
AUTHOR:			Rob Azinger
DATE:			03/08/2020
NOTES:			
CHANGE CONTROL:		 
***********************************************************************************************/


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
;


END;





