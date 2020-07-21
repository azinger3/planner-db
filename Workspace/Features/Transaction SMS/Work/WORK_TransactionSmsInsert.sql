USE planner;

-- prmSender VARCHAR(1000);
-- prmBody VARCHAR(1000);


SET @prmSender = '15025724735';
SET @prmBody = 'bubble butt bubble butt';

SET @varSender = @prmSender;
SET @varBody = @prmBody;

SELECT @varSender as Sender
				,@varBody as Body
;


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


/*
select * from TransactionSms order by 1 desc limit 5;
select * from logTransactionSms order by 1 desc limit 5;
*/