USE `planner`;


CALL CalendarGenerate();


select * from Calendar where EffectiveDT between '2019-12-20' and '2020-01-20' order by CalendarID;

-- select * from Calendar where WeekNumber = 0;

-- select *, concat((YearNumber - 1), '52') AS newWeekID from Calendar where WeekID = concat(YearNumber, '00');
	