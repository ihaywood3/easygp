-- fixed icon path for the pregancy icon

update admin.lu_clinical_modules set icon_path = 'icons/20/pregnancy2020.png' where pk=12;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 244);


