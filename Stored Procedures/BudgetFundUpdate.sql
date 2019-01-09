CREATE PROCEDURE `BudgetFundUpdate`(IN FundName VARCHAR(100), IN StartingBalance DECIMAL(10, 4), IN FundID INT)
BEGIN
	UPDATE 	Fund
    SET		Fund.FundName = FundName
			,Fund.StartingBalance = StartingBalance
            ,Fund.ModifyDT = NOW()
            ,Fund.ModifyBy = 'User'
    WHERE	Fund.FundID = FundID
    ;
END