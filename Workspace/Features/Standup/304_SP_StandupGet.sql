USE `planner`;


DROP PROCEDURE IF EXISTS `StandupGet`;

DELIMITER ;;
CREATE PROCEDURE `StandupGet`(prmEffectiveDT DATETIME)
BEGIN


/********************************************************************************************** 
PURPOSE:		Get a Standup
AUTHOR:		Rob Azinger
DATE:			06/04/2019
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


SELECT		Standup.StandupID
				,Standup.EffectiveDT
				,Standup.Description
				,StandupItem.StandupItemID
				,StandupItem.Subject
				,StandupItem.ActionItem
				,StandupItem.CreateDT
				,StandupItem.CreateBy
				,StandupItem.ModifyDT
				,StandupItem.ModifyBy
				,StandupItem.ActiveFlg
FROM 			Standup Standup
INNER JOIN	StandupItem StandupItem 
ON				StandupItem.StandupID = Standup.StandupID
WHERE 		Standup.EffectiveDT = prmEffectiveDT
;



END;;
DELIMITER ;