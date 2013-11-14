-- client can now delete mental health plans so needed to mark deleted k10's

alter table clin_mentalhealth.k10_results add column deleted boolean default false;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 335);