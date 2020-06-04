USE `planner`;

SET @varEffectiveDT = '2020-06-05';


-- verify
CALL StandupGet();
-- CALL StandupDetailGet(@varEffectiveDT);


-- start the day
-- CALL StandupInsert(@varEffectiveDT);


-- add todays items
-- CALL StandupItemInsert(/* StandupID */ 2, /* Subject */ 'OneSource - PO Profile', /* ActionItem */ 'backend development');


-- remove an item
-- CALL StandupItemDelete(/* StandupItemID */ 14);


-- update an item
-- CALL StandupItemUpdate(/* StandupItemID */ 6, /* Subject */ 'OneSource - PO Profile', /* ActionItem */ 'backend development', /* PriorityID */ 1);


