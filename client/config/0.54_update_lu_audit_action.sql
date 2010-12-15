update clin_consult.lu_audit_actions set action = 'viewed and filed document' where pk = 21
insert into clin_consult.lu_audit_actions  (action) values ('note on task');
insert into clin_consult.lu_audit_actions (action) values ('task component finalised');
Insert into clin_consult.lu_audit_actions (action) values ('scanned document imported');
 
Update clin_consult.lu_audit_actions set action='insert' where pk = 1;
Update clin_consult.lu_audit_actions set action='edit' where pk = 2;
Update clin_consult.lu_audit_actions set action='delete' where pk = 3;
insert into clin_consult.lu_audit_actions(action) values ('re-scheduled');
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 54)