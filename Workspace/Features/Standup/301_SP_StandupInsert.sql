USE `planner`;


DROP PROCEDURE IF EXISTS `StandupInsert`;

DELIMITER ;;
CREATE PROCEDURE `StandupInsert`(prmEffectiveDT DATETIME)
BEGIN


/********************************************************************************************** 
PURPOSE:		Insert a Standup
AUTHOR:		Rob Azinger
DATE:			06/04/2019
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


/**********************************************************************************************
	STEP 01:		Initialize variables to store parameter & scope data
***********************************************************************************************/

SET @varEffectiveDT = prmEffectiveDT;
SET @varDescription = CONCAT('Daily Standup ', DateMask(prmEffectiveDT));
SET @varHasExistingFlg = (IFNULL((SELECT '1' FROM Standup WHERE EffectiveDT = @varEffectiveDT LIMIT 1), 0));


-- Yesterday
SET @varYesterdayEffectiveDT = DATE_ADD(prmEffectiveDT, INTERVAL -1 DAY);
SET @varYesterdayStandupID = (IFNULL((SELECT StandupID FROM Standup WHERE EffectiveDT = @varYesterdayEffectiveDT LIMIT 1), 0));



/**********************************************************************************************
	STEP 02:		Insert Standup
***********************************************************************************************/

SET @StandupID = 0;

INSERT INTO Standup
(
	EffectiveDT
	,Description
	,CreateBy
)
SELECT	@varEffectiveDT 	AS varEffectiveDT
			,@varDescription 	AS varDescription
			,'User' 				AS CreateBy
WHERE		@varHasExistingFlg = 0
;

SET @StandupID = LAST_INSERT_ID();



/**********************************************************************************************
	STEP 03:		Insert Standup Items
***********************************************************************************************/

-- Yesterday
INSERT INTO StandupItem
(
	StandupID
	,Subject
	,ActionItem
	,PriorityID
	,CreateBy
)
SELECT	@StandupID					AS StandupID
			,StandupItem.Subject 	AS Subject
			,StandupItem.ActionItem	AS ActionItem
			,2								AS PriorityID -- Lower Yesterday's Priority
			,'User' 						AS CreateBy
FROM		StandupItem StandupItem
WHERE		StandupID = @varYesterdayStandupID
AND		@varHasExistingFlg = 0
;



END;;
DELIMITER ;





