USE `planner`;


DROP PROCEDURE IF EXISTS `StandupItemInsert`;

DELIMITER ;;
CREATE PROCEDURE `StandupItemInsert`(prmStandupID INT, prmSubject VARCHAR(1000), prmActionItem VARCHAR(1000))
BEGIN


/********************************************************************************************** 
PURPOSE:		Insert a Standup Item
AUTHOR:		Rob Azinger
DATE:			06/04/2019
NOTES:		
CHANGE CONTROL:		 
***********************************************************************************************/


INSERT INTO StandupItem
(
	StandupID
	,Subject
	,ActionItem
	,PriorityID
	,CreateBy
)
SELECT	prmStandupID		AS StandupID
			,prmSubject 		AS Subject
			,prmActionItem		AS ActionItem
			,1						AS PriorityID
			,'User' 				AS CreateBy
;



END;;
DELIMITER ;