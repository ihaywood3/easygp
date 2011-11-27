GRANT ALL ON TABLE contacts.lu_categories_pk_seq TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 142);

