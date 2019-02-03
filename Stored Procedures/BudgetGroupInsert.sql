USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetGroupInsert`;

DELIMITER ;;

CREATE PROCEDURE `BudgetGroupInsert`(IN BudgetGroup VARCHAR(100), OUT BudgetGroupID INT)
BEGIN
	INSERT INTO BudgetGroup
	(
		BudgetGroup
		,CreateDT
		,CreateBy
	)
	SELECT	BudgetGroup
			,NOW()
			,'User'
	;


	SET BudgetGroupID = LAST_INSERT_ID();
END;;
DELIMITER ;