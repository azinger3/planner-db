CREATE FUNCTION `MonthNumberGet`(BudgetMonth DATETIME) RETURNS int(11)
BEGIN
	DECLARE MonthNumber INT(2);
    
	SET MonthNumber = MONTH(BudgetMonth) + 9;
    
    IF MonthNumber > 12 THEN
		SET MonthNumber = MonthNumber - 12;
    END IF;
		
	RETURN MonthNumber;
END