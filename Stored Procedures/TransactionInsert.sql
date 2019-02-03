USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionInsert`;

DELIMITER ;;

CREATE PROCEDURE `TransactionInsert`(TransactionTypeID INT, TransactionNumber VARCHAR(100), TransactionDT DATETIME, BudgetCategoryID INT, Amount DECIMAL(10 ,4), Description VARCHAR(1000), Note VARCHAR(1000))
BEGIN
	DECLARE BudgetNumber INT(10);
    DECLARE FundID INT(1);
    DECLARE IsNegativeFlg INT(1);
    
    SET BudgetNumber = EXTRACT(YEAR_MONTH FROM TransactionDT);
    SET FundID = (SELECT BudgetCategory.FundID FROM BudgetCategory WHERE BudgetCategory.BudgetCategoryID = BudgetCategoryID);
    SET IsNegativeFlg = (IFNULL((SELECT '1' FROM DUAL WHERE Amount < 0), 0));

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
        ,CreateDT
        ,CreateBy
    )
    SELECT	TransactionTypeID
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,Note
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	IsNegativeFlg = 0
    ;
    
    -- Fund Saved
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
        ,CreateDT
        ,CreateBy
    )
    SELECT	'3' -- Saved
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,'Added to fund'
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	TransactionTypeID = 2
	AND 	FundID IS NOT NULL
	AND		IsNegativeFlg = 0
    ;
    
    -- Fund Spent
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
        ,CreateDT
        ,CreateBy
    )
    SELECT	'4' -- Spent
			,TransactionNumber
			,TransactionDT
			,BudgetNumber
			,BudgetCategoryID
			,Amount
			,Description
            ,'Spent from fund'
            ,NOW()
            ,'User'
	FROM 	DUAL 
	WHERE	TransactionTypeID = 2
	AND 	FundID IS NOT NULL
	AND		IsNegativeFlg = 1
    ;
END;;
DELIMITER ;