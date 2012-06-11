CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations, vwgraphableobservations.observation_date,
 vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwpatients.fk_patient, 
 vwpatients.firstname, vwpatients.wholename, vwpatients.age_display, vwpatients.sex, vwpatients.title,
  vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.occupation, 
  vwpatients.postcode, vwpatients.surname, vwpatients.fk_image, vwpatients.birthdate, vwpatients.age_numeric, 
  vwpatients.marital, vwpatients.fk_person, vwpatients.deceased, vwpatients.active_status
   FROM contacts.vwpatients, documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;

COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c IS 
'all patients and all their hba1''s, including deceased and those left the practice';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 168);

