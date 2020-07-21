USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionSmsInsert`;

DELIMITER ;;
CREATE PROCEDURE `TransactionSmsInsert` 
(
	prmSender VARCHAR(100)
	,prmBody VARCHAR(1000)
)
BEGIN

SET @varSender = prmSender;
SET @varBody = prmBody;

INSERT INTO TransactionSms
(
	Sender					
	,Body
	,CreateBy
)
SELECT  @varSender	AS Sender						
				,@varBody		AS Body
				,'Bot'				AS CreateBy
;

END;;
DELIMITER ;