USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionDelete`;

DELIMITER ;;

CREATE PROCEDURE `TransactionDelete`(TransactionID INT)
BEGIN
	DELETE FROM Transaction
    WHERE Transaction.TransactionID = TransactionID
    ;
END;;
DELIMITER ;