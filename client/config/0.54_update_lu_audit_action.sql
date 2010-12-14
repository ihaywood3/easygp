update clin_consult.lu_audit_actions set action = 'viewed and filed document' where pk = 21
insert into clin_consult.lu_audit_actions  (action) values ('note on task');
 insert into clin_consult.lu_audit_actions (action) values ('task component finalised');
 
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 54)