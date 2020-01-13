USE `planner`;

-- Step 1
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


-- Step 2
update snpBudgetAverageMonthly set IncomeActual = 2222 where BudgetAverageMonthlyID = '201904201906';
update snpBudgetAverageMonthly set IncomeAverage = 3333 where BudgetAverageMonthlyID = '201904201907';


CALL BudgetAverageMonthlySnapshotHashUpdate(
	/* ... */ 
);



-- Step 3
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



-- Verify
select * from snpBudgetAverageMonthly;