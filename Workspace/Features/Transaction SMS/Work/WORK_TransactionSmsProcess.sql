USE planner;

-- pull messages from TransactionSms

-- parse by the delimiter into tmpTransactionQueue

-- if can't parse, dump single line

-- category = pending

-- description = body

-- queue id = timecode + sms id

-- transaction number = 1 of 3 by row

-- note = CC - Split - 12.34 Total by top row

-- transaction type = 2 (expense)

-- RUN TransactionQueueInsert


/*
select * from TransactionSms order by 1 desc limit 5;
select * from logTransactionSms order by 1 desc limit 5;
*/