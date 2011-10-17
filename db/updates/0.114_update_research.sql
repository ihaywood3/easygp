Create or replace view Research.vwMentalHealthPlans as 
SELECT 
  vwpatients.wholename as patient_wholename, 
  vwpatients.firstname as patient_firstname, 
  vwpatients.surname as patient_surname, 
  vwpatients.title as patient_title,
  vwmentalhealthplans.*
  
FROM 
  clin_mentalhealth.vwmentalhealthplans, 
  contacts.vwpatients
WHERE 
  vwmentalhealthplans.fk_patient = vwpatients.fk_patient;
ALTER TABLE clin_mentalhealth.vwmentalhealthplans OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwmentalhealthplans TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwmentalhealthplans TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 114);

