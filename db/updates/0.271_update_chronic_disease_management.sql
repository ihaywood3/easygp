 GRANT USAGE ON  SCHEMA chronic_disease_management to staff;
GRANT ALL ON TABLE chronic_disease_management.patients_with_hba1c_not_diabetic TO STAFF;

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 271);

