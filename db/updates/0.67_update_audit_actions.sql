INSERT INTO clin_consult.lu_audit_actions(action)   VALUES ('delete - sent in error');

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 67);
