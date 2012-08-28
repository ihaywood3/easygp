-- forgot poor old dad!
insert into common.lu_family_relationships (relationship) values ('father');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 222);

