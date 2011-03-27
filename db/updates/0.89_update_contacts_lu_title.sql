-- fixes a spelling mistake

update contacts.lu_title set title= 'Unknown' where pk =7;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 89);

