-- Drop in replacement for current CDM schema

Drop schema chronic_disease_management cascade;

CREATE SCHEMA chronic_disease_management  AUTHORIZATION easygp;
GRANT ALL ON SCHEMA chronic_disease_management TO easygp;
GRANT ALL ON SCHEMA chronic_disease_management TO staff;

CREATE TABLE chronic_disease_management.diabetes_annual_cycle_of_care
(
  pk serial NOT NULL,
  fk_consult integer NOT NULL,
  date_completed date,
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
  deleted boolean DEFAULT false,
  fk_progressnote_components integer, -- html of the tabulated DACC if not null
  CONSTRAINT diabetes_annual_cycle_of_care_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care TO staff;

COMMENT ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care IS 'Table containing the components to the diabetes annual cycle of care first version not for clinical use';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.hba1c_date IS 'date of last hba1c could be null if not yet completed but DACC saved
	 also could be taken from  document not from our system, or a phone result etc';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.eyes_date IS 'Date the eye check was done, may be entered without paperwork to verify ';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.eyes_details IS 'Whoever checked the eyes, could be person or entity, but hopefully in most cases
 will be auto-trawled from the database ';
COMMENT ON COLUMN chronic_disease_management.diabetes_annual_cycle_of_care.fk_progressnote_components IS 'html of the tabulated DACC if not null';

CREATE TABLE chronic_disease_management.lu_dacc_components
(
  pk serial NOT NULL,
  fk_component integer NOT NULL, -- key to chronic_disease_management.lu_careplan_components table
  CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE chronic_disease_management.lu_dacc_components OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.lu_dacc_components TO easygp;
GRANT ALL ON TABLE chronic_disease_management.lu_dacc_components TO staff;

COMMENT ON TABLE chronic_disease_management.lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC)';
COMMENT ON COLUMN chronic_disease_management.lu_dacc_components.fk_component IS 'key to chronic_disease_management.lu_careplan_components table';



CREATE TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes
(
  pk serial NOT NULL,
  fk_progressnote integer NOT NULL,
  fk_diabetes_annual_cycle_of_care integer,
  CONSTRAINT diabetes_annual_cycle_of_care_notes_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes TO easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes TO staff;
COMMENT ON TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes IS 'as a cycle_of_care may not be completed during the same physical consultation, but over
 several visits, this keeps the key to each progress note, so that they can be
 re-displayed to the user to see what they did last time';



CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetescycleofcare AS 
 SELECT 
        CASE
            WHEN diabetes_annual_cycle_of_care_notes.pk IS NULL THEN diabetes_annual_cycle_of_care.pk || '0'::text
            ELSE diabetes_annual_cycle_of_care.pk || COALESCE(diabetes_annual_cycle_of_care_notes.pk)::text
        END AS pk_view, diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care, consult.consult_date, consult.fk_patient, consult.fk_staff AS fk_staff_started, diabetes_annual_cycle_of_care.date_completed, diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.hba1c_date, diabetes_annual_cycle_of_care.hba1c_date_due, diabetes_annual_cycle_of_care.hba1c_details, diabetes_annual_cycle_of_care.eyes_date, diabetes_annual_cycle_of_care.eyes_date_due, diabetes_annual_cycle_of_care.eyes_details, diabetes_annual_cycle_of_care.bp_date, diabetes_annual_cycle_of_care.bp_date_due, diabetes_annual_cycle_of_care.bp_details, diabetes_annual_cycle_of_care.bmi_date, diabetes_annual_cycle_of_care.bmi_date_due, diabetes_annual_cycle_of_care.bmi_details, diabetes_annual_cycle_of_care.feet_date, diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details, diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, diabetes_annual_cycle_of_care.lipids_details, diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due, diabetes_annual_cycle_of_care.microalbumin_details, diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted, diabetes_annual_cycle_of_care.fk_progressnote_components, diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments, vwprogressnotes.consult_date AS date_progress_note_comment, vwstaff.title AS staff_made_comment_title, vwstaff.wholename AS staff_made_comment_wholename, vwstaff1.title AS staff_started_title, vwstaff1.wholename AS staff_started_wholename, progressnotes.notes AS component_notes, vwprogressnotes.notes AS comments_notes
   FROM chronic_disease_management.diabetes_annual_cycle_of_care
   JOIN clin_consult.consult ON diabetes_annual_cycle_of_care.fk_consult = consult.pk
   LEFT JOIN chronic_disease_management.diabetes_annual_cycle_of_care_notes ON diabetes_annual_cycle_of_care.pk = diabetes_annual_cycle_of_care_notes.fk_diabetes_annual_cycle_of_care
   LEFT JOIN clin_consult.vwprogressnotes ON diabetes_annual_cycle_of_care_notes.fk_progressnote = vwprogressnotes.pk_progressnote
   LEFT JOIN admin.vwstaff ON vwprogressnotes.fk_staff = vwstaff.fk_staff
   JOIN clin_consult.progressnotes ON diabetes_annual_cycle_of_care.fk_progressnote_components = progressnotes.pk
   JOIN admin.vwstaff vwstaff1 ON consult.fk_staff = vwstaff1.pk
  ORDER BY consult.fk_patient, diabetes_annual_cycle_of_care.pk, diabetes_annual_cycle_of_care_notes.pk;

ALTER TABLE chronic_disease_management.vwdiabetescycleofcare OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetescycleofcare TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetescycleofcare TO staff;

 

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 70);
