-- View: clin_history.vwrecreationaldrugsused

-- DROP VIEW clin_history.vwrecreationaldrugsused;
DROP VIEW  clin_history.vwrecreationaldrugsused;

CREATE OR REPLACE VIEW clin_history.vwrecreationaldrugsused AS 
 SELECT recreational_drugs.pk,
    data_patients.pk AS fk_patient,
    lu_recreational_drugs.drug,
    lu_recreational_drugs.alternative_names,
    lu_route_administration.route,
    consult.consult_date,
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
    recreational_drugs.confidential,
    recreational_drugs.fk_progressnote,
    lu_recreational_drugs.quantification,
    lu_recreational_drugs.illicit,
    lu_recreational_drugs.default_fk_lu_route_administration,
    progressnotes.notes AS progress_notes
   FROM clin_history.recreational_drugs
     JOIN clin_consult.consult ON consult.pk = recreational_drugs.fk_consult
     JOIN clerical.data_patients ON data_patients.pk = consult.fk_patient
     JOIN common.lu_recreational_drugs ON lu_recreational_drugs.pk = recreational_drugs.fk_lu_recreational_drug
     LEFT JOIN clin_consult.progressnotes ON progressnotes.pk = recreational_drugs.fk_progressnote
     LEFT JOIN common.lu_route_administration ON lu_route_administration.pk = recreational_drugs.fk_lu_route_administration
     LEFT JOIN common.lu_units ON lu_units.pk = recreational_drugs.fk_lu_substance_amount_units;

ALTER TABLE clin_history.vwrecreationaldrugsused   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwrecreationaldrugsused TO staff;

update db.lu_version set lu_minor = 472;