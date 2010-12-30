CREATE INDEX "loinc_idx" ON "documents"."observations"
  USING btree ("loinc", "observation_date");
 CREATE INDEX value_numeric_idx
  ON documents.observations
  USING btree
  (value_numeric);
 -- a view of all hba1c results in the database 
 
CREATE OR REPLACE VIEW research.diabetes_all_hba1c_results AS 
 SELECT DISTINCT vwobservations.fk_patient, vwobservations.observation_date, vwobservations.value_numeric
   FROM documents.vwobservations
  WHERE vwobservations.loinc = '4548-4'::text
  ORDER BY vwobservations.fk_patient, vwobservations.observation_date;

ALTER TABLE research.diabetes_all_hba1c_results OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_all_hba1c_result to staff;

-- view of patients and their latest hba1c results in ASC ordering or hba1c

CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c as 
 SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age, 

  ( SELECT vwobservations.observation_date
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS observation_date,
 ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS hba1c
   
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
  ORDER BY hba1c;

ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;
Grant all on table research.diabetes_patients_latest_hba1c to staff;

