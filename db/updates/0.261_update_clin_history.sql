-- work on recreational drug use tables
drop table clin_history.recreational_drugs cascade;

CREATE TABLE clin_history.recreational_drugs
(
  pk serial primary key,
  fk_consult integer not null,
  fk_lu_recreational_drug integer not null,
  age_started integer default null,
  age_last_used integer default null,
  substance_amount integer default null,
  fk_lu_substance_amount_units integer default null,
  fk_lu_substance_frequency integer default null,
  fk_lu_route_administration integer default null,
  cumulative_amount integer default null,
  never_used_drug boolean default false,
  notes text,
  deleted boolean default false,
  CONSTRAINT recreational_drugs_fk_consult FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT recreational_drugs_fk_lu_recreational_drug FOREIGN KEY (fk_lu_recreational_drug)
      REFERENCES common.lu_recreational_drugs (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 );
ALTER TABLE clin_history.recreational_drugs OWNER TO easygp;
GRANT ALL ON TABLE clin_history.recreational_drugs TO easygp;
GRANT SELECT ON TABLE clin_history.recreational_drugs TO staff;

Comment on table clin_history.recreational_drugs is
'A list of the patient''s recreational drug use
 - note it is not possible to be absolutely precise about age started/stopped drugs a use can start stop, so comments should be added to the notes field';
comment on column  clin_history.recreational_drugs.fk_lu_recreational_drug is 'foreign key to common.lu_recreational_drugs';
comment on column  clin_history.recreational_drugs.age_started is 'the age the patient first used this drug';
comment on column  clin_history.recreational_drugs.age_last_used is 'the age the patient last used or stopped using the drug';
comment on column  clin_history.recreational_drugs.substance_amount is 'the quantity of the substance e.g 10 if say 10gm of alcohol per day see lu_substance_frequency';
comment on column  clin_history.recreational_drugs.fk_lu_substance_frequency is 'foreign key to common.lu_units but front end will allow on day/week/month/year';
comment on column  clin_history.recreational_drugs.fk_lu_substance_amount_units is 'the units for the substance amount eg gm key to common.lu_units (to be restricted in the front end';
comment on column  clin_history.recreational_drugs.fk_lu_route_administration is 'key to common.lu_route_administration';
comment on column  clin_history.recreational_drugs.notes is 'any qualifying information about the drug eg, ''used intermittently 20-30, stopped in 30''s, started again in 40''s';
comment on column clin_history.recreational_drugs.cumulative_amount is 'the cumulative amount of the drug meant more for  nicotine eg 25=25 pack years';
comment on column clin_history.recreational_drugs.never_used_drug is 'this apparently useless column is because we have to record if say smoker is non-smoker or non- drinker, just have empty start_age end_age is not good enough';

Create or replace view clin_history.vwRecreationalDrugsUsed as
SELECT 
  recreational_drugs.pk, 
  data_patients.pk as fk_patient,
  lu_recreational_drugs.drug, 
  lu_recreational_drugs.alternative_names, 
  lu_route_administration.route, 
  
  recreational_drugs.fk_consult, 
  recreational_drugs.fk_lu_recreational_drug, 
  recreational_drugs.age_started, 
  recreational_drugs.age_last_used, 
  recreational_drugs.substance_amount, 
  recreational_drugs.fk_lu_substance_amount_units, 
  recreational_drugs.fk_lu_substance_frequency, 
  recreational_drugs.fk_lu_route_administration, 
  recreational_drugs.notes, 
  recreational_drugs.deleted, 
  recreational_drugs.never_used_drug,
  recreational_drugs.cumulative_amount, 
  lu_recreational_drugs.quantification, 
  lu_recreational_drugs.illicit, 
  lu_recreational_drugs.default_fk_lu_route_administration
FROM 
clin_history.recreational_drugs
 JOIN clin_consult.consult on consult.pk= recreational_drugs.fk_consult
 JOIN clerical.data_patients on data_patients.pk = consult.fk_patient
 JOIN common.lu_recreational_drugs on lu_recreational_drugs.pk = recreational_drugs.fk_lu_recreational_drug
 JOIN common.lu_route_administration on lu_route_administration.pk = recreational_drugs.fk_lu_route_administration
 LEFT JOIN  common.lu_units on lu_units.pk = recreational_drugs.fk_lu_substance_amount_units;

ALTER TABLE clin_history.vwRecreationalDrugsUsed OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwRecreationalDrugsUsed TO easygp;
GRANT SELECT ON TABLE clin_history.vwRecreationalDrugsUsed TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 261);

