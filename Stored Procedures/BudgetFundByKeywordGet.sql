USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetFundByKeywordGet`;

DELIMITER ;;


CREATE PROCEDURE `BudgetFundByKeywordGet`(Keyword VARCHAR(100))
BEGIN
	SELECT		FundID
				,FundName
				,CAST(StartingBalance AS DECIMAL(10, 2)) AS StartingBalance
                ,Note
                ,Sort
                ,CreateDT
                ,CreateBy
                ,ModifyDT
                ,ModifyBy
                ,ActiveFlg
	FROM		Fund Fund
    WHERE		(Fund.FundName LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    ORDER BY	Fund.FundName
    ;
END;;
DELIMITER ;