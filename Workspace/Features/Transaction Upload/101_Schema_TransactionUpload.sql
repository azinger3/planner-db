USE planner;



DROP TABLE IF EXISTS TransactionChaseBankAccount;

CREATE TABLE TransactionChaseBankAccount
(
	TransactionChaseBankAccountID	INT(10) NOT NULL AUTO_INCREMENT
    ,ChaseDetails									DATETIME
    ,ChasePostingDT 							VARCHAR(100)
	,ChaseDescription 							VARCHAR(1000)
    ,ChaseAmount 								VARCHAR(100)
    ,ChaseType  									VARCHAR(100)
    ,ChaseBalance 								VARCHAR(100)
    ,ChaseCheckSlipNumber				VARCHAR(100)
    ,CreateDT 										DATETIME DEFAULT NOW()
    ,CreateBy 										VARCHAR(100) DEFAULT 'User'
    ,ModifyDT 										DATETIME DEFAULT NOW()
    ,ModifyBy 										VARCHAR(100) DEFAULT 'User'
    ,ActiveFlg 										INT(10) DEFAULT 1
	,PRIMARY KEY (`TransactionChaseBankAccountID`)
);

select * from TransactionChaseBankAccount;




DROP TABLE IF EXISTS TransactionChaseCreditCard;

CREATE TABLE TransactionChaseCreditCard
(
	TransactionChaseCreditCardID		INT(10) NOT NULL AUTO_INCREMENT
    ,ChaseTransactionDT						VARCHAR(100)
    ,ChasePostDT 								VARCHAR(100)
	,ChaseDescription 							VARCHAR(1000)
    ,ChaseCategory 								VARCHAR(100)
    ,ChaseType  									VARCHAR(100)
    ,ChaseAmount								VARCHAR(100)
    ,CreateDT 										DATETIME DEFAULT NOW()
    ,CreateBy 										VARCHAR(100) DEFAULT 'User'
    ,ModifyDT 										DATETIME DEFAULT NOW()
    ,ModifyBy 										VARCHAR(100) DEFAULT 'User'
    ,ActiveFlg 										INT(10) DEFAULT 1
	,PRIMARY KEY (`TransactionChaseCreditCardID`)
);

select * from TransactionChaseCreditCard;




DROP TABLE IF EXISTS TransactionStage;

CREATE TABLE TransactionStage
(
	TransactionStageID            				INT(10) NOT NULL AUTO_INCREMENT
    ,TransactionChaseBankAccountID		INT(10)		
    ,TransactionChaseCreditCardID			INT(10)			
	,TransactionTypeID 							INT(10)
	,TransactionDT 									DATETIME
	,BudgetCategoryID 							INT(10)
	,Amount 												DECIMAL(10,4)
	,Description 										VARCHAR(1000)
	,Note 													VARCHAR(1000)
    ,IsProcessedFlg									INT(1) DEFAULT 0
    ,CreateDT 											DATETIME DEFAULT NOW()
    ,CreateBy 											VARCHAR(100) DEFAULT 'User'
    ,ModifyDT 											DATETIME DEFAULT NOW()
    ,ModifyBy 											VARCHAR(100) DEFAULT 'User'
    ,ActiveFlg 											INT(10) DEFAULT 1
	,PRIMARY KEY (`TransactionStageID`)
);

select * from TransactionStage;




