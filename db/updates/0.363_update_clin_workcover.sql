Create or replace view clin_workcover.vwPatientsWithWorkcover as
SELECT 
  vwpatients.fk_patient, 
  vwpatients.pk_view, 
  vwpatients.fk_person, 
  vwpatients.firstname, 
  vwPatients.surname,
  vwpatients.birthdate, 
  vwpatients.age_display, 
  vwpatients.age_numeric, 
  vwpatients.street2, 
  vwpatients.street1, 
  vwpatients.title, 
  vwpatients.town, 
  vwpatients.state
FROM 
  contacts.vwpatients, 
  clin_workcover.vwworkcover
WHERE 
  vwpatients.fk_patient = vwworkcover.fk_patient;

ALTER TABLE clin_workcover.vwworkcover   OWNER TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;

update db.lu_version set lu_minor=363;