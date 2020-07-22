select * from TransactionSms order by 1 desc limit 50;
select * from TransactionQueue order by 1 desc limit 50;

select * from logTransactionSms order by 1 desc limit 50;
select * from logTransactionQueue order by 1 desc limit 50;


CALL TransactionSmsProcess();