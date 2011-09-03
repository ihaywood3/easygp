INSERT INTO "admin".lu_clinical_modules(name, icon_path) values('Medical Certificates','icons/24/centigrade_person_list2424.png');
update admin.lu_clinical_modules set icon_path='icons/20/careplan2020_1.png' where pk=17;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 118);
