-- add deleted fields to pregnancy tables to allow deletion of records
-- fixed defaults for some fields



ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN anti_d_34w_given SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN anti_d_28w_given SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN syphilus SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN rubella SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN hepatitis_b SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN hepatitis_c  SET DEFAULT Null;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN rh_antibody_screen_28w SET DEFAULT Null;

alter table clin_pregnancy.ante_natal_visits add column deleted boolean default false;
comment on column clin_pregnancy.ante_natal_visits.deleted is 'If True then this visit is marked as deleted';


alter table clin_pregnancy.pregnancies add column deleted boolean default false;
comment on column clin_pregnancy.pregnancies.deleted is 'If True then this visit is marked as deleted';

CREATE OR REPLACE VIEW clin_pregnancy.vwpregnancies AS 
 SELECT consult.fk_patient, pregnancies.pk AS fk_pregnancy, pregnancies.pk, pregnancies.fk_consult, 
 pregnancies.lmp, pregnancies.edc, pregnancies.edc_revised, pregnancies.edc_revised_reason, 
 pregnancies.date_gtt, pregnancies.gtt_result, pregnancies.notes, pregnancies.gestation, 
 pregnancies.nuchal_fold_scan_date, pregnancies.morphology_scan_date, pregnancies.last_presentation, 
 pregnancies.risk_factor_smoking, pregnancies.risk_factor_smoking_details, pregnancies.risk_factor_alcohol, 
 pregnancies.risk_factor_alcohol_details, pregnancies.risk_factor_drugs, pregnancies.risk_factor_drugs_details, 
 pregnancies.risk_factor_social, pregnancies.risk_factor_social_details, pregnancies.risk_factor_mental_health, 
 pregnancies.risk_factor_mental_health_details, pregnancies.age_at_delivery, pregnancies.date_delivery, 
 pregnancies.gestation_at_delivery, pregnancies.fk_lu_onset_labour, pregnancies.labour_hours, 
 pregnancies.fk_lu_delivery_type, pregnancies.complications, pregnancies.fk_lu_sex, pregnancies.birthweight, 
 pregnancies.baby_name, pregnancies.puerperium, pregnancies.morphology_scan_abnormal, 
 pregnancies.nuchal_fold_abnormal, pregnancies.fk_progressnote, pregnancies.breast_fed, pregnancies.breast_fed_duration, 
 pregnancies.contraception, pregnancies.anti_d_28w_date, pregnancies.anti_d_28w_given, pregnancies.anti_d_34w_date, 
 pregnancies.anti_d_34w_given, pregnancies.morphology_scan_foetal_size, pregnancies.morphology_scan_weeks, 
 pregnancies.fk_lu_blood_group, pregnancies.fk_lu_rhesus_group, pregnancies.booking_haemoglobin, pregnancies.syphilus, 
 pregnancies.rubella, pregnancies.rubella_titre, pregnancies.hepatitis_b, pregnancies.hepatitis_c, 
 pregnancies.booking_msu, pregnancies.group_b_strep_swabs, pregnancies.repeat_antibody_screen_34_37wk, 
 pregnancies.hiv, pregnancies.varicella, pregnancies.rh_antibody_screen_28w, pregnancies.prenatal_diagnosis_amniocentesis, 
 pregnancies.prenatal_diagnosis_cvs, pregnancies.deleted,
 lu_delivery_types.type AS delivery_type, lu_onset_labour.type AS onset_labour_type, 
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
GRANT ALL ON TABLE clin_pregnancy.vwpregnancies TO easygp;
GRANT select  ON TABLE clin_pregnancy.vwpregnancies TO staff;

drop VIEW clin_pregnancy.vwantenatal_visits;
CREATE OR REPLACE VIEW clin_pregnancy.vwantenatal_visits AS 
 SELECT ante_natal_visits.pk AS pk_antenatal_visit, lu_presentations.presentation, ante_natal_visits.fk_consult, 
 consult.fk_patient, ante_natal_visits.fk_pregnancy, ante_natal_visits.visit_date, ante_natal_visits.duration_weeks, 
 ante_natal_visits.fundal_height, ante_natal_visits.fk_lu_presentation, ante_natal_visits.foetal_heart_heard, 
 ante_natal_visits.urinalysis, ante_natal_visits.bloodpressure, ante_natal_visits.weight, 
 ante_natal_visits.foetal_movements_felt, ante_natal_visits.notes, ante_natal_visits.foetal_heart_rate, 
 ante_natal_visits.fk_progressnote, ante_natal_visits.deleted,
 progressnotes.notes AS progress_notes, pregnancies.edc, pregnancies.edc_revised
   FROM clin_pregnancy.ante_natal_visits, clin_pregnancy.lu_presentations, clin_consult.consult, 
   clin_pregnancy.pregnancies, clin_consult.progressnotes
  WHERE 
  ante_natal_visits.fk_lu_presentation = lu_presentations.pk 
  AND ante_natal_visits.fk_consult = consult.pk 
  AND ante_natal_visits.fk_pregnancy = pregnancies.pk 
  AND ante_natal_visits.fk_progressnote = progressnotes.pk;

ALTER TABLE clin_pregnancy.vwantenatal_visits   OWNER TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwantenatal_visits TO easygp;
GRANT SELECT ON TABLE clin_pregnancy.vwantenatal_visits TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 341);

