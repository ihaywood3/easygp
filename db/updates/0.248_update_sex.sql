-- correct spelling error

update contacts.lu_sex set sex_text = 'unknown' where pk = 2;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 248);

