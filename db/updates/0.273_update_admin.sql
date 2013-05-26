update  admin.lu_clinical_modules set icon_path = 'icons/16/family_1616.png' where pk=10;
update  admin.lu_clinical_modules set icon_path= 'icons/20/pregnancy2020.png' where pk=12;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 273);

