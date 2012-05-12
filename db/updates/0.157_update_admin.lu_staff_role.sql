update  admin.lu_staff_roles set role = 'doctor' where pk=1;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 157);
