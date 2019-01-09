CREATE PROCEDURE `BudgetExpenseDelete`(BudgetItemID INT)
BEGIN
	DELETE FROM	BudgetItem
    WHERE		BudgetItem.BudgetItemID = BudgetItemID
    ;
END