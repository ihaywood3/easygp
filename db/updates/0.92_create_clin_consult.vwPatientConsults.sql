-- Creates a view of patients who have had a consult logged for a given date
-- This includes **ALL** times the progress notes were accessed by all staff
-- including document importatation/audit trails
-- EasyGP then implements particular dates or subviews of this data.

Create or replace view clin_consult.vwPatientConsults as
SELECT DISTINCT
  vwprogressnotes.consult_date as pk_view,
  vwprogressnotes.fk_patient, 
  vwprogressnotes.consult_date,
  vwProgressNotes.consult_type,
  vwprogressnotes.fk_staff, 
  vwprogressnotes.title as staff_title, 
  vwprogressnotes.surname as staff_surname, 
  vwprogressnotes.firstname as staff_firstname, 
  vwprogressnotes.linked_table,
  vwprogressnotes.fk_type,
  vwpatients.wholename, 
  vwpatients.firstname, 
  vwpatients.surname, 
  vwpatients.street1, 
  vwpatients.street2, 
  vwpatients.town, 
  vwpatients.state, 
  vwpatients.postcode, 
  vwpatients.deceased, 
  vwpatients.sex, 
  vwpatients.title, 
  vwpatients.birthdate, 
  vwpatients.age_numeric, 
  vwpatients.age_display
FROM 
  clin_consult.vwprogressnotes, 
  contacts.vwpatients
WHERE 
  vwprogressnotes.fk_patient = vwpatients.fk_patient

 ORDER BY consult_date;

ALTER TABLE clin_consult.vwPatientConsults OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwPatientConsults TO easygp;
GRANT ALL ON TABLE clin_consult.vwPatientConsults TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 92);
