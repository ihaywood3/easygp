Insert into common.lu_units(abbrev_text) values ('mg/g');
Insert into common.lu_units(abbrev_text) values ('mcg/g');
Insert into common.lu_units(abbrev_text) values ('mg/ml');
Insert into common.lu_units(abbrev_text) values ('mcg/ml');
Insert into common.lu_units(abbrev_text) values ('units');

update common.lu_units set abbrev_text = 'mcg' where pk=54;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 153);


