CREATE PROCEDURE `BudgetExpenseUpdate`(BudgetItemID INT, BudgetNumber INT, Amount DECIMAL(10, 4), BudgetGroupID INT, BudgetGroup VARCHAR(100), BudgetCategoryID INT, BudgetCategory VARCHAR(100), Description VARCHAR(1000), Note VARCHAR(1000), IsEssential INT, HasSpotlight INT, HasFundFlg INT, FundID INT, FundName VARCHAR(100), StartingBalance DECIMAL(10, 4))
BEGIN 
	IF BudgetGroupID > 0 THEN
        CALL BudgetGroupUpdate(BudgetGroupID, BudgetGroup);
	ELSE
        CALL BudgetGroupInsert(BudgetGroup, @BudgetGroupID);
        
        SET BudgetGroupID = @BudgetGroupID;
	END IF;
    

	IF HasFundFlg = 1 AND FundID > 0 THEN
        CALL BudgetFundUpdate(FundName, StartingBalance, FundID);
        
	ELSEIF HasFundFlg = 1 AND FundID = 0 THEN
        CALL BudgetFundInsert(FundName, StartingBalance, @FundID);
        
        SET FundID = @FundID;
        
	ELSEIF HasFundFlg = 0 THEN
		SET FundID = NULL;
        
    END IF;
    
    
    IF BudgetCategoryID > 0 THEN        
        CALL BudgetCategoryUpdate(BudgetCategoryID, BudgetGroupID, FundID, BudgetCategory, Description, Note, IsEssential, HasSpotlight);
	ELSE
        CALL BudgetCategoryInsert(BudgetGroupID, FundID, BudgetCategory, Description, Note, IsEssential, HasSpotlight, @BudgetCategoryID);
        
        SET BudgetCategoryID = @BudgetCategoryID;
	END IF;


	IF BudgetItemID > 0 THEN        
        CALL BudgetItemUpdate(BudgetItemID, BudgetNumber, BudgetCategoryID, 2, Amount);
	ELSE
        CALL BudgetItemInsert(BudgetNumber, BudgetCategoryID, 2, Amount);
	END IF;
END