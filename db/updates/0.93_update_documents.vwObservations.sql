-- attended to problem where numeric values exist, but where not being kept because of format >^90 not taken into account eg Egfr
-- field value_numeric_qualifier included in the view.

DROP VIEW documents.vwobservations cascade ;
-- drop cascades to view research.diabetes_patients_latest_hba1c


CREATE OR REPLACE VIEW documents.vwobservations AS 
 SELECT documents.fk_patient, observations.pk, observations.identifier, observations.observation_date, 
 observations.value_numeric,
observations.value_numeric_qualifier,
observations.units, observations.reference_range, observations.abnormal, observations.loinc
 
   FROM documents.observations, documents.documents
  WHERE documents.pk = observations.fk_document
  ORDER BY documents.fk_patient, observations.observation_date, observations.set_id;

ALTER TABLE documents.vwobservations OWNER TO easygp;
GRANT ALL ON TABLE documents.vwobservations TO easygp;
GRANT ALL ON TABLE documents.vwobservations TO staff;



CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c AS 
 SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age_numeric, ( SELECT vwobservations.observation_date
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS observation_date, ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS hba1c
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
  ORDER BY ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1);

ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 93);

