CREATE PROCEDURE `TransactionDelete`(TransactionID INT)
BEGIN
	DELETE FROM Transaction
    WHERE Transaction.TransactionID = TransactionID
    ;
END