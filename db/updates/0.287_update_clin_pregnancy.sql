alter table clin_pregnancy.ante_natal_visits add column foetal_heart_rate integer default null;

DROP VIEW clin_pregnancy.vwantenatal_visits;


CREATE OR REPLACE VIEW clin_pregnancy.vwantenatal_visits AS 
 SELECT ante_natal_visits.pk AS pk_antenatal_visit, lu_presentations.presentation, 
 ante_natal_visits.fk_consult, consult.fk_patient, ante_natal_visits.fk_pregnancy, 
 ante_natal_visits.visit_date, ante_natal_visits.duration_weeks, 
 ante_natal_visits.fundal_height, ante_natal_visits.fk_lu_presentation, 
 ante_natal_visits.foetal_heart_heard, ante_natal_visits.urinalysis, 
 ante_natal_visits.bloodpressure, ante_natal_visits.weight, 
 ante_natal_visits.foetal_movements_felt, ante_natal_visits.notes,
 ante_natal_visits.foetal_heart_rate,
  pregnancies.edc, pregnancies.edc_revised
   FROM clin_pregnancy.ante_natal_visits, clin_pregnancy.lu_presentations, 
   clin_consult.consult, clin_pregnancy.pregnancies
  WHERE ante_natal_visits.fk_lu_presentation = lu_presentations.pk 
  AND ante_natal_visits.fk_consult = consult.pk 
  AND ante_natal_visits.fk_pregnancy = pregnancies.pk;

ALTER TABLE clin_pregnancy.vwantenatal_visits   OWNER TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwantenatal_visits TO easygp;
GRANT ALL ON TABLE clin_pregnancy.vwantenatal_visits TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 287)

