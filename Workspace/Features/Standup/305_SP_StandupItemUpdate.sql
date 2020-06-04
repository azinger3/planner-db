USE `planner`;


DROP PROCEDURE IF EXISTS `StandupItemUpdate`;

DELIMITER ;;
CREATE PROCEDURE `StandupItemUpdate`(prmStandupItemID INT, prmSubject VARCHAR(1000), prmActionItem VARCHAR(1000), prmPriorityID INT)
BEGIN


/********************************************************************************************** 
PURPOSE:		Update a Standup Item
AUTHOR:		Rob Azinger
DATE:			06/04/2019
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


UPDATE		StandupItem
SET			Subject 		= prmSubject
				,ActionItem	= prmActionItem
				,ModifyBy 	= 'User'
				,ModifyDT 	= NOW()
WHERE			StandupItemID = prmStandupItemID
;



END;;
DELIMITER ;