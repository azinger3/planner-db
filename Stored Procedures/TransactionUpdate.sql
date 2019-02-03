USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionUpdate`;

DELIMITER ;;


CREATE PROCEDURE `TransactionUpdate`(TransactionID INT, TransactionNumber VARCHAR(100), TransactionDT DATETIME, BudgetID INT, BudgetCategoryID INT, Amount DECIMAL(10 ,4), Description VARCHAR(1000), Note VARCHAR(1000))
BEGIN
	UPDATE	Transaction
    SET		Transaction.TransactionDT 		= TransactionDT
			,Transaction.BudgetNumber		= EXTRACT(YEAR_MONTH FROM TransactionDT)
            ,Transaction.BudgetCategoryID 	= BudgetCategoryID
            ,Transaction.Amount 			= Amount
            ,Transaction.TransactionNumber 	= TransactionNumber
            ,Transaction.Note 				= Note
            ,Transaction.Description 		= Description
            ,Transaction.ModifyDT			= NOW()
            ,Transaction.ModifyBy			= 'User'
	WHERE	Transaction.TransactionID = TransactionID
    ;
END;;
DELIMITER ;