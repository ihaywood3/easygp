-- oops forgot the permissions...

alter table common.lu_blood_group owner to easygp;
grant select on common.lu_blood_group to staff;

alter table  common.lu_rhesus_group  owner to easygp;
grant select on  common.lu_rhesus_group to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 339);

