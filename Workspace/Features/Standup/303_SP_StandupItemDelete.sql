USE `planner`;


DROP PROCEDURE IF EXISTS `StandupItemDelete`;

DELIMITER ;;
CREATE PROCEDURE `StandupItemDelete`(prmStandupItemID INT)
BEGIN


/********************************************************************************************** 
PURPOSE:		Delete a Standup Item
AUTHOR:		Rob Azinger
DATE:			06/04/2019
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


DELETE FROM	StandupItem
WHERE			StandupItemID = prmStandupItemID
;



END;;
DELIMITER ;