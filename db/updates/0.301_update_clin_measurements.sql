-- create tables for INR management
Create  table clin_measurements.lu_reason_anticoagulant_use
(pk serial primary key,
reason text not null,
fk_code text not null
);
COMMENT ON TABLE	clin_measurements.lu_reason_anticoagulant_use IS 
'the reason and coded reason for the anti-coagulant''s use';

ALTER TABLE clin_measurements.lu_reason_anticoagulant_use   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.lu_reason_anticoagulant_use TO easygp;
GRANT SELECT ON TABLE clin_measurements.lu_reason_anticoagulant_use TO staff;


--drop table  clin_measurements.inr_plan;

Create  table clin_measurements.inr_plan
(pk serial primary key,
fk_lu_reason_anticoagulant_use integer references clin_measurements.lu_reason_anticoagulant_use(pk) ,
fk_consult integer not null references clin_consult.consult (pk),
fk_progressnote integer default null,
inr_target_range text not null,
"comment" text default null
);

COMMENT ON TABLE	clin_measurements.inr_plan IS 'the core INR plan for the patient';
COMMENT ON COLUMN	clin_measurements.inr_plan.fk_lu_reason_anticoagulant_use is
'foreign key to clin_measurements.lu_reason_anticoagulant_use points to free text and coded reason for anti-coagulation';

ALTER TABLE clin_measurements.inr_plan   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.inr_plan TO easygp;
GRANT SELECT ON TABLE clin_measurements.inr_plan TO staff;

--drop table clin_measurements.inr_dose_management;

Create  table clin_measurements.inr_dose_management
(pk serial primary key,
fk_consult integer not null references clin_consult.consult (pk),
fk_progressnote integer default null,
dose_advised text not null,
date_recheck date not null,
comment text default null
);
COMMENT ON TABLE	clin_measurements.inr_dose_management is
'today''s advise about the current INR level';
COMMENT ON COLUMN	clin_measurements.inr_dose_management.dose_advised is
'the dosage pattern comma separated eg. 4,3.5 etc i.e here alternate days by implication';

ALTER TABLE clin_measurements.inr_dose_management   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.inr_dose_management TO easygp;
GRANT SELECT ON TABLE clin_measurements.inr_dose_management TO staff;

Create or replace view clin_measurements.vwINRPlans as

SELECT 
  inr_plan.pk,
  lu_reason_anticoagulant_use.reason, 
  generic_terms.term, 
  consult.consult_date, 
  consult.fk_patient, 
  lu_reason_anticoagulant_use.fk_code, 
  inr_plan.inr_target_range, 
  inr_plan.comment,
    inr_plan.fk_progressnote
FROM 
  clin_consult.consult, 
  clin_measurements.inr_plan, 
  clin_measurements.lu_reason_anticoagulant_use, 
  coding.generic_terms
WHERE 
  inr_plan.fk_lu_reason_anticoagulant_use = lu_reason_anticoagulant_use.pk AND
  inr_plan.fk_consult = consult.pk AND
  lu_reason_anticoagulant_use.fk_code = generic_terms.code;

ALTER TABLE clin_measurements.vwINRPlans   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwINRPlans TO easygp;
GRANT SELECT ON TABLE clin_measurements.vwINRPlans TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 301)

