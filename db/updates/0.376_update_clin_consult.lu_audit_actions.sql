SELECT setval('clin_consult.lu_actions_pk_seq', (SELECT MAX(pk) FROM clin_consult.lu_audit_actions));
insert into clin_consult.lu_audit_actions (action) values ('warning to user');

update db.lu_version set lu_minor=376;
