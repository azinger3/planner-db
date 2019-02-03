USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetInsert`;

DELIMITER ;;

CREATE PROCEDURE `BudgetInsert`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetIDPrevious INT;
    DECLARE BudgetIDNew INT;
    DECLARE BudgetNumber VARCHAR(100);
    
    SET BudgetIDPrevious = (SELECT Budget.BudgetID FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, DATE_ADD(BudgetMonth, INTERVAL -1 MONTH)) = 0);
    SET BudgetNumber =  EXTRACT(YEAR_MONTH FROM BudgetMonth);
    
    
    INSERT INTO Budget
    (
		BudgetNumber
        ,BudgetMonth
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetNumber
			,BudgetMonth
            ,NOW()
            ,'User'
	FROM DUAL
	WHERE NOT EXISTS (SELECT Budget.BudgetMonth FROM Budget Budget WHERE TIMESTAMPDIFF(MONTH, Budget.BudgetMonth, BudgetMonth) = 0)
    ;

    SET BudgetIDNew = LAST_INSERT_ID();
    
    
	INSERT INTO BudgetItem
    (
		BudgetID
        ,BudgetCategoryID
        ,BudgetTypeID
        ,Amount
        ,Sort
        ,CreateDT
        ,CreateBy
    )
    SELECT	BudgetIDNew
            ,BudgetItem.BudgetCategoryID
            ,BudgetItem.BudgetTypeID
            ,BudgetItem.Amount
            ,BudgetItem.Sort
            ,NOW()
            ,'User'
    FROM 	BudgetItem BudgetItem
    WHERE	BudgetItem.BudgetID = BudgetIDPrevious 
    AND 	BudgetIDPrevious IS NOT NULL
    AND		BudgetIDNew <> 0;
    
    
END;;
DELIMITER ;