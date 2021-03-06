USE `planner`;

DROP PROCEDURE IF EXISTS `CalendarGenerate`;

DELIMITER ;;
CREATE PROCEDURE `CalendarGenerate`()
BEGIN
    
	SET @varEffectiveDT = '2014-03-16';
    SET @varMaxDT = '2085-09-11';
	SET @i = 1; 
    
    
    
    TRUNCATE TABLE Calendar;



	WHILE @i = 1 DO
    
		IF @varEffectiveDT > @varMaxDT THEN 
			SET @i = 0;
		END IF;
		
        
		INSERT INTO Calendar
		(
			EffectiveDT 		
			,YearNumber 		
			,MonthNumber  	
			,WeekNumber 
            ,WeekDayNumber
			,DayNumber  	
            ,QuarterNumber
		)
		SELECT	DATE_FORMAT(@varEffectiveDT ,'%Y-%m-%d')	AS EffectiveDT 		
				,YEAR(@varEffectiveDT) 						AS YearNumber 		
				,MONTH(@varEffectiveDT) 					AS MonthNumber  	
				,(WEEK(@varEffectiveDT) + 1) 				AS WeekNumber  	
                ,WEEKDAY(@varEffectiveDT)					AS WeekDayNumber
                ,DAY(@varEffectiveDT) 						AS DayNumber
                ,QUARTER(@varEffectiveDT)					AS QuarterNumber
		;
		
        
		SET @varEffectiveDT = DATE_ADD(@varEffectiveDT, INTERVAL 1 DAY);
        
	END WHILE;
    
    
    
	UPDATE	Calendar
	SET		MonthID 		= CONCAT(YearNumber, LPAD(MonthNumber, 2, '0' ))
            ,WeekID			= CONCAT(YearNumber, LPAD(WeekNumber, 2, '0' ))
            ,DayID			= CONCAT(YearNumber, LPAD(MonthNumber, 2, '0' ), LPAD(DayNumber, 2, '0' ))
            ,MonthName		= MONTHNAME(EffectiveDT)
            ,DayName		= DAYNAME(EffectiveDT)
            ,MonthBegin		= CONCAT(YearNumber, '-',MonthNumber, '-01')
			,MonthEnd 		= CASE
								WHEN MonthNumber = 12 THEN CONCAT(YearNumber, '-',(MonthNumber), '-31')
								ELSE DATE_ADD(CONCAT(YearNumber, '-',(MonthNumber + 1), '-01'), INTERVAL -1 DAY) 
							END
            ,WeekBegin 		= CASE 
								WHEN WeekDayNumber = 0 THEN DATE_ADD(EffectiveDT, INTERVAL -1 DAY)
								WHEN WeekDayNumber = 1 THEN DATE_ADD(EffectiveDT, INTERVAL -2 DAY)
								WHEN WeekDayNumber = 2 THEN DATE_ADD(EffectiveDT, INTERVAL -3 DAY)
								WHEN WeekDayNumber = 3 THEN DATE_ADD(EffectiveDT, INTERVAL -4 DAY)
								WHEN WeekDayNumber = 4 THEN DATE_ADD(EffectiveDT, INTERVAL -5 DAY)
								WHEN WeekDayNumber = 5 THEN DATE_ADD(EffectiveDT, INTERVAL -6 DAY)
								WHEN WeekDayNumber = 6 THEN EffectiveDT
							END
			 ,WeekEnd 		= CASE 
								WHEN WeekDayNumber = 0 THEN DATE_ADD(EffectiveDT, INTERVAL 5 DAY)
								WHEN WeekDayNumber = 1 THEN DATE_ADD(EffectiveDT, INTERVAL 4 DAY)
								WHEN WeekDayNumber = 2 THEN DATE_ADD(EffectiveDT, INTERVAL 3 DAY)
								WHEN WeekDayNumber = 3 THEN DATE_ADD(EffectiveDT, INTERVAL 2 DAY)
								WHEN WeekDayNumber = 4 THEN DATE_ADD(EffectiveDT, INTERVAL 1 DAY)
								WHEN WeekDayNumber = 5 THEN EffectiveDT
								WHEN WeekDayNumber = 6 THEN DATE_ADD(EffectiveDT, INTERVAL 6 DAY)
							END
            ,QuarterID		= CONCAT(YearNumber, LPAD(QuarterNumber, 2, '0' ))
	;
    
    
    
    UPDATE Calendar
    SET		WeekNumber = 1
    WHERE	WeekNumber = 53
    ;
    
    
    
	UPDATE Calendar
    SET		WeekID = CONCAT((YearNumber + 1), LPAD(WeekNumber, 2, '0' ))
    WHERE	WeekID = CONCAT(YearNumber, '53')
    ;
        
    

END;;
DELIMITER ;



CALL CalendarGenerate();


select * from Calendar where EffectiveDT between '2018-12-20' and '2020-01-20' order by CalendarID;

-- select * from Calendar where WeekNumber = 0;

-- select *, concat((YearNumber - 1), '52') AS newWeekID from Calendar where WeekID = concat(YearNumber, '00');
	