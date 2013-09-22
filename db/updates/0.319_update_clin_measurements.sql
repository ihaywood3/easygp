Alter TABLE clin_measurements.inr_dose_management add column date_inr date not null;

comment on column clin_measurements.inr_dose_management.date_inr is
'The date the INR was taken. Though you would think fk_consult should give this,
 and of course if does/may if the recorded measurement was made on the same date
 that it is recorded however this may not be the case, e.g patient could have
 brought in his home INR reading etc.';

alter table clin_measurements.inr_dose_management 
add column fk_observation integer not null;

comment on column clin_measurements.inr_dose_management.fk_observation is
'foreign key to documents.observations points to the actual inr value';

Alter table clin_measurements.inr_dose_management 
add column last_dose text not null;

comment on column clin_measurements.inr_dose_management.last_dose is
'The last dose of warfarin the patient was taking prior to this INR
 this is a text fields because e.g this could be 3.5/2.0 which
 reflects alternate day dosing';

 COMMENT ON COLUMN clin_measurements.inr_dose_management.dose_advised IS 
 'the dosage pattern ''/'' separated eg. 4.0/3.5 etc i.e here alternate days by implication';

 comment on column clin_measurements.lu_reason_anticoagulant_use.fk_code is
'foreign key to coding.generic_terms, this contains details of the code and the coding system';

Alter Table clin_measurements.inr_plan add column use_lab_hl7 boolean default True;
comment on column clin_measurements.inr_plan.use_lab_hl7 is
'If true then when dose advice is added EasyGP will by default pull in the last INR Value from HL7,
 rather than expect the user to enter the value';
 
alter table clin_measurements.inr_plan add column date_plan_created date not null;
comment on column clin_measurements.inr_plan.date_plan_created is
'the date the plan was created. Note this must be included because fk_consult will
 only point to the date the plan was accessed - this could be the creation date
 but could be the date it was modified.';
 
 
alter table clin_measurements.inr_dose_management alter column last_dose drop not null;
COMMENT ON COLUMN clin_measurements.inr_dose_management.last_dose IS 
'The last dose of warfarin the patient was taking prior to this INR
 this is a text fields because e.g this could be 3.5/2.0 which
 reflects alternate day dosing, if unknown can be null or 0.0/0.0';

create view clin_measurements.vwINRManagement as
SELECT 
  observations.pk,
  observations.value, 
  observations.abnormal, 
  observations.observation_date as date_inr, 
  inr_dose_management.dose_advised, 
  inr_dose_management.date_recheck, 
  inr_dose_management.last_dose, 
  consult.fk_patient
FROM 
  clin_measurements.inr_dose_management, 
  documents.observations, 
  clin_consult.consult
WHERE 
  inr_dose_management.fk_observation = observations.pk 
  AND
  inr_dose_management.fk_consult = consult.pk
  AND 
  observations.loinc= '6301-6' order by fk_patient;


ALTER TABLE clin_measurements.vwinrmanagement   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwinrmanagement TO easygp;
GRANT SELECT ON TABLE clin_measurements.vwinrmanagement TO staff;
COMMENT ON VIEW clin_measurements.vwinrmanagement
  IS 'a view containing all the patients INR''s and where the data is entered dosage and follow up advice.';


Drop view clin_measurements.vwINRPlans;

Create view clin_measurements.vwINRPlans as 
SELECT 
  consult.fk_patient, 
  consult.fk_staff, 
  inr_plan.pk, 
  inr_plan.fk_lu_reason_anticoagulant_use, 
  lu_reason_anticoagulant_use.reason, 
  lu_reason_anticoagulant_use.fk_code, 
  inr_plan.fk_progressnote, 
  inr_plan.inr_target_range, 
  inr_plan.comment, 
  inr_plan.use_lab_hl7, 
  inr_plan.date_plan_created, 
  inr_plan.fk_consult, 
  consult.consult_date, 
  consult1.consult_date AS progress_note_date
FROM 
  clin_consult.consult, 
  clin_measurements.inr_plan, 
  clin_consult.consult as consult1, 
  clin_consult.progressnotes, 
  clin_measurements.lu_reason_anticoagulant_use
WHERE 
  inr_plan.fk_consult = consult.pk AND
  inr_plan.fk_progressnote = progressnotes.pk AND
  inr_plan.fk_lu_reason_anticoagulant_use = lu_reason_anticoagulant_use.pk AND
  progressnotes.fk_consult = consult1.pk;
 
ALTER TABLE clin_measurements.vwinrplans   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwinrplans TO easygp;
GRANT SELECT ON TABLE clin_measurements.vwinrplans TO staff;

 
Create or replace view clin_measurements.vwLabINRs as
SELECT 
  documents.pk,
  documents.source_file, 
  documents.fk_patient,
  observations.loinc, 
  observations.value, 
  observations.abnormal, 
  observations.observation_date,
  observations.pk as fk_observation
FROM 
  documents.documents, 
  documents.observations
WHERE 
  documents.pk = observations.fk_document
AND
observations.loinc='6301-6'
AND
  documents.source_file is not null
ORDER BY fk_patient;

ALTER TABLE clin_measurements.vwLabINRs   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwLabINRs TO easygp;
GRANT SELECT ON TABLE clin_measurements.vwLabINRs TO staff;
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 319);

