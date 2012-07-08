-- needs correct name for widget to work
update admin.lu_clinical_modules set name='Allergies' where pk=13;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 182);

