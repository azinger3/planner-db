CREATE PROCEDURE `BudgetByMonthValidate`(BudgetMonth DATETIME)
BEGIN
	DECLARE BudgetNumber INT(10);
    DECLARE HasBudgetFlg INT(1);

	SET BudgetNumber = EXTRACT(YEAR_MONTH FROM BudgetMonth); 
	SET HasBudgetFlg = 0;

	SET	HasBudgetFlg = (SELECT COUNT(Budget.BudgetID) FROM Budget Budget WHERE Budget.BudgetNumber = BudgetNumber);

	SELECT HasBudgetFlg AS HasBudgetFlg;
END