insert into clin_consult.lu_audit_actions (action) values ('delete - duplicate document');
insert into clin_consult.lu_audit_actions (action) values ('delete - preliminary result');
insert into clin_consult.lu_audit_actions (action) values ('undelete');
insert into clin_consult.lu_audit_actions (action) values ('document display mode changed');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 63);

