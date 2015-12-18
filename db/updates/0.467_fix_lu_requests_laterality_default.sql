alter table clin_requests.lu_requests alter column fk_laterality set default null;

update db.lu_version set lu_minor = 467;