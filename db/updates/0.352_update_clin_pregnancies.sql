-- added a field I neglected for booking antibodies
ALTER TABLE clin_pregnancy.pregnancies ADD COLUMN booking_antibody_screen boolean;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN booking_antibody_screen SET DEFAULT false;
COMMENT ON COLUMN clin_pregnancy.pregnancies.booking_antibody_screen IS 'True if positive , False if negative and null if unknown';

-- fixed some typo's in the comments
COMMENT ON COLUMN clin_pregnancy.pregnancies.repeat_antibody_screen_34_37wk IS 'True if positive , False if negative and null if unknown';
COMMENT ON COLUMN clin_pregnancy.pregnancies.hiv IS 'True if Positive , False if negative and null if unknown';
COMMENT ON COLUMN clin_pregnancy.pregnancies.group_b_strep_swabs IS 'True if positive , False if negative and null if unknown';

-- add the booking_antibody_screen  field to the view.
drop view clin_pregnancy.vwpregnancies;
CREATE OR REPLACE VIEW clin_pregnancy.vwpregnancies AS 
 SELECT consult.fk_patient, pregnancies.pk AS fk_pregnancy, pregnancies.pk, pregnancies.fk_consult, 
 pregnancies.lmp, pregnancies.edc, pregnancies.edc_revised, pregnancies.edc_revised_reason, 
 pregnancies.date_gtt, pregnancies.gtt_result, pregnancies.notes, pregnancies.gestation, 
 pregnancies.nuchal_fold_scan_date, pregnancies.morphology_scan_date, pregnancies.last_presentation, 
 pregnancies.risk_factor_smoking, pregnancies.risk_factor_smoking_details, pregnancies.risk_factor_alcohol, 
 pregnancies.risk_factor_alcohol_details, pregnancies.risk_factor_drugs, pregnancies.risk_factor_drugs_details, 
 pregnancies.risk_factor_social, pregnancies.risk_factor_social_details, pregnancies.risk_factor_mental_health, 
 pregnancies.risk_factor_mental_health_details, pregnancies.age_at_delivery, pregnancies.date_delivery, 
 pregnancies.gestation_at_delivery, pregnancies.fk_lu_onset_labour, pregnancies.labour_hours, pregnancies.fk_lu_delivery_type,
  pregnancies.complications, pregnancies.fk_lu_sex, pregnancies.birthweight, pregnancies.baby_name, 
  pregnancies.puerperium, pregnancies.morphology_scan_abnormal, pregnancies.nuchal_fold_abnormal, 
  pregnancies.fk_progressnote, pregnancies.breast_fed, pregnancies.breast_fed_duration, pregnancies.contraception, 
  pregnancies.anti_d_28w_date, pregnancies.anti_d_28w_given, pregnancies.anti_d_34w_date, 
  pregnancies.anti_d_34w_given, pregnancies.morphology_scan_foetal_size, pregnancies.morphology_scan_weeks, 
  pregnancies.fk_lu_blood_group, pregnancies.fk_lu_rhesus_group, pregnancies.booking_haemoglobin, 
  pregnancies.syphilus, pregnancies.rubella, pregnancies.rubella_titre, pregnancies.hepatitis_b,
  pregnancies.hepatitis_c, pregnancies.booking_msu, pregnancies.group_b_strep_swabs, 
  pregnancies.booking_antibody_screen,
  pregnancies.repeat_antibody_screen_34_37wk, pregnancies.hiv, pregnancies.varicella, 
  pregnancies.rh_antibody_screen_28w, pregnancies.prenatal_diagnosis_amniocentesis, pregnancies.prenatal_diagnosis_cvs,
   pregnancies.deleted, lu_delivery_types.type AS delivery_type, lu_onset_labour.type AS onset_labour_type, 
   lu_sex.sex_text AS baby_sex, lu_blood_group.abo_group, lu_rhesus_group.rhesus_group, vwprogressnotes.notes AS progress_notes, 
   vwprogressnotes.consult_date AS progress_notes_date
   FROM clin_pregnancy.pregnancies
   JOIN clin_consult.consult ON pregnancies.fk_consult = consult.pk
   JOIN clin_consult.vwprogressnotes ON pregnancies.fk_progressnote = vwprogressnotes.pk_progressnote
   LEFT JOIN clin_pregnancy.lu_onset_labour ON pregnancies.fk_lu_onset_labour = lu_onset_labour.pk
   LEFT JOIN clin_pregnancy.lu_delivery_types ON pregnancies.fk_lu_delivery_type = lu_delivery_types.pk
   LEFT JOIN common.lu_blood_group ON pregnancies.fk_lu_blood_group = lu_blood_group.pk
   LEFT JOIN common.lu_rhesus_group ON pregnancies.fk_lu_rhesus_group = lu_rhesus_group.pk
   LEFT JOIN contacts.lu_sex ON pregnancies.fk_lu_sex = lu_sex.pk;

ALTER TABLE clin_pregnancy.vwpregnancies   OWNER TO easygp;
GRANT SELECT ON TABLE clin_pregnancy.vwpregnancies TO staff;

update db.lu_version set lu_minor=352;



