-- need to allow staff to access occupations so they can add patients/persons to contacts.
GRANT ALL ON TABLE common.lu_occupations TO staff;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 134);
