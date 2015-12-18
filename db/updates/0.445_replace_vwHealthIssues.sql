-- View: clin_history.vwhealthissues

DROP VIEW clin_history.vwhealthissues;

CREATE OR REPLACE VIEW clin_history.vwhealthissues AS 
 SELECT consult.fk_patient,
    past_history.pk AS pk_pasthistory,
    past_history.age_onset,
    past_history.age_onset_units,
    past_history.description,
    past_history.fk_laterality,
    past_history.year_onset,
    past_history.active,
    past_history.operation,
    past_history.cause_of_death,
    past_history.confidential,
    past_history.major,
    past_history.deleted,
    past_history.year_onset_uncertain,
    past_history.condition_summary,
    past_history.aim_of_plan,
    past_history.plan_contribution_gp,
    past_history.plan_contribution_patient,
    past_history.health_need,
    past_history.plan_contribution_others,
    past_history.risk_factor,
    past_history.fk_coding_system,
    past_history.fk_code,
    past_history.fk_progressnote,
    lu_systems.system,
    generic_terms.term,
    ((generic_terms.term || ' ('::text) || generic_terms.code) || ')'::text AS combined_term_code,
    generic_terms.active AS code_active,
    consult.pk AS fk_consult,
    consult.fk_staff,
    consult.consult_date AS date_noted,
    data_persons.firstname AS staff_firstname,
    data_persons.surname AS staff_surname,
    lu_title.title AS staff_title
   FROM clin_history.past_history
     JOIN clin_consult.consult ON past_history.fk_consult = consult.pk
     LEFT JOIN common.lu_laterality ON past_history.fk_laterality = lu_laterality.pk
     LEFT JOIN coding.lu_systems ON past_history.fk_coding_system = lu_systems.pk
     LEFT JOIN coding.generic_terms ON past_history.fk_code = generic_terms.code
     JOIN admin.staff ON consult.fk_staff = staff.pk
    JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  --WHERE past_history.deleted = false
  ORDER BY consult.fk_patient;

ALTER TABLE clin_history.vwhealthissues   OWNER TO EASYGP;
GRANT SELECT ON TABLE clin_history.vwhealthissues TO staff;

update db.lu_version set lu_minor = 445;