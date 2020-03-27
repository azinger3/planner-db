select * from BudgetCategory;
select * from BudgetItem where BudgetCategoryID in (99,97,81,82,65,66,67);
select * from TransactionType;

/*
update BudgetCategory
set FundID = null
where BudgetCategoryID = 109;

delete from BudgetCategory
where BudgetCategoryID in (75);
*/
