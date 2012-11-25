create table drugs.pbsconvert as table pbsconvert;
drop table pbsconvert;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 247);

