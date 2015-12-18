-- View: clin_history.vwoccupationalhistory

DROP VIEW clin_history.vwoccupationalhistory;

CREATE OR REPLACE VIEW clin_history.vwoccupationalhistory AS 
 SELECT
        CASE
            WHEN occupations_exposures.pk IS NULL THEN occupational_history.pk || '-0'::text
            ELSE (occupational_history.pk || '-'::text) || occupations_exposures.pk
        END AS pk_view,
    occupational_history.pk AS fk_occupational_history,
    occupational_history.fk_consult,
    occupational_history.fk_occupation,
    occupational_history.from_age,
    occupational_history.to_age,
    occupational_history.current,
    occupational_history.retired,
    occupational_history.notes_occupation,
    occupational_history.deleted AS occupational_history_deleted,
    occupational_history.fk_progressnote,
    occupational_history.main_occupation,
    consult.consult_date,
    consult.fk_patient,
    lu_occupations.occupation,
    occupations_exposures.pk AS fk_occupations_exposure,
    occupations_exposures.fk_lu_occupational_exposure,
    occupations_exposures.exposure_duration,
    occupations_exposures.fk_lu_units,
    occupations_exposures.notes_exposure,
    occupations_exposures.deleted AS exposure_deleted,
    lu_occupational_exposures.exposure,
    lu_units.abbrev_text
   FROM clin_history.occupational_history
     JOIN clin_consult.consult ON occupational_history.fk_consult = consult.pk
     JOIN common.lu_occupations ON occupational_history.fk_occupation = lu_occupations.pk
     LEFT JOIN clin_history.occupations_exposures ON occupational_history.pk = occupations_exposures.fk_occupational_history
     LEFT JOIN clin_history.lu_occupational_exposures ON occupations_exposures.fk_lu_occupational_exposure = lu_occupational_exposures.pk
     LEFT JOIN common.lu_units ON occupations_exposures.fk_lu_units = lu_units.pk;

ALTER TABLE clin_history.vwoccupationalhistory   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwoccupationalhistory TO easygp;
GRANT ALL ON TABLE clin_history.vwoccupationalhistory TO staff;

update db.lu_version set lu_minor = 471;