USE planner;



CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-05-01' 
);

CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-06-01' 
);

CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-07-01' 
);

CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-08-01' 
);

CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-09-01' 
);

CALL BudgetAverageMonthlySnapshot(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-10-01' 
);



select * from snpBudgetAverageMonthly;