select * from BudgetCategory where ActiveFlg = 1 and BudgetCategoryID in (78,79);
select * from BudgetItem where ActiveFlg = 1 and  BudgetCategoryID in (76);
select * from Fund where ActiveFlg = 1;
-- select * from TransactionType;

/*
update BudgetCategory
set BudgetCategory = 'Pets'
where BudgetCategoryID = 88;

update Fund
set FundName = 'Car Care Fund'
where FundID = 15;

delete from BudgetCategory
where BudgetCategoryID in (76,79);
*/
