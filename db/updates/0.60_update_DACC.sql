
DROP TABLE chronic_disease_management.diabetes_annual_cycle_of_care cascade;

CREATE TABLE chronic_disease_management.diabetes_annual_cycle_of_care
(
  pk serial primary key,
  fk_consult integer NOT NULL,
  date_completed date default null,
  hba1c_date date, -- date of last hba1c could be null if not yet completed but DACC saved...
  hba1c_date_due date,
  hba1c_details text,
  eyes_date date, -- Date the eye check was done, may be entered without paperwork to verify
  eyes_date_due date,
  eyes_details text, -- Whoever checked the eyes, could be person or entity, but hopefully in most cases...
  bp_date date,
  bp_date_due date,
  bp_details text,
  bmi_date date,
  bmi_date_due date,
  bmi_details text,
  feet_date date,
  feet_date_due date,
  feet_details text,
  lipids_date date,
  lipids_date_due date,
  lipids_details text,
  microalbumin_date date,
  microalbumin_date_due date,
  microalbumin_details text,
  education_date date,
  education_date_due date,
  education_details text,
  diet_date date,
  diet_date_due date,
  diet_details text,
  exercise_date date,
  exercise_date_due date,
  exercise_details text,
  smoking_date date,
  smoking_date_due date,
  smoking_details text,
  medication_review_date date,
  medication_review_date_due date,
  medication_review_details text,
  deleted boolean default false
);



ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care TO staff;

COMMENT ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care IS 
'Table containing the components to the diabetes annual cycle of care first version not for clinical use';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.hba1c_date IS 'date of last hba1c could be null if not yet completed but DACC saved
	 also could be taken from  document not from our system, or a phone result etc';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.eyes_date IS 'Date the eye check was done, may be entered without paperwork to verify ';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.eyes_details IS 'Whoever checked the eyes, could be person or entity, but hopefully in most cases
 will be auto-trawled from the database ';

Create or replace view chronic_disease_management.vwDiabetesCycleOfCare as

SELECT 
  consult.fk_patient, 
  consult.fk_staff, 
  diabetes_annual_cycle_of_care.*
FROM 
  clin_consult.consult, 
  chronic_disease_management.diabetes_annual_cycle_of_care
WHERE 
  diabetes_annual_cycle_of_care.fk_consult = consult.pk
order by fk_patient, fk_consult
;




ALTER TABLE chronic_disease_management.vwDiabetesCycleOfCare OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwDiabetesCycleOfCare TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwDiabetesCycleOfCare TO staff;