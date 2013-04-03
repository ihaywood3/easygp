-- oops.... forgot some basic relationships in the original design
insert into common.lu_family_relationships(relationship) values ('sister');
insert into common.lu_family_relationships(relationship) values ('brother');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 254);

