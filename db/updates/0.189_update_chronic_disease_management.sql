Alter table chronic_disease_management.diabetes_patients_excluded_from_cdm rename to 
Patients_With_Hba1c_Not_diabetic;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 189);

