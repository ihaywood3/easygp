--added renal function as a DACC parameter

alter table chronic_disease_management.diabetes_annual_cycle_of_care add column renalfunction_date date;
alter table chronic_disease_management.diabetes_annual_cycle_of_care add column renalfunction_date_due date;
alter table chronic_disease_management.diabetes_annual_cycle_of_care add column renalfunction_details text;


DROP VIEW chronic_disease_management.vwdiabetescycleofcare;

CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetescycleofcare AS 
 SELECT (diabetes_annual_cycle_of_care.pk || '-'::text) || COALESCE(diabetes_annual_cycle_of_care_notes.pk, 0)::text AS pk_view, 
 diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care, consult.consult_date, consult.fk_patient, 
 consult.fk_staff AS fk_staff_started, diabetes_annual_cycle_of_care.date_completed, 
 diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.hba1c_date, 
 diabetes_annual_cycle_of_care.hba1c_date_due, diabetes_annual_cycle_of_care.hba1c_details, 
 diabetes_annual_cycle_of_care.eyes_date, diabetes_annual_cycle_of_care.eyes_date_due, 
 diabetes_annual_cycle_of_care.eyes_details, diabetes_annual_cycle_of_care.bp_date,
  diabetes_annual_cycle_of_care.bp_date_due, diabetes_annual_cycle_of_care.bp_details, 
  diabetes_annual_cycle_of_care.bmi_date, diabetes_annual_cycle_of_care.bmi_date_due, 
  diabetes_annual_cycle_of_care.bmi_details, diabetes_annual_cycle_of_care.feet_date, 
  diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details,
   diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, 
   diabetes_annual_cycle_of_care.lipids_details, 
   diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due,
    diabetes_annual_cycle_of_care.microalbumin_details, 
   diabetes_annual_cycle_of_care.renalfunction_date, diabetes_annual_cycle_of_care.renalfunction_date_due,
    diabetes_annual_cycle_of_care.renalfunction_details, 
    diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted, diabetes_annual_cycle_of_care.fk_progressnote_components, diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments, vwprogressnotes.consult_date AS date_progress_note_comment, vwstaff.title AS staff_made_comment_title, vwstaff.wholename AS staff_made_comment_wholename, vwstaff1.title AS staff_started_title, vwstaff1.wholename AS staff_started_wholename, progressnotes.notes AS component_notes, vwprogressnotes.notes AS comments_notes
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
insert into db.lu_version (lu_major,lu_minor) values (0, 81);
