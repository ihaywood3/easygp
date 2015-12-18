drop table chronic_disease_management.diabetes_annual_cycle_of_care_notes CASCADE;

ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care rename column fk_progressnote_components to fk_progressnote;

ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care 
	ADD CONSTRAINT cycle_of_care_fk_progressnote_fkey foreign key (fk_progressnote) references clin_consult.progressnotes (pk);

CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetescycleofcare AS 
 SELECT
    diabetes_annual_cycle_of_care.pk, 
    diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff AS fk_staff_started,
    diabetes_annual_cycle_of_care.date_completed,
    diabetes_annual_cycle_of_care.fk_consult,
    diabetes_annual_cycle_of_care.hba1c_date,
    diabetes_annual_cycle_of_care.hba1c_date_due,
    diabetes_annual_cycle_of_care.hba1c_details,
    diabetes_annual_cycle_of_care.eyes_date,
    diabetes_annual_cycle_of_care.eyes_date_due,
    diabetes_annual_cycle_of_care.eyes_details,
    diabetes_annual_cycle_of_care.bp_date,
    diabetes_annual_cycle_of_care.bp_date_due,
    diabetes_annual_cycle_of_care.bp_details,
    diabetes_annual_cycle_of_care.bmi_date,
    diabetes_annual_cycle_of_care.bmi_date_due,
    diabetes_annual_cycle_of_care.bmi_details,
    diabetes_annual_cycle_of_care.feet_date,
    diabetes_annual_cycle_of_care.feet_date_due,
    diabetes_annual_cycle_of_care.feet_details,
    diabetes_annual_cycle_of_care.lipids_date,
    diabetes_annual_cycle_of_care.lipids_date_due,
    diabetes_annual_cycle_of_care.lipids_details,
    diabetes_annual_cycle_of_care.microalbumin_date,
    diabetes_annual_cycle_of_care.microalbumin_date_due,
    diabetes_annual_cycle_of_care.microalbumin_details,
    diabetes_annual_cycle_of_care.renalfunction_date,
    diabetes_annual_cycle_of_care.renalfunction_date_due,
    diabetes_annual_cycle_of_care.renalfunction_details,
    diabetes_annual_cycle_of_care.education_date,
    diabetes_annual_cycle_of_care.education_date_due,
    diabetes_annual_cycle_of_care.education_details,
    diabetes_annual_cycle_of_care.diet_date,
    diabetes_annual_cycle_of_care.diet_date_due,
    diabetes_annual_cycle_of_care.diet_details,
    diabetes_annual_cycle_of_care.exercise_date,
    diabetes_annual_cycle_of_care.exercise_date_due,
    diabetes_annual_cycle_of_care.exercise_details,
    diabetes_annual_cycle_of_care.smoking_date,
    diabetes_annual_cycle_of_care.smoking_date_due,
    diabetes_annual_cycle_of_care.smoking_details,
    diabetes_annual_cycle_of_care.medication_review_date,
    diabetes_annual_cycle_of_care.medication_review_date_due,
    diabetes_annual_cycle_of_care.medication_review_details,
    diabetes_annual_cycle_of_care.deleted,
    diabetes_annual_cycle_of_care.latex,
    diabetes_annual_cycle_of_care.fk_progressnote,
    progressnotes.notes
   FROM chronic_disease_management.diabetes_annual_cycle_of_care
     JOIN clin_consult.consult ON diabetes_annual_cycle_of_care.fk_consult = consult.pk
     JOIN clin_consult.progressnotes ON diabetes_annual_cycle_of_care.fk_progressnote = progressnotes.pk
     ;
ALTER TABLE chronic_disease_management.vwdiabetescycleofcare   OWNER TO easygp;
GRANT SELECT ON TABLE chronic_disease_management.vwdiabetescycleofcare TO staff;	
update db.lu_version set lu_minor = 452;