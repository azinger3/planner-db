USE planner;


DROP PROCEDURE IF EXISTS `TransactionSmsSplit`;


DELIMITER ;;
CREATE PROCEDURE `TransactionSmsSplit`
(
	prmString		VARCHAR(1000)
    ,prmDelimiter	VARCHAR(100)
)
BEGIN

/********************************************************************************************** 
PURPOSE:		Split a transaction sms
AUTHOR:		Rob Azinger
DATE:				07/22/2020
NOTES:			
CHANGE CONTROL:		 
***********************************************************************************************/

DECLARE varString VARCHAR(1000);
DECLARE varDelimiter VARCHAR(100);
DECLARE varStringLength INT DEFAULT 0;
DECLARE varSegment VARCHAR(100);
DECLARE varSegmentLength INT DEFAULT 0;
DECLARE varStartID INT DEFAULT 1;
DECLARE varEndID INT DEFAULT 1;
DECLARE i INT DEFAULT 0;


SET varString = prmString;
SET varDelimiter = prmDelimiter;
SET varStringLength = LENGTH(varString);


DROP TEMPORARY TABLE IF EXISTS tmpTransactionSmsSplit;

CREATE TEMPORARY TABLE tmpTransactionSmsSplit
(
	KeyID 							INT NOT NULL AUTO_INCREMENT
	,varString						VARCHAR(100)
	,varStringLength			INT
	,varSegment				VARCHAR(100)
	,varSegmentLength		INT
	,varStartID					INT
	,varEndID					INT
	,PRIMARY KEY (`KeyID`)
); 


WHILE i = 0 DO

	SET varEndID = LOCATE(varDelimiter, varString, varStartID);
	
	
	IF varEndID <= 0 THEN
		SET i = 1;
	END IF;
	
	
	IF varEndID > 0 THEN 
		SET varSegmentLength = (varEndID - varStartID); -- Next Item
	ELSE
		SET varSegmentLength = (varStringLength - varStartID + 1); -- Last Item
	END IF;
	
	
	SET varSegment = SUBSTRING(varString, varStartID, varSegmentLength);
	

	INSERT INTO tmpTransactionSmsSplit
	(
		varString
		,varStringLength
		,varSegment
		,varSegmentLength
		,varStartID
		,varEndID
	)
	SELECT 	varString						AS varString
					,varStringLength			AS varStringLength
					,TRIM(varSegment)	AS varSegment
					,varSegmentLength		AS varSegmentLength
					,varStartID					AS varStartID
					,varEndID					AS varEndID
	;
	
	
	SET varStartID = varEndID + 1;
	
END WHILE;

END;;
DELIMITER ;

