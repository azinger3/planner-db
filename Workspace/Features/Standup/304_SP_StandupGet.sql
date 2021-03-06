USE `planner`;


DROP PROCEDURE IF EXISTS `StandupGet`;

DELIMITER ;;
CREATE PROCEDURE `StandupGet`()
BEGIN


/********************************************************************************************** 
PURPOSE:		Get a Standup
AUTHOR:		Rob Azinger
DATE:				06/04/2020
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


SELECT		Standup.StandupID
				,Standup.EffectiveDT
				,Standup.Description
				,StandupItem.StandupItemID
				,StandupItem.Subject
				,StandupItem.ActionItem
				,CONCAT('- ', StandupItem.Subject, ' ---> ', StandupItem.ActionItem, '...') AS SubjectActionItem
				,StandupItem.PriorityID
				,CASE StandupItem.PriorityID WHEN 1 THEN 'Today' WHEN 2 THEN 'Yesterday' ELSE 0 END AS Priority
				,StandupItem.CreateDT
				,StandupItem.CreateBy
				,StandupItem.ModifyDT
				,StandupItem.ModifyBy
				,StandupItem.ActiveFlg
FROM 			Standup Standup
INNER JOIN	StandupItem StandupItem 
ON				StandupItem.StandupID = Standup.StandupID
ORDER BY Standup.EffectiveDT 		DESC
					,StandupItem.PriorityID 	DESC
;



END;;
DELIMITER ;