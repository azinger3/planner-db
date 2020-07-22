USE planner;


DROP PROCEDURE IF EXISTS `SplitString`;

DELIMITER ;;


CREATE procedure `SplitString`()
BEGIN
	
	DECLARE varString VARCHAR(1000);
	DECLARE varDelimiter VARCHAR(100);
    DECLARE varStringLength INT DEFAULT 0;
	DECLARE varSegment VARCHAR(100);
    DECLARE varSegmentLength INT DEFAULT 0;
	DECLARE varStartID INT DEFAULT 1;
	DECLARE varEndID INT DEFAULT 1;
	DECLARE i INT DEFAULT 0;


	SET varDelimiter = CHAR(10);


	DROP TEMPORARY TABLE IF EXISTS tmpSplit;

	CREATE TEMPORARY TABLE tmpSplit
	(
		KeyID 							INT(10) NOT NULL AUTO_INCREMENT
        ,varString						VARCHAR(100)
        ,varStringLength			INT(10)
		,varSegment				VARCHAR(100)
        ,varSegmentLength		INT(10)
        ,varStartID					INT(10)
        ,varEndID					INT(10)
		,PRIMARY KEY (`KeyID`)
	); 


	SELECT 	TransactionSms.Body AS varString
	FROM 	TransactionSms TransactionSms
	WHERE	TransactionSms.TransactionSmsID = 5
	INTO 		varString
	;


	SET varStringLength = LENGTH(varString);
	

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
        

		INSERT INTO tmpSplit
		(
			varString
            ,varStringLength
			,varSegment
            ,varSegmentLength
            ,varStartID
            ,varEndID
		)
		SELECT 	varString AS varString
						,varStringLength AS varStringLength
						,varSegment AS varSegment
                        ,varSegmentLength AS varSegmentLength
						,varStartID AS varStartID
						,varEndID AS varEndID
		;
        
        
        SET varStartID = varEndID + 1;
        
	END WHILE;

    
    SELECT * FROM tmpSplit;
    
END;;
DELIMITER ;



CALL SplitString();

/*
SELECT LOCATE(CHAR(10), 'Target, 60.60
Need, 30.30
Shoes for vi, 20.20
Food, 10.10', 15) AS testme1
,SUBSTRING('Target, 60.60
Need, 30.30
Shoes for vi, 20.20
Food, 10.10', 15, 11) AS testme2 
*/

