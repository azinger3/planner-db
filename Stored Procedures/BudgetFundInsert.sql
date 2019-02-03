USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetFundInsert`;

DELIMITER ;;


CREATE PROCEDURE `BudgetFundInsert`(IN FundName VARCHAR(100), IN StartingBalance DECIMAL(10, 4), OUT FundID INT)
BEGIN
	INSERT INTO Fund
    (
		FundTypeID
        ,FundName
        ,StartingBalance
        ,CreateDT
        ,CreateBy
    )
    SELECT	1					AS FundTypeID
			,FundName			AS FundName
			,StartingBalance	AS StartingBalance
            ,NOW()				AS CreateDT
            ,'User'				AS CreateBy
	;
    
    
    SET FundID = LAST_INSERT_ID();
END;;
DELIMITER ;