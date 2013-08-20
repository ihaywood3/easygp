alter table clin_pregnancy.ante_natal_visits  alter column duration_weeks  drop default, alter column duration_weeks drop not null;
alter table clin_pregnancy.pregnancies drop column edc_revised cascade;
alter table clin_pregnancy.pregnancies add column edc_revised date default null;
alter table clin_pregnancy.pregnancies add column edc_revised_reason text default null;
alter table clin_pregnancy.pregnancies add column gtt_result text default null;
alter table clin_pregnancy.pregnancies add column nuchal_fold_abnormal boolean default null;
alter table clin_pregnancy.pregnancies add column morphology_scan_abnormal boolean default null;

CREATE OR REPLACE VIEW clin_pregnancy.vwpregnancies AS 
 SELECT consult.fk_patient, pregnancies.pk AS fk_pregnancy, pregnancies.pk, 
 pregnancies.fk_consult, pregnancies.lmp, 
 pregnancies.edc, pregnancies.edc_revised, pregnancies.edc_revised_reason,
 pregnancies.date_anti_d, pregnancies.anti_d_given, pregnancies.date_gtt, 
 pregnancies.notes, pregnancies.gestation, pregnancies.nuchal_fold_scan_date, 
 pregnancies.morphology_scan_date, pregnancies.last_presentation, 
 pregnancies.risk_factor_smoking, pregnancies.risk_factor_smoking_details, 
 pregnancies.risk_factor_alcohol, pregnancies.risk_factor_alcohol_details, 
 pregnancies.risk_factor_drugs, pregnancies.risk_factor_drugs_details, 
 pregnancies.risk_factor_social, pregnancies.risk_factor_social_details, 
 pregnancies.risk_factor_mental_health, pregnancies.risk_factor_mental_health_details, 
 pregnancies.age_at_delivery, pregnancies.date_delivery, pregnancies.gestation_at_delivery, 
 pregnancies.fk_lu_onset_labour, pregnancies.labour_hours, pregnancies.fk_lu_delivery_type, 
 pregnancies.complications, pregnancies.fk_lu_sex, pregnancies.birthweight, pregnancies.baby_name, 
 pregnancies.peurperium, lu_delivery_types.type AS delivery_type, 
 lu_onset_labour.type AS onset_labour_type, lu_sex.sex_text AS baby_sex
   FROM clin_pregnancy.pregnancies
   JOIN clin_consult.consult ON pregnancies.fk_consult = consult.pk
   LEFT JOIN clin_pregnancy.lu_onset_labour ON pregnancies.fk_lu_onset_labour = lu_onset_labour.pk
   LEFT JOIN clin_pregnancy.lu_delivery_types ON pregnancies.fk_lu_delivery_type = lu_delivery_types.pk
   LEFT JOIN contacts.lu_sex ON pregnancies.fk_lu_sex = lu_sex.pk;

ALTER TABLE clin_pregnancy.vwpregnancies   OWNER TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwpregnancies TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwpregnancies TO staff;



CREATE OR REPLACE VIEW clin_pregnancy.vwantenatal_visits AS 
 SELECT ante_natal_visits.pk AS pk_antenatal_visit, lu_presentations.presentation, ante_natal_visits.fk_consult, 
 consult.fk_patient, ante_natal_visits.fk_pregnancy, ante_natal_visits.visit_date, ante_natal_visits.duration_weeks, 
 ante_natal_visits.fundal_height, ante_natal_visits.fk_lu_presentation, ante_natal_visits.foetal_heart_heard, 
 ante_natal_visits.urinalysis, ante_natal_visits.bloodpressure, ante_natal_visits.weight, 
 ante_natal_visits.foetal_movements_felt, ante_natal_visits.notes, ante_natal_visits.foetal_heart_rate, 
 pregnancies.edc, pregnancies.edc_revised pregnancies,edc_revised_reason
   FROM clin_pregnancy.ante_natal_visits, clin_pregnancy.lu_presentations, 
   clin_consult.consult, clin_pregnancy.pregnancies
  WHERE 
      ante_natal_visits.fk_lu_presentation = lu_presentations.pk 
  AND ante_natal_visits.fk_consult = consult.pk 
  AND ante_natal_visits.fk_pregnancy = pregnancies.pk;

ALTER TABLE clin_pregnancy.vwantenatal_visits   OWNER TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwantenatal_visits TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwantenatal_visits TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 311);
