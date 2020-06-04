USE `planner`;

SET @varEffectiveDT = '2020-06-05';


-- start the day
-- CALL StandupInsert(@varEffectiveDT);


-- update an item
-- CALL StandupItemUpdate(/* StandupItemID */ 6, /* Subject */ 'OneSource - PO Profile', /* ActionItem */ 'backend development', /* PriorityID */ 1);


-- add todays items
-- CALL StandupItemInsert(/* StandupID */ 3, /* Subject */ 'subject test 2', /* ActionItem */ 'action test 2');


-- remove an item
-- CALL StandupItemDelete(/* StandupItemID */ 14);


-- verify
CALL StandupGet(@varEffectiveDT);