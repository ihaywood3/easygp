alter table  clin_consult.progressnotes add column deleted boolean default false;
comment on column clin_consult.progressnotes.deleted is
'if True then the record is marked as deleted. An audit trail will have been inserted';

Drop view clin_consult.vwProgressNotes cascade;
-- cascades to:
-- chronic_disease_management.vwdiabetescycleofcare
-- clin_consult.vwpatientconsults

CREATE OR REPLACE VIEW clin_consult.vwprogressnotes AS 
 SELECT "CONSULT".fk_patient, progressnotes.pk AS pk_progressnote, "CONSULT".consult_date, "CONSULT_TYPE".type AS consult_type, 
 "SECTION".section, progressnotes.problem, progressnotes.notes, "CONSULT".summary, progressnotes.fk_consult, 
 progressnotes.fk_section, progressnotes.fk_code, progressnotes.fk_problem, progressnotes.fk_audit_action, progressnotes.deleted,
 "CONSULT".fk_staff, "CONSULT".fk_type, data_persons.firstname, data_persons.surname, lu_title.title, 
 lu_audit_actions.action AS audit_action, progressnotes.linked_table, progressnotes.fk_audit_reason, 
 lu_audit_reasons.reason AS audit_reason, progressnotes.fk_row, lu_audit_actions.insist_reason, lu_staff_roles.role
   FROM clin_consult.consult "CONSULT"
   LEFT JOIN clin_consult.lu_consult_type "CONSULT_TYPE" ON "CONSULT".fk_type = "CONSULT_TYPE".pk
   JOIN admin.staff ON "CONSULT".fk_staff = staff.pk
   JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN clin_consult.progressnotes ON "CONSULT".pk = progressnotes.fk_consult
   JOIN clin_consult.lu_progressnotes_sections "SECTION" ON progressnotes.fk_section = "SECTION".pk
   JOIN clin_consult.lu_audit_actions ON progressnotes.fk_audit_action = lu_audit_actions.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   LEFT JOIN clin_consult.lu_audit_reasons ON progressnotes.fk_audit_reason = lu_audit_reasons.pk
  WHERE "CONSULT_TYPE".pk <> 8
  ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, progressnotes.fk_problem;

ALTER TABLE clin_consult.vwprogressnotes OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotes TO easygp;
GRANT SELECT ON TABLE clin_consult.vwprogressnotes TO staff;


CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view, vwprogressnotes.fk_patient, vwprogressnotes.consult_date,
 vwprogressnotes.consult_type, vwprogressnotes.fk_staff, vwprogressnotes.title AS staff_title,
 vwprogressnotes.surname AS staff_surname, vwprogressnotes.firstname AS staff_firstname,
 vwprogressnotes.linked_table, vwprogressnotes.fk_type, vwpatients.wholename, vwpatients.firstname,
 vwpatients.surname, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state,
 vwpatients.postcode, vwpatients.deceased, vwpatients.sex, vwpatients.title, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.age_display
   FROM clin_consult.vwprogressnotes, contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;


CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetescycleofcare AS 
 SELECT (diabetes_annual_cycle_of_care.pk || '-'::text) || COALESCE(diabetes_annual_cycle_of_care_notes.pk, 0)::text AS pk_view,
 diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care, consult.consult_date,
 consult.fk_patient, consult.fk_staff AS fk_staff_started, diabetes_annual_cycle_of_care.date_completed,
 diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.hba1c_date, diabetes_annual_cycle_of_care.hba1c_date_due,
 diabetes_annual_cycle_of_care.hba1c_details, diabetes_annual_cycle_of_care.eyes_date,
 diabetes_annual_cycle_of_care.eyes_date_due, diabetes_annual_cycle_of_care.eyes_details,
 diabetes_annual_cycle_of_care.bp_date, diabetes_annual_cycle_of_care.bp_date_due,
 diabetes_annual_cycle_of_care.bp_details, diabetes_annual_cycle_of_care.bmi_date,
 diabetes_annual_cycle_of_care.bmi_date_due, diabetes_annual_cycle_of_care.bmi_details,
 diabetes_annual_cycle_of_care.feet_date, diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details, diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, diabetes_annual_cycle_of_care.lipids_details, diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due, diabetes_annual_cycle_of_care.microalbumin_details, diabetes_annual_cycle_of_care.renalfunction_date, diabetes_annual_cycle_of_care.renalfunction_date_due, diabetes_annual_cycle_of_care.renalfunction_details, diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted, diabetes_annual_cycle_of_care.fk_progressnote_components, diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments, vwprogressnotes.consult_date AS date_progress_note_comment, vwstaff.title AS staff_made_comment_title, vwstaff.wholename AS staff_made_comment_wholename, vwstaff1.title AS staff_started_title, vwstaff1.wholename AS staff_started_wholename, progressnotes.notes AS component_notes, vwprogressnotes.notes AS comments_notes
   FROM chronic_disease_management.diabetes_annual_cycle_of_care
   JOIN clin_consult.consult ON diabetes_annual_cycle_of_care.fk_consult = consult.pk
   LEFT JOIN chronic_disease_management.diabetes_annual_cycle_of_care_notes ON diabetes_annual_cycle_of_care.pk = diabetes_annual_cycle_of_care_notes.fk_diabetes_annual_cycle_of_care
   LEFT JOIN clin_consult.vwprogressnotes ON diabetes_annual_cycle_of_care_notes.fk_progressnote = vwprogressnotes.pk_progressnote
   LEFT JOIN admin.vwstaff ON vwprogressnotes.fk_staff = vwstaff.fk_staff
   JOIN clin_consult.progressnotes ON diabetes_annual_cycle_of_care.fk_progressnote_components = progressnotes.pk
   JOIN admin.vwstaff vwstaff1 ON consult.fk_staff = vwstaff1.pk
  ORDER BY consult.fk_patient, diabetes_annual_cycle_of_care.pk, diabetes_annual_cycle_of_care_notes.pk;

ALTER TABLE chronic_disease_management.vwdiabetescycleofcare OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetescycleofcare TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetescycleofcare TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 101);


