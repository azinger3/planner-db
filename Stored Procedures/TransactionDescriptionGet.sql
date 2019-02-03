USE `planner`;

DROP PROCEDURE IF EXISTS `TransactionDescriptionGet`;

DELIMITER ;;

CREATE PROCEDURE `TransactionDescriptionGet`(Keyword VARCHAR(100))
BEGIN
	SET @Description = '';			
	SET @TransactionDT = '';
	SET @TransactionID = '';
	SET @i = 1;

	SELECT 	RS.Description
			,RS.TransactionDT
			,RS.TransactionID
			,CAST(RS.Amount AS DECIMAL(10, 2)) AS Amount
            ,RS.BudgetCategoryID
	FROM	(
				SELECT  RSRank.Description
						,RSRank.TransactionDT
						,RSRank.TransactionID
						,RSRank.Amount
                        ,RSRank.BudgetCategoryID
						,RSRank.RankID
				FROM
				(
					SELECT  RSTransaction.Description
							,RSTransaction.TransactionDT
							,RSTransaction.TransactionID
							,RSTransaction.Amount
                            ,RSTransaction.BudgetCategoryID
							,@i := IF	(
											@Description = RSTransaction.Description, 
												IF	(
														@TransactionDT = RSTransaction.TransactionDT, 
															IF	(
																	@TransactionID = RSTransaction.TransactionID, 
																		@i, 
																	@i + 1 -- ELSE TransactionID
																), 
														@i + 1 -- ELSE TransactionDT
													),
											1 -- ELSE Description
										) AS RankID
							,@Description := RSTransaction.Description    
							,@TransactionDT := RSTransaction.TransactionDT
							,@TransactionID := RSTransaction.TransactionID
					FROM
					(
						SELECT  	Transaction.Description
									,Transaction.TransactionDT
									,Transaction.TransactionID
									,Transaction.Amount
                                    ,Transaction.BudgetCategoryID
						FROM    	Transaction Transaction
						ORDER BY	Transaction.Description
									,Transaction.TransactionDT DESC
									,Transaction.TransactionID DESC
					) RSTransaction
				) RSRank
			) RS
	WHERE	(RS.Description LIKE CONCAT('%', Keyword, '%') OR Keyword IS NULL)
    AND		RS.RankID = 1
    
	;
END;;
DELIMITER ;