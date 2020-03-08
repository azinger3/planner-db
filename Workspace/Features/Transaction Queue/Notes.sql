-- 103


select * from TransactionQueue;
select * from logTransactionQueue;
select * from BudgetCategory where BudgetCategoryID = 103;
select * from TransactionType;
select * from Budget;

set @testme = 0;
-- set @testme = (select 1 FROM TransactionQueue WHERE KeyID = '123hufh838xx');
select @testme;

CALL TransactionQueueInsert(
    '123hufh838xx'
    ,2
    ,null		    
    ,'2020-03-07'		
    ,202003
    ,103
    ,65.10		
    ,'COSTCO #6532'	
    ,'CC'	
    ,'Bot'
);

/*

TransactionQueueInsert -- called in mass EXEC statement - scheduled every 1 minute - 9:00 PM
TransactionQueueProcess -- move from transaction queue to core, then log - scheduled 1 minute - 9:01PM

*/