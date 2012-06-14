Create table chronic_disease_management.Diabetes_Hba1c_Not_Diabetic 
(fk_patient integer not null
);

Comment on table chronic_disease_management.Diabetes_Hba1c_Not_Diabetic is
'table containing keys to clerical.fk_patient where someone has ordered 
 a hba1c on somone who is not diabetic in fact.';
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 170);

