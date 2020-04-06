select * from BudgetCategory where ActiveFlg = 1 and BudgetCategoryID in (78,79);
select * from BudgetItem where ActiveFlg = 1 and  BudgetCategoryID in (76);
select * from Fund where ActiveFlg = 1;
select * from BudgetCategory where ActiveFlg = 1 and ColorHighlight is null
select * from TransactionType;

/*
update BudgetCategory
set BudgetCategory = 'Pets'
where BudgetCategoryID = 88;

update Fund
set FundName = 'Car Care Fund'
where FundID = 15;

delete from BudgetCategory
where BudgetCategoryID in (76,79);

update BudgetCategory set ColorHighlight = '#c39797' where BudgetCategoryID = 15;
update BudgetCategory set ColorHighlight = '#008080' where BudgetCategoryID = 50;
update BudgetCategory set ColorHighlight = '#5bc0de' where BudgetCategoryID = 25;


update BudgetCategory set ColorHighlight = '#011037' where BudgetCategoryID = 56;
update BudgetCategory set ColorHighlight = '#1b1e23' where BudgetCategoryID = 58;
update BudgetCategory set ColorHighlight = '#ffebdd' where BudgetCategoryID = 59;
update BudgetCategory set ColorHighlight = '#a95252' where BudgetCategoryID = 60;
update BudgetCategory set ColorHighlight = '#187196' where BudgetCategoryID = 61;
update BudgetCategory set ColorHighlight = '#8d277f' where BudgetCategoryID = 63;
update BudgetCategory set ColorHighlight = '#9da099' where BudgetCategoryID = 64;
update BudgetCategory set ColorHighlight = '#830ba6' where BudgetCategoryID = 68;
update BudgetCategory set ColorHighlight = '#ffdac1' where BudgetCategoryID = 69;
update BudgetCategory set ColorHighlight = '#bcc910' where BudgetCategoryID = 70;
update BudgetCategory set ColorHighlight = '#edc596' where BudgetCategoryID = 71;
update BudgetCategory set ColorHighlight = '#cd3700' where BudgetCategoryID = 73;
update BudgetCategory set ColorHighlight = '#d2691e' where BudgetCategoryID = 74;
update BudgetCategory set ColorHighlight = '#177245' where BudgetCategoryID = 77;
update BudgetCategory set ColorHighlight = '#f4c2c2' where BudgetCategoryID = 80;
update BudgetCategory set ColorHighlight = '#00008b' where BudgetCategoryID = 83;
update BudgetCategory set ColorHighlight = '#ddc4c4' where BudgetCategoryID = 84;
update BudgetCategory set ColorHighlight = '#cd7f32' where BudgetCategoryID = 85;
update BudgetCategory set ColorHighlight = '#0c457d' where BudgetCategoryID = 86;
update BudgetCategory set ColorHighlight = '#e8702a' where BudgetCategoryID = 87;
update BudgetCategory set ColorHighlight = '#ffffe2' where BudgetCategoryID = 88;
update BudgetCategory set ColorHighlight = '#ff0087' where BudgetCategoryID = 89;
update BudgetCategory set ColorHighlight = '#b2ebf0' where BudgetCategoryID = 90;
update BudgetCategory set ColorHighlight = '#ff5a94' where BudgetCategoryID = 91;
update BudgetCategory set ColorHighlight = '#600707' where BudgetCategoryID = 92;
update BudgetCategory set ColorHighlight = '#3e03ff' where BudgetCategoryID = 93;
update BudgetCategory set ColorHighlight = '#ffe766' where BudgetCategoryID = 94;
update BudgetCategory set ColorHighlight = '#2a4d69' where BudgetCategoryID = 95;
update BudgetCategory set ColorHighlight = '#cfbda3' where BudgetCategoryID = 96;
update BudgetCategory set ColorHighlight = '#92795b' where BudgetCategoryID = 98;
update BudgetCategory set ColorHighlight = '#febead' where BudgetCategoryID = 100;
update BudgetCategory set ColorHighlight = '#fab7cc' where BudgetCategoryID = 101;
update BudgetCategory set ColorHighlight = '#e9473f' where BudgetCategoryID = 102;
update BudgetCategory set ColorHighlight = '#d44d4d' where BudgetCategoryID = 103;
update BudgetCategory set ColorHighlight = '#cfbda3' where BudgetCategoryID = 108;
update BudgetCategory set ColorHighlight = '#2a2d31' where BudgetCategoryID = 105;
update BudgetCategory set ColorHighlight = '#4DD4D4' where BudgetCategoryID = 106;
update BudgetCategory set ColorHighlight = '#D4D44D' where BudgetCategoryID = 107;
*/
