-- added a new field main_occupation as patient can have more than 1 current occupation
-- and this was needed for display purposes on the toolbar

Alter table clin_history.occupational_history add column main_occupation boolean default False;
comment on column  clin_history.occupational_history.main_occupation is
'if True and the patient has multiple occupations in their history or two current occupations then
 this will be the one displayed on the clinical toolbar and annotated in the history summary';

-- I don't think this rather brash presumptive update will cause much grief at this stage
-- as most of us don't have many occupations in the database.

update clin_history.occupational_history set main_occupation = True;

 DROP VIEW clin_history.vwoccupationalhistory;
CREATE OR REPLACE VIEW clin_history.vwoccupationalhistory AS 
 SELECT 
        CASE
            WHEN occupations_exposures.pk IS NULL THEN occupational_history.pk || '-0'::text
            ELSE (occupational_history.pk || '-'::text) || occupations_exposures.pk
        END AS pk_view, occupational_history.pk AS fk_occupational_history, 
        occupational_history.fk_consult, occupational_history.fk_occupation, occupational_history.from_age, 
        occupational_history.to_age, occupational_history.current, occupational_history.retired, 
        occupational_history.notes_occupation, occupational_history.deleted AS occupational_history_deleted, 
        occupational_history.fk_progressnote, occupational_history.main_occupation,
        consult.consult_date, consult.fk_patient, 
        lu_occupations.occupation, occupations_exposures.pk AS fk_occupations_exposures, 
        occupations_exposures.fk_exposure, occupations_exposures.exposure_duration, 
        occupations_exposures.exposure_duration_units, occupations_exposures.notes_exposure, 
        lu_exposures.exposure, lu_exposures.fk_decision_support, 
        occupations_exposures.deleted AS exposure_deleted, lu_units.abbrev_text
   FROM clin_history.occupational_history
   JOIN clin_consult.consult ON occupational_history.fk_consult = consult.pk
   JOIN common.lu_occupations ON occupational_history.fk_occupation = lu_occupations.pk
   LEFT JOIN clin_history.occupations_exposures ON occupational_history.pk = occupations_exposures.fk_occupational_history
   LEFT JOIN clin_history.lu_exposures ON occupations_exposures.fk_exposure = lu_exposures.pk
   LEFT JOIN common.lu_units ON occupations_exposures.exposure_duration_units = lu_units.pk;

ALTER TABLE clin_history.vwoccupationalhistory   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwoccupationalhistory TO easygp;
GRANT ALL ON TABLE clin_history.vwoccupationalhistory TO staff;

truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 322);
