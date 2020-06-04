USE `planner`;

SET @varEffectiveDT = '2020-06-06';

CALL StandupInsert(@varEffectiveDT);

CALL StandupItemInsert(/* StandupID */ 3, /* Subject */ 'subject test 2', /* ActionItem */ 'action test 2');
CALL StandupItemInsert(/* StandupID */ 3, /* Subject */ 'subject test 2', /* ActionItem */ 'action test 2');

CALL StandupGet(@varEffectiveDT);



-- CALL StandupItemDelete(/* StandupItemID */ 14);