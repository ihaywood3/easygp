alter table clerical.data_patients alter column active_status set default 'a';
update clerical.data_patients set active_status = 'a' WHERE active_status is null;

comment on column clerical.data_patients.active_status is
'a=active i=inactive v=????-fixme';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 167);

