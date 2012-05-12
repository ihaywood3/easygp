delete from admin.lu_staff_type;

ALTER SEQUENCE admin.lu_staff_type_pk_seq 
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 1
    CACHE 1  NO CYCLE;

insert into admin.lu_staff_type(type) values ('adminstrative');
insert into admin.lu_staff_type(type) values ('allied health');
insert into admin.lu_staff_type(type) values ('dental');
insert into admin.lu_staff_type(type) values ('information technology');
insert into admin.lu_staff_type(type) values ('maintenance/cleaning');
insert into admin.lu_staff_type(type) values ('nursing enrolled');
insert into admin.lu_staff_type(type) values ('nursing general');
insert into admin.lu_staff_type(type) values ('nursing mental health');
insert into admin.lu_staff_type(type) values ('general practitioners');
insert into admin.lu_staff_type(type) values ('medical specialist');
insert into admin.lu_staff_type(type) values ('surgical specialist');
insert into admin.lu_staff_type(type) values ('secretarial');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 158);


