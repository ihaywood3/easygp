--oops!!!!

GRANT ALL ON TABLE "admin".clinical_modules TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 75)
