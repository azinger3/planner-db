-- 103


select * from TransactionQueue;
select * from logTransactionQueue;
select * from BudgetCategory where BudgetCategoryID = 103;
select * from TransactionType;
select * from Budget;

set @varIsExisting = 0;
-- SET @varIsExisting = (IFNULL((SELECT '1' FROM TransactionQueue WHERE KeyID = 'existing' LIMIT 1), 0));
-- SET @varIsExisting = (IFNULL((SELECT '1' FROM logTransactionQueue WHERE KeyID = 'existing' LIMIT 1), 0));
select @varIsExisting as testthis;


CALL TransactionQueueInsert(
    'new6'
    ,2
    ,''		    
    ,'2020-03-07'		
    ,202003
    ,103
    ,65.10		
    ,'COSTCO #6532'	
    ,'CC'	
);

CALL TransactionQueueInsert(
    'existing'
    ,2
    ,''		    
    ,'2020-03-07'		
    ,202003
    ,103
    ,65.10		
    ,'COSTCO test'	
    ,'CC'	
);

CALL TransactionQueueProcess();

update Transaction
inner join (
    select TransactionID, replace(Description, '''', '') as cleanOne from Transaction where Description like '%''%' order by 1 desc limit 50
) rs
on  Transaction.TransactionID = rs.TransactionID
set Description = rs.cleanOne


select * from TransactionQueue;
select * from logTransactionQueue;


/*

TransactionQueueInsert -- called in mass EXEC statement - scheduled every 1 minute - 9:00 PM
TransactionQueueProcess -- move from transaction queue to core, then log - scheduled 1 minute - 9:01PM

truncate table TransactionQueue;
truncate table logTransactionQueue;

*/