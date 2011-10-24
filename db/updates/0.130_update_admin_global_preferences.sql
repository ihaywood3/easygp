-- unless Ian changes this - the table now used to store admin's and staff's preferences

GRANT ALL ON TABLE "admin".global_preferences TO staff;
GRANT ALL ON TABLE "admin".global_preferences_pk_seq to staff;
alter table  admin.global_preferences drop constraint global_preferences_fk_clinic_key ;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 130);

