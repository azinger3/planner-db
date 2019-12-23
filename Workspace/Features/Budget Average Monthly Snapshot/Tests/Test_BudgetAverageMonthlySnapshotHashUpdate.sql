USE `planner`;

truncate table snpBudgetAverageMonthly;


CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-05-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-06-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-07-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-08-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-09-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-10-01' 
);


update snpBudgetAverageMonthly set IncomeActual = 1234 where BudgetAverageMonthlyID = '201904201906';
update snpBudgetAverageMonthly set IncomeAverage = 5678 where BudgetAverageMonthlyID = '201904201907';


CALL BudgetAverageMonthlySnapshotHashUpdate(
	/* ... */ 
);



CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-05-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-06-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-07-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-08-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-09-01' 
);

CALL BudgetAverageMonthlySnapshotGenerate(
	/* prmStartDT */ 	'2019-04-01'
	,/* prmEndDT */ 	'2019-10-01' 
);


select * from snpBudgetAverageMonthly;