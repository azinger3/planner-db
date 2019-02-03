USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetCategoryInsert`;

DELIMITER ;;


CREATE PROCEDURE `BudgetCategoryInsert`(IN BudgetGroupID INT, IN FundID INT, BudgetCategory VARCHAR(100), IN Description VARCHAR(1000), IN Note VARCHAR(1000), IN IsEssential INT, IN HasSpotlight INT, OUT BudgetCategoryID INT)
BEGIN
	INSERT INTO	BudgetCategory
    (
		BudgetGroupID
		,FundID
		,BudgetCategory
		,Description
		,Note
		,IsEssential
		,HasSpotlight
		,CreateDT
		,CreateBy
    )
    SELECT	BudgetGroupID
			,FundID
			,BudgetCategory
			,Description
			,Note
			,IsEssential
			,HasSpotlight
			,NOW()
			,'User'
    ;
    
    
    SET BudgetCategoryID = LAST_INSERT_ID();
END;;
DELIMITER ;