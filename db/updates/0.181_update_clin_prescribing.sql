\-- new table to keep recording of each users authority script numbers

create table clin_prescribing.authority_script_number
(fk_staff integer not null,
 fk_clinic integer not null,
 authority_script_number integer not null)
 ;

 Comment on table clin_prescribing.authority_script_number is
 'keeps record of the last used authority number per staff per clinic';

 Alter table  clin_prescribing.authority_script_number owner to easygp;
 grant all on table clin_prescribing.authority_script_number to easygp;
 grant all on table clin_prescribing.authority_script_number to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 181);
