DROP PROCEDURE IF EXISTS `BudgetFundGet`;

DELIMITER ;;
CREATE PROCEDURE `BudgetFundGet`()
BEGIN
	SELECT		FundID
				,FundName
				,StartingBalance
                ,Note
                ,Sort
                ,CreateDT
                ,CreateBy
                ,ModifyDT
                ,ModifyBy
                ,ActiveFlg
	FROM		Fund Fund
    ORDER BY	Fund.FundName
    ;
END ;;