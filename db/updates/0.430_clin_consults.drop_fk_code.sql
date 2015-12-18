ALTER TABLE clin_consult.progressnotes DROP COLUMN fk_code cascade;
--view clin_consult.vwprogressnotes depends on table clin_consult.progressnotes column fk_code
--view chronic_disease_management.vwdiabetescycleofcare depends on view clin_consult.vwprogressnotes
--view clin_pregnancy.vwpregnancies depends on view clin_consult.vwprogressnotes
--view clin_consult.vwstaffmemberspatientsconsults depends on view clin_consult.vwprogressnotes
--view clin_consult.vwpatientconsults depends on view clin_consult.vwprogressnotes

ALTER TABLE clin_consult.progressnotes DROP COLUMN fk_problem cascade;

CREATE OR REPLACE VIEW clin_consult.vwprogressnotes AS 
 SELECT "CONSULT".fk_patient,
    progressnotes.pk AS pk_progressnote,
    "CONSULT".consult_date,
    "CONSULT_TYPE".type AS consult_type,
    "SECTION".section,
    progressnotes.problem,
    progressnotes.notes,
    "CONSULT".summary,
    progressnotes.fk_consult,
    progressnotes.fk_section,
    progressnotes.fk_audit_action,
    progressnotes.deleted,
    "CONSULT".fk_staff,
    "CONSULT".fk_type,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    lu_audit_actions.action AS audit_action,
    progressnotes.linked_table,
    progressnotes.fk_audit_reason,
    lu_audit_reasons.reason AS audit_reason,
    progressnotes.fk_row,
    lu_audit_actions.insist_reason,
    lu_staff_roles.role
   FROM clin_consult.consult "CONSULT"
     LEFT JOIN clin_consult.lu_consult_type "CONSULT_TYPE" ON "CONSULT".fk_type = "CONSULT_TYPE".pk
     JOIN admin.staff ON "CONSULT".fk_staff = staff.pk
     JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
     JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     JOIN clin_consult.progressnotes ON "CONSULT".pk = progressnotes.fk_consult
     JOIN clin_consult.lu_progressnotes_sections "SECTION" ON progressnotes.fk_section = "SECTION".pk
     JOIN clin_consult.lu_audit_actions ON progressnotes.fk_audit_action = lu_audit_actions.pk
     JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
     LEFT JOIN clin_consult.lu_audit_reasons ON progressnotes.fk_audit_reason = lu_audit_reasons.pk
  WHERE "CONSULT_TYPE".pk <> 8
  ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk;

ALTER TABLE clin_consult.vwprogressnotes   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotes TO staff;
COMMENT ON VIEW clin_consult.vwprogressnotes
  IS 'the fk_lu_consult_type = 8 is ''Review of Correspondance''';

CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetescycleofcare AS 
 SELECT (diabetes_annual_cycle_of_care.pk || '-'::text) || COALESCE(diabetes_annual_cycle_of_care_notes.pk, 0)::text AS pk_view,
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
    diabetes_annual_cycle_of_care.fk_progressnote_components,
    diabetes_annual_cycle_of_care.latex,
    diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments,
    vwprogressnotes.consult_date AS date_progress_note_comment,
    vwstaff.title AS staff_made_comment_title,
    vwstaff.wholename AS staff_made_comment_wholename,
    vwstaff1.title AS staff_started_title,
    vwstaff1.wholename AS staff_started_wholename,
    progressnotes.notes AS component_notes,
    vwprogressnotes.notes AS comments_notes
   FROM chronic_disease_management.diabetes_annual_cycle_of_care
     JOIN clin_consult.consult ON diabetes_annual_cycle_of_care.fk_consult = consult.pk
     LEFT JOIN chronic_disease_management.diabetes_annual_cycle_of_care_notes ON diabetes_annual_cycle_of_care.pk = diabetes_annual_cycle_of_care_notes.fk_diabetes_annual_cycle_of_care
     LEFT JOIN clin_consult.vwprogressnotes ON diabetes_annual_cycle_of_care_notes.fk_progressnote = vwprogressnotes.pk_progressnote
     LEFT JOIN admin.vwstaff ON vwprogressnotes.fk_staff = vwstaff.fk_staff
     JOIN clin_consult.progressnotes ON diabetes_annual_cycle_of_care.fk_progressnote_components = progressnotes.pk
     JOIN admin.vwstaff vwstaff1 ON consult.fk_staff = vwstaff1.pk;

ALTER TABLE chronic_disease_management.vwdiabetescycleofcare   OWNER TO easygp;
GRANT SELECT ON TABLE chronic_disease_management.vwdiabetescycleofcare TO staff;


CREATE OR REPLACE VIEW clin_pregnancy.vwpregnancies AS 
 SELECT consult.fk_patient,
    pregnancies.pk AS fk_pregnancy,
    pregnancies.pk,
    pregnancies.fk_consult,
    pregnancies.lmp,
    pregnancies.edc,
    pregnancies.edc_revised,
    pregnancies.edc_revised_reason,
    pregnancies.date_gtt,
    pregnancies.gtt_result,
    pregnancies.notes,
    pregnancies.gestation,
    pregnancies.nuchal_fold_scan_date,
    pregnancies.morphology_scan_date,
    pregnancies.last_presentation,
    pregnancies.risk_factor_smoking,
    pregnancies.risk_factor_smoking_details,
    pregnancies.risk_factor_alcohol,
    pregnancies.risk_factor_alcohol_details,
    pregnancies.risk_factor_drugs,
    pregnancies.risk_factor_drugs_details,
    pregnancies.risk_factor_social,
    pregnancies.risk_factor_social_details,
    pregnancies.risk_factor_mental_health,
    pregnancies.risk_factor_mental_health_details,
    pregnancies.risk_factors_past_history,
    pregnancies.risk_factors_obstetric,
    pregnancies.reason_caesarian_section,
    pregnancies.age_at_delivery,
    pregnancies.date_delivery,
    pregnancies.gestation_at_delivery,
    pregnancies.fk_lu_onset_labour,
    pregnancies.labour_hours,
    pregnancies.fk_lu_delivery_type,
    pregnancies.complications,
    pregnancies.fk_lu_sex,
    pregnancies.birthweight,
    pregnancies.baby_name,
    pregnancies.puerperium,
    pregnancies.morphology_scan_abnormal,
    pregnancies.nuchal_fold_abnormal,
    pregnancies.fk_progressnote,
    pregnancies.breast_fed,
    pregnancies.breast_fed_duration,
    pregnancies.contraception,
    pregnancies.anti_d_28w_date,
    pregnancies.anti_d_28w_given,
    pregnancies.anti_d_34w_date,
    pregnancies.anti_d_34w_given,
    pregnancies.morphology_scan_foetal_size,
    pregnancies.morphology_scan_weeks,
    pregnancies.fk_lu_blood_group,
    pregnancies.fk_lu_rhesus_group,
    pregnancies.booking_haemoglobin,
    pregnancies.syphilus,
    pregnancies.rubella,
    pregnancies.rubella_titre,
    pregnancies.hepatitis_b,
    pregnancies.hepatitis_c,
    pregnancies.booking_msu,
    pregnancies.group_b_strep_swabs,
    pregnancies.booking_antibody_screen,
    pregnancies.repeat_antibody_screen_34_37wk,
    pregnancies.hiv,
    pregnancies.varicella,
    pregnancies.rh_antibody_screen_28w,
    pregnancies.prenatal_diagnosis_amniocentesis,
    pregnancies.prenatal_diagnosis_cvs,
    pregnancies.deleted,
    pregnancies.fk_lu_contraception_method,
    pregnancies.contraception_method_notes,
    lu_delivery_types.type AS delivery_type,
    pregnancies.fk_lu_placenta_position,
    lu_placenta_position."position",
    lu_onset_labour.type AS onset_labour_type,
    lu_sex.sex_text AS baby_sex,
    lu_blood_group.abo_group,
    lu_rhesus_group.rhesus_group,
    vwprogressnotes.notes AS progress_notes,
    vwprogressnotes.consult_date AS progress_notes_date
   FROM clin_pregnancy.pregnancies
     JOIN clin_consult.consult ON pregnancies.fk_consult = consult.pk
     JOIN clin_consult.vwprogressnotes ON pregnancies.fk_progressnote = vwprogressnotes.pk_progressnote
     LEFT JOIN clin_pregnancy.lu_onset_labour ON pregnancies.fk_lu_onset_labour = lu_onset_labour.pk
     LEFT JOIN clin_pregnancy.lu_delivery_types ON pregnancies.fk_lu_delivery_type = lu_delivery_types.pk
     LEFT JOIN common.lu_blood_group ON pregnancies.fk_lu_blood_group = lu_blood_group.pk
     LEFT JOIN common.lu_rhesus_group ON pregnancies.fk_lu_rhesus_group = lu_rhesus_group.pk
     LEFT JOIN contacts.lu_sex ON pregnancies.fk_lu_sex = lu_sex.pk
     LEFT JOIN clin_pregnancy.lu_placenta_position ON pregnancies.fk_lu_placenta_position = lu_placenta_position.pk
     LEFT JOIN clin_pregnancy.lu_contraception_methods ON pregnancies.fk_lu_contraception_method = lu_contraception_methods.pk;

ALTER TABLE clin_pregnancy.vwpregnancies   OWNER TO easygp;
GRANT SELECT ON clin_pregnancy.vwpregnancies TO staff;

CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view,
    vwprogressnotes.fk_patient,
    vwprogressnotes.consult_date,
    vwprogressnotes.consult_type,
    vwprogressnotes.fk_staff,
    vwprogressnotes.title AS staff_title,
    vwprogressnotes.surname AS staff_surname,
    vwprogressnotes.firstname AS staff_firstname,
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
   FROM clin_consult.vwprogressnotes,
    contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;

CREATE OR REPLACE VIEW clin_consult.vwstaffmemberspatientsconsults AS 
 SELECT DISTINCT to_char(vwprogressnotes.consult_date, 'DD/MM/YYYY'::text) AS pk_view,
    vwprogressnotes.consult_date,
    vwprogressnotes.fk_consult,
    vwprogressnotes.fk_staff,
    vwprogressnotes.fk_patient,
    vwprogressnotes.fk_type,
    vwprogressnotes.consult_type
   FROM clin_consult.vwprogressnotes
  WHERE (vwprogressnotes.fk_audit_action = 1 OR vwprogressnotes.fk_audit_action = 2) AND vwprogressnotes.deleted = false;

ALTER TABLE clin_consult.vwstaffmemberspatientsconsults   OWNER TO easygp;
GRANT SELECT ON TABLE clin_consult.vwstaffmemberspatientsconsults TO staff;

COMMENT ON VIEW clin_consult.vwstaffmemberspatientsconsults   IS 'a view of all the consults of a patient for a individual staff members keyed by consult date';
update db.lu_version set lu_minor=430;