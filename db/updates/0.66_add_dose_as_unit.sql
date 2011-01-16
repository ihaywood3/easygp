insert into common.lu_units (pk, abbrev_text, full_text) values (56, 'dose', 'dose');

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 66);
