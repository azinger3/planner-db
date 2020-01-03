call TransactionSpotlightGet('2020-01-03');

select * from Calendar where YearNumber = 2018;


select * from Calendar where WeekNumber = 0;
select concat(YearNumber, '00') from Calendar limit 100;
select *, concat((YearNumber - 1), '52') AS newWeekID from Calendar where WeekID = concat(YearNumber, '00');




/*
update Calendar
set WeekNumber = 52
where WeekNumber = 0
*/