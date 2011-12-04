-- Adds a derived fee field for the schedule table in clerical

alter table clerical.schedule add column derived_fee text;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 144);

