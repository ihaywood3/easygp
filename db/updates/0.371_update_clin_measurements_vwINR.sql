Oops forgot the version number and the file to svn!!!!!

-- View: clin_measurements.vwinrplans

DROP VIEW clin_measurements.vwinrplans;

CREATE OR REPLACE VIEW clin_measurements.vwinrplans AS 
 SELECT consult.fk_patient, consult.fk_staff, inr_plan.pk, inr_plan.fk_lu_reason_anticoagulant_use, 
 lu_reason_anticoagulant_use.reason, lu_reason_anticoagulant_use.fk_code, inr_plan.fk_progressnote, 
 inr_plan.inr_target_range, inr_plan.comment, inr_plan.use_lab_hl7, inr_plan.date_plan_created,
  inr_plan.fk_consult, consult.consult_date, consult1.consult_date AS progress_note_date, generic_terms.term
   FROM clin_consult.consult, clin_measurements.inr_plan, clin_consult.consult consult1,
    clin_consult.progressnotes, clin_measurements.lu_reason_anticoagulant_use, coding.generic_terms
  WHERE 
  inr_plan.fk_consult = consult.pk AND inr_plan.fk_progressnote = progressnotes.pk 
  AND inr_plan.fk_lu_reason_anticoagulant_use = lu_reason_anticoagulant_use.pk 
  AND progressnotes.fk_consult = consult1.pk
  AND lu_reason_anticoagulant_use.fk_code = generic_terms.code  ;

ALTER TABLE clin_measurements.vwinrplans  OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwinrplans TO easygp;
GRANT SELECT ON TABLE clin_measurements.vwinrplans TO staff;

update db.lu_version set lu_minor=371;

