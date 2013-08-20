
update common.lu_occupations set occupation = 'spectrum manager' where occupation='spectum manager';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 312);


