USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetFundGet`;

DELIMITER ;;
CREATE PROCEDURE `BudgetFundGet`()
BEGIN
    SELECT		Fund.FundID				AS FundID
                ,Fund.FundName			AS FundName
                ,Fund.StartingBalance   AS StartingBalance
                ,Fund.Note				AS Note
                ,Fund.Sort				AS Sort
                ,Fund.CreateDT			AS CreateDT
                ,Fund.CreateBy			AS CreateBy
                ,Fund.ModifyDT			AS ModifyDT
                ,Fund.ModifyBy			AS ModifyBy
                ,Fund.ActiveFlg			AS ActiveFlg
	FROM        Fund Fund
    WHERE       Fund.ActiveFlg = 1
    ORDER BY    Fund.FundName
    ;
END;;
DELIMITER ;