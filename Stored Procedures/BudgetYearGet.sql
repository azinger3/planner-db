USE `planner`;

DROP PROCEDURE IF EXISTS `BudgetYearGet`;

DELIMITER ;;


CREATE PROCEDURE `BudgetYearGet`()
BEGIN
	DECLARE MaxDT DATETIME;
	DECLARE StartDT DATETIME;
	DECLARE EndDT DATETIME;
	DECLARE i INT; 
    DECLARE counter INT;
    
	SET MaxDT = CONVERT_TZ(NOW(), '+00:00','-05:00');
	SET StartDT = '2016-04-01';
	SET EndDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
	SET i = 1; 
    SET counter = 3;
    
    DROP TEMPORARY TABLE IF EXISTS tmpBudgetYear;

	CREATE TEMPORARY TABLE tmpBudgetYear
	(
		KeyID		INT(10) NOT NULL AUTO_INCREMENT
        ,StartDT	DATETIME
        ,EndDT		DATETIME
        ,YearName	VARCHAR(100)
        ,YearValue	VARCHAR(100)
        ,PRIMARY KEY (`KeyID`)
	);

	WHILE i = 1 DO
        IF EndDT > MaxDT THEN 
			SET EndDT = DATE_FORMAT(DATE_ADD(LAST_DAY(MaxDT), INTERVAL 1 DAY) ,'%Y-%m-%d');
			SET i = 0;
		END IF;
        
		INSERT INTO tmpBudgetYear
		(
			StartDT
			,EndDT
			,YearName
            ,YearValue
		)
		SELECT	StartDT						AS StartDT
				,EndDT						AS EndDT
				,CONCAT('Year ', counter)	AS YearName
                ,CONCAT(DATE_FORMAT(StartDT ,'%Y-%m-%d'), '|', DATE_FORMAT(EndDT ,'%Y-%m-%d')) AS YearValue
		;
        
		SET StartDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
		SET EndDT = DATE_ADD(StartDT, INTERVAL 12 MONTH);
        SET counter = counter + 1;
	END WHILE;

    
    SELECT		tmpBudgetYear.KeyID 		AS KeyID
				,tmpBudgetYear.StartDT 		AS StartDT
				,tmpBudgetYear.EndDT 		AS EndDT
				,CONCAT(DATE_FORMAT(tmpBudgetYear.StartDT,'%b %Y'), ' - ', DATE_FORMAT(tmpBudgetYear.EndDT,'%b %Y')) AS YearName
                ,tmpBudgetYear.YearValue	AS YearValue
    FROM 		tmpBudgetYear tmpBudgetYear
    ORDER BY	tmpBudgetYear.YearName DESC
    ;
END;;
DELIMITER ;