USE planner;


-- stand up
DROP TABLE IF EXISTS Standup;

CREATE TABLE Standup
(
	StandupID      INT(10) NOT NULL AUTO_INCREMENT
	,EffectiveDT	DATETIME
	,Description	VARCHAR(1000)
	,CreateDT      DATETIME DEFAULT(NOW())
	,CreateBy      VARCHAR(100)
	,ModifyDT		DATETIME
	,ModifyBy		VARCHAR(100)
	,ActiveFlg		INT(10) DEFAULT '1'
	,PRIMARY KEY (`StandupID`)
);

CREATE INDEX ixStandup001 ON Standup(EffectiveDT);


-- stand up item
DROP TABLE IF EXISTS StandupItem;

CREATE TABLE StandupItem
(
	StandupItemID  INT(10) NOT NULL AUTO_INCREMENT
	,StandupID		INT(10)
	,Subject			VARCHAR(1000)
	,ActionItem		VARCHAR(1000)
	,PriorityID		INT(10)
	,CreateDT      DATETIME DEFAULT(NOW())
	,CreateBy      VARCHAR(100)
	,ModifyDT		DATETIME
	,ModifyBy		VARCHAR(100)
	,ActiveFlg		INT(10) DEFAULT '1'
	,PRIMARY KEY (`StandupItemID`)
);



-- test data
INSERT INTO Standup
(
   EffectiveDT					
	,Description 					
	,CreateBy 			    
)
SELECT  '2020-06-04'        			AS EffectiveDT						
        ,'Daily Standup 06/04/2020'	AS Description 											
        ,'User'              			AS CreateBy   
;



INSERT INTO StandupItem
(
   StandupID					
	,Subject 					
	,ActionItem 		
	,PriorityID 
	,CreateBy 
)

SELECT	1									AS StandupID
			,'Receiving 2020'				AS Subject
			,'test case development'	AS ActionItem
			,2									AS PriorityID
			,'User'							AS CreateBy	       
UNION
SELECT	1									AS StandupID
			,'Batching Support'			AS Subject
			,'bug fix'						AS ActionItem
			,2									AS PriorityID
			,'User'							AS CreateBy	       
UNION
SELECT	1									AS StandupID
			,'OneSource - PO Profile'	AS Subject
			,'backend development'		AS ActionItem
			,1									AS PriorityID
			,'User'							AS CreateBy	 
;

-- verify
SELECT		*
FROM 			Standup Standup
INNER JOIN	StandupItem StandupItem 
ON				StandupItem.StandupID = Standup.StandupID

