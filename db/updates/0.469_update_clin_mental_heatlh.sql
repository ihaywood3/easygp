-- dropped the fk_pasthistry as never used
alter table clin_mentalhealth.mentalhealth_plan drop column fk_pasthistory cascade;


CREATE OR REPLACE VIEW clin_mentalhealth.vwmentalhealthplans AS 
 SELECT mentalhealth_plan.pk AS pk_mentalhealth_plan,
    consult.fk_patient,
    consult.fk_staff,
    consult.consult_date AS plan_date,
    mentalhealth_plan.fk_consult,
    mentalhealth_plan.diagnosis,
    mentalhealth_plan.fk_coding_system,
    mentalhealth_plan.fk_progressnote,
    lu_systems.system,
    ( SELECT DISTINCT generic_terms.term
           FROM coding.generic_terms
          WHERE mentalhealth_plan.fk_code = generic_terms.code) AS coded_term,
    mentalhealth_plan.fk_code,
    mentalhealth_plan.presenting_problems,
    mentalhealth_plan.bio_psycho_social,
    mentalhealth_plan.mental_state_examination,
    mentalhealth_plan.fk_lu_risk_to_others,
    lu_risk_to_others.risk,
    mentalhealth_plan.relapse_plan,
    mentalhealth_plan.risk_harm_comments,
    mentalhealth_plan.goals,
    mentalhealth_plan.treatment_referrrals,
    mentalhealth_plan.review_date,
    mentalhealth_plan.html,
    mentalhealth_plan.fk_lu_plan_type,
    lu_plan_type.type,
    mentalhealth_plan.deleted,
    vwstaff.wholename,
    vwstaff.title
   FROM clin_mentalhealth.mentalhealth_plan
     JOIN clin_consult.consult ON mentalhealth_plan.fk_consult = consult.pk
     JOIN clin_mentalhealth.lu_plan_type ON mentalhealth_plan.fk_lu_plan_type = lu_plan_type.pk
     JOIN coding.lu_systems ON mentalhealth_plan.fk_coding_system = lu_systems.pk
     LEFT JOIN clin_mentalhealth.lu_risk_to_others ON mentalhealth_plan.fk_lu_risk_to_others = lu_risk_to_others.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
  WHERE NOT mentalhealth_plan.deleted;

ALTER TABLE clin_mentalhealth.vwmentalhealthplans   OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwmentalhealthplans TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwmentalhealthplans TO staff;

update db.lu_version set lu_minor = 469;