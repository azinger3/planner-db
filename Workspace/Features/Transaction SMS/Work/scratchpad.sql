USE planner;


DROP PROCEDURE IF EXISTS `SplitString`;

DELIMITER ;;


CREATE procedure `SplitString`()
BEGIN
	
	DECLARE varBody VARCHAR(1000);
	DECLARE varDelimiter VARCHAR(100);
	DECLARE varSegmentLength VARCHAR(100);
	DECLARE varSegmentString VARCHAR(100);
	DECLARE varStartID INT DEFAULT 1;
	DECLARE varEndID INT DEFAULT 1;

	SET varBody = '';
	SET varDelimiter = CHAR(10);
	SET varSegmentLength = 1;
	SET varSegmentString = '';
	-- SET varStartID = 1;
	-- SET varEndID = 1;


	DROP TEMPORARY TABLE IF EXISTS tmpSplit;

	CREATE TEMPORARY TABLE tmpSplit
	(
		KeyID 					INT(10) NOT NULL AUTO_INCREMENT
		,SegmentString	VARCHAR(100)
		,PRIMARY KEY (`KeyID`)
	); 


	SELECT 	TransactionSms.Body AS Body
	FROM 	TransactionSms TransactionSms
	WHERE	TransactionSms.TransactionSmsID = 5
	INTO 		varBody
	;


	SET varEndID = LENGTH(varBody);
    
        
	SELECT 	varBody AS Body
					,varSegmentLength AS SegmentLength
					,varSegmentString AS SegmentString
					,varStartID AS StartID
					,varEndID AS EndID
	;


	WHILE varStartID < varEndID DO
    
    	SET varSegmentLength = LOCATE(varDelimiter, varBody, varStartID);
		SET varSegmentString = SUBSTRING(varBody, varStartID, varSegmentLength);
    
    
		SELECT 	varBody AS Body
						,varSegmentLength AS SegmentLength
						,varSegmentString AS SegmentString
						,varStartID AS StartID
						,varEndID AS EndID
		;
        
        
		INSERT INTO tmpSplit
		(
			SegmentString
		)
		SELECT varSegmentString AS SegmentString
		;
        
        
        SET varStartID = varStartID + varSegmentLength;
        
	END WHILE;

    
    SELECT * FROM tmpSplit;
    
END;;
DELIMITER ;



CALL SplitString();

