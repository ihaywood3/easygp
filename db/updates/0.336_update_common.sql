Create table common.lu_blood_group
(pk serial primary key,
abo_group char (2) not null
);

insert into common.lu_blood_group(abo_group) values ('A');
insert into common.lu_blood_group (abo_group) values ('B');
insert into common.lu_blood_group (abo_group) values ('AB');
insert into common.lu_blood_group (abo_group) values ('O');

create table common.lu_rhesus_group
 (pk serial primary key,
  rhesus_group text not null);

 insert into common.lu_rhesus_group (rhesus_group) values ('positive');
 insert into common.lu_rhesus_group (rhesus_group) values ('negative');
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 336);
