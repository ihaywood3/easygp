alter table clerical.data_patients alter column pk_legacy type text ;
alter table clerical.data_patients alter column pk_legacy set default null;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 194)

