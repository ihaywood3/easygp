Alter table admin.lu_clinical_modules add column in_use boolean default true;
update admin.lu_clinical_modules set in_use  = True;
update admin.lu_clinical_modules set in_use = False where pk=14 or pk=20;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 282);

