USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetFundSummaryGet`;

DELIMITER ;;

CREATE PROCEDURE `BudgetFundSummaryGet`(FundID INT)
BEGIN
	DECLARE SessionID VARCHAR(100);

	SET SessionID = UUID();

	INSERT INTO	tmpBudgetFundSummary
	(
		SessionID
		,FundID
		,FundName
		,BudgetCategoryID
		,BudgetCategory
		,TransactionID
		,TransactionTypeID
		,TransactionNumber
		,TransactionDT
		,Amount
		,Description
		,Note
		,StartingBalance
	)
	SELECT		SessionID							AS SessionID
				,Fund.FundID						AS FundID
				,Fund.FundName						AS FundName
				,BudgetCategory.BudgetCategoryID	AS BudgetCategoryID
				,BudgetCategory.BudgetCategory		AS BudgetCategory
				,Transaction.TransactionID			AS TransactionID
				,Transaction.TransactionTypeID		AS TransactionTypeID
				,Transaction.TransactionNumber		AS TransactionNumber
				,Transaction.TransactionDT			AS TransactionDT
				,Transaction.Amount					AS Amount
				,Transaction.Description			AS Description
				,Transaction.Note					AS Note
				,Fund.StartingBalance				AS StartingBalance
	FROM		Transaction Transaction
	INNER JOIN	BudgetCategory BudgetCategory
	ON			BudgetCategory.BudgetCategoryID = Transaction.BudgetCategoryID
	INNER JOIN	Fund Fund
	ON			Fund.FundID = BudgetCategory.FundID
	WHERE		Transaction.TransactionTypeID IN (3, 4)
	AND			Fund.FundID = FundID
	;

	UPDATE		tmpBudgetFundSummary
	INNER JOIN	(
					SELECT 		SUM(ABS(tmpBudgetFundSummary.Amount))	AS FundReceived 
					FROM 		tmpBudgetFundSummary tmpBudgetFundSummary	
					WHERE		tmpBudgetFundSummary.TransactionTypeID = 3
				) RS
	SET			tmpBudgetFundSummary.FundReceived = IFNULL(RS.FundReceived, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;
    
	UPDATE		tmpBudgetFundSummary
	INNER JOIN	(
					SELECT 		SUM(ABS(tmpBudgetFundSummary.Amount))	AS FundSpent 
					FROM 		tmpBudgetFundSummary tmpBudgetFundSummary	
					WHERE		tmpBudgetFundSummary.TransactionTypeID = 4
				) RS
	SET			tmpBudgetFundSummary.FundSpent = IFNULL(RS.FundSpent, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;

	UPDATE		tmpBudgetFundSummary
	SET			tmpBudgetFundSummary.FundReceivedPlusStartingBalance = IFNULL(tmpBudgetFundSummary.FundReceived, 0) + IFNULL(tmpBudgetFundSummary.StartingBalance, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;

	UPDATE		tmpBudgetFundSummary
	SET			tmpBudgetFundSummary.FundSpentVsReceived = IFNULL(tmpBudgetFundSummary.FundReceivedPlusStartingBalance, 0) - IFNULL(tmpBudgetFundSummary.FundSpent, 0)
	WHERE 		tmpBudgetFundSummary.SessionID = SessionID
	;
    
    INSERT INTO tmpBudgetFundSummary
    (
		SessionID
        ,FundID
        ,FundName
        ,StartingBalance
        ,FundSpent
        ,FundReceived
        ,FundSpentVsReceived
    )
	SELECT	SessionID				AS SessionID
			,Fund.FundID			AS FundID
			,Fund.FundName			AS FundName
			,Fund.StartingBalance	AS StartingBalance
            ,0						AS FundSpent
            ,0						AS FundReceived
            ,0						AS FundSpentVsReceived
    FROM	Fund Fund
    WHERE	Fund.FundID = FundID
    AND		(SELECT COUNT(1) FROM tmpBudgetFundSummary) = 0
    ;
    
	SELECT		tmpBudgetFundSummary.KeyID								AS KeyID
				,SessionID												AS SessionID
				,tmpBudgetFundSummary.FundID							AS FundID
				,tmpBudgetFundSummary.FundName							AS FundName
				,tmpBudgetFundSummary.BudgetCategoryID					AS BudgetCategoryID
				,tmpBudgetFundSummary.BudgetCategory					AS BudgetCategory
				,tmpBudgetFundSummary.TransactionID						AS TransactionID
				,tmpBudgetFundSummary.TransactionTypeID					AS TransactionTypeID
				,tmpBudgetFundSummary.TransactionNumber					AS TransactionNumber
				,DateMask(tmpBudgetFundSummary.TransactionDT)			AS TransactionDT
				,tmpBudgetFundSummary.Amount							AS Amount
				,tmpBudgetFundSummary.Description						AS Description
				,tmpBudgetFundSummary.Note								AS Note
				,tmpBudgetFundSummary.StartingBalance					AS StartingBalance
				,tmpBudgetFundSummary.FundSpent							AS FundSpent
				,tmpBudgetFundSummary.FundReceived						AS FundReceived
				,tmpBudgetFundSummary.FundReceivedPlusStartingBalance	AS FundReceivedPlusStartingBalance
				,tmpBudgetFundSummary.FundSpentVsReceived				AS FundSpentVsReceived
	FROM		tmpBudgetFundSummary
    WHERE		tmpBudgetFundSummary.SessionID = SessionID
    ORDER BY	tmpBudgetFundSummary.TransactionDT DESC
	;

	DELETE FROM	tmpBudgetFundSummary 
	WHERE		tmpBudgetFundSummary.SessionID = SessionID
	;
END;;
DELIMITER ;