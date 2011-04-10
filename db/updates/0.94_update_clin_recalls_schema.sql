-- Updates to clin_recalls so I can put it into production use
-- This table is left over detritis from a long long time ago....

drop table clin_recalls.forms;

-- empty the lu_reasons table - users can start from scratch
delete from clin_recalls.lu_reasons;
delete from clin_recalls.lu_recall_intervals;
delete from clin_recalls.recalls;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 94);

