USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetIncomeCalculate`;

DELIMITER ;;

CREATE PROCEDURE `BudgetIncomeCalculate`(BudgetNumber INT)
BEGIN
	UPDATE	BudgetItem
	SET		Amount = 	(
							SELECT	(SUM(TakeHomePay) * 26) / 12 AS Amount
							FROM	BudgetIncome BudgetIncome
							WHERE	BudgetIncome.BudgetNumber = BudgetNumber
						)
	WHERE	BudgetItem.BudgetCategoryID = 29
	AND		BudgetItem.BudgetNumber = BudgetNumber
    ;
END;;
DELIMITER ;