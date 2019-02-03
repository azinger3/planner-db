USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetBreakdownGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetBreakdownGet`(StartDT DATETIME, EndDT DATETIME)
BEGIN
	DECLARE SessionID VARCHAR(100);
    
    SET SessionID = UUID();

    INSERT INTO tmpBudgetBreakdown
    (
		SessionID
		,BudgetGroupID
		,BudgetGroup
		,BudgetCategoryID
		,BudgetCategory
		,ColorHighlight
    )
    SELECT		DISTINCT
				SessionID							AS SessionID
				,BudgetGroup.BudgetGroupID			AS BudgetGroupID
				,BudgetGroup.BudgetGroup			AS BudgetGroup
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,BudgetCategory.ColorHighlight		AS ColorHighlight
	FROM		Transaction Transaction
    INNER JOIN	TransactionType TransactionType
    ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
	INNER JOIN	BudgetCategory BudgetCategory
    ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
    INNER JOIN	BudgetGroup BudgetGroup
    ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
    WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
    AND			Transaction.TransactionTypeID = 2
	;
    
	UPDATE		tmpBudgetBreakdown
    INNER JOIN	(
					SELECT		BudgetCategory.BudgetCategoryID		AS BudgetCategoryID
								,SUM(Transaction.Amount)			AS CategoryTotal
					FROM		Transaction Transaction
					INNER JOIN	TransactionType TransactionType
					ON			TransactionType.TransactionTypeID = Transaction.TransactionTypeID
					INNER JOIN	BudgetCategory BudgetCategory
					ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
					INNER JOIN	BudgetGroup BudgetGroup
					ON			BudgetGroup.BudgetGroupID = BudgetCategory.BudgetGroupID
					WHERE		Transaction.TransactionDT BETWEEN StartDT AND EndDT
					AND			Transaction.TransactionTypeID = 2
					GROUP BY	BudgetCategory.BudgetCategoryID
								,BudgetCategory.BudgetCategory
				) RS
	ON			tmpBudgetBreakdown.BudgetCategoryID = RS.BudgetCategoryID
	SET			tmpBudgetBreakdown.CategoryTotal = RS.CategoryTotal
	WHERE 		tmpBudgetBreakdown.SessionID = SessionID
    ;
              
    UPDATE		tmpBudgetBreakdown
    JOIN		(
					SELECT		SUM(tmpBudgetBreakdown.CategoryTotal)	AS CategoryExpenseTotal 
					FROM 		tmpBudgetBreakdown tmpBudgetBreakdown	
				) RS
	SET			tmpBudgetBreakdown.CategoryExpenseTotal = RS.CategoryExpenseTotal	
    WHERE 		tmpBudgetBreakdown.SessionID = SessionID
    ;

	UPDATE      tmpBudgetBreakdown
	SET         CategoryPercentage = (CategoryTotal / CategoryExpenseTotal) * 100
    ;
    
	SELECT		tmpBudgetBreakdown.KeyID					AS KeyID
				,tmpBudgetBreakdown.SessionID				AS SessionID
				,tmpBudgetBreakdown.BudgetGroupID			AS BudgetGroupID
				,tmpBudgetBreakdown.BudgetGroup				AS BudgetGroup
				,tmpBudgetBreakdown.BudgetCategoryID 		AS BudgetCategoryID
				,tmpBudgetBreakdown.BudgetCategory			AS BudgetCategory
                ,CONCAT(tmpBudgetBreakdown.BudgetCategory, ' (', tmpBudgetBreakdown.CategoryPercentage,'%)')	AS CategoryLabel
                ,tmpBudgetBreakdown.ColorHighlight			AS ColorHighlight
                ,tmpBudgetBreakdown.CategoryTotal			AS CategoryTotal
                ,tmpBudgetBreakdown.CategoryExpenseTotal	AS CategoryExpenseTotal
				,tmpBudgetBreakdown.CategoryPercentage		AS CategoryPercentage
	FROM 		tmpBudgetBreakdown tmpBudgetBreakdown
    WHERE		tmpBudgetBreakdown.SessionID = SessionID
    ORDER BY	tmpBudgetBreakdown.CategoryTotal DESC
	LIMIT 		15
	;

	DELETE FROM	tmpBudgetBreakdown 
    WHERE		tmpBudgetBreakdown.SessionID = SessionID
    ;
END;;
DELIMITER ;