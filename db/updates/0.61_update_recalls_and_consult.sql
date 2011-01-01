
ALTER TABLE clin_consult.lu_audit_actions OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.lu_audit_actions TO easygp;
GRANT SELECT ON TABLE clin_consult.lu_audit_actions TO staff;

ALTER TABLE clin_consult.lu_audit_reasons OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.lu_audit_reasons TO easygp;
GRANT SELECT, INSERT ON TABLE clin_consult.lu_audit_reasons TO staff;

drop table clin_recalls.lu_status;

alter table clin_recalls.recalls rename column fk_status to fk_lu_audit_action;

COMMENT ON COLUMN clin_recalls.recalls.fk_lu_audit_action IS 
'key to clin_consult.lu_audit_action table, ie things like not due, finalised, refused
     corresponds to e.g gvar.RecallNotDue constants
     this defaults to 1 = not due';


alter  Table clin_recalls.recalls drop column fk_audit cascade;
-- cascades to clin_recalls.vwRecallsdue

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, 
 recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, 
 recalls.fk_staff, recalls.fk_lu_audit_action, recalls.additional_text, recalls.deleted, recalls."interval", 
 recalls.fk_interval_unit, recalls.fk_progressnote, recalls.fk_pasthistory, vwpatients.fk_person, 
 vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, 
 vwpatients.age, vwpatients.sex, vwpatients.title, vwpatients.street, vwpatients.town, vwpatients.state, vwpatients.postcode, 
 vwpatients.language_problems, vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, 
 vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, 
 lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, lu_audit_actions.action, consult.consult_date
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   JOIN clin_consult.lu_audit_actions ON recalls.fk_lu_audit_action =  lu_audit_actions.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

DROP VIEW clin_recalls.vwrecalls;

CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, 
 lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, 
 (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
 recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, 
 recalls.fk_appointment_length, recalls.fk_staff, recalls.fk_lu_audit_action AS fk_status, recalls."interval", 
 lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, 
 recalls.fk_progressnote, data_persons.firstname, data_persons.surname, data_persons.fk_title, 
 lu_contact_type.pk AS fk_contact_by, lu_audit_actions.action as status, lu_recall_intervals."interval" AS default_interval, 
 lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit
   FROM clin_recalls.recalls
   JOIN clin_recalls.lu_recall_intervals ON recalls.fk_reason = lu_recall_intervals.fk_reason
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   LEFT JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
ORDER BY consult.fk_patient, recalls.due;

ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;



DROP VIEW clin_consult.vwprogressnotes;

CREATE OR REPLACE VIEW clin_consult.vwprogressnotes AS 
 SELECT "CONSULT".fk_patient, progressnotes.pk AS pk_progressnote, "CONSULT".consult_date, "CONSULT_TYPE".type AS consult_type, "SECTION".section, 
 progressnotes.problem, progressnotes.notes, "CONSULT".summary, progressnotes.fk_consult, progressnotes.fk_section, 
 progressnotes.fk_code, progressnotes.fk_problem, progressnotes.fk_audit_action, "CONSULT".fk_staff, "CONSULT".fk_type, 
 data_persons.firstname, data_persons.surname, lu_title.title, lu_audit_actions.action AS audit_action, 
 progressnotes.linked_table, progressnotes.fk_audit_reason, lu_audit_reasons.reason as audit_reason,
 progressnotes.fk_row, lu_audit_actions.insist_reason, 
 lu_staff_roles.role
   FROM clin_consult.consult "CONSULT"
   LEFT JOIN clin_consult.lu_consult_type "CONSULT_TYPE" ON "CONSULT".fk_type = "CONSULT_TYPE".pk
   JOIN admin.staff ON "CONSULT".fk_staff = staff.pk
   JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN clin_consult.progressnotes ON "CONSULT".pk = progressnotes.fk_consult
   JOIN clin_consult.lu_progressnotes_sections "SECTION" ON progressnotes.fk_section = "SECTION".pk
   JOIN clin_consult.lu_audit_actions ON progressnotes.fk_audit_action = lu_audit_actions.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   Left Join clin_consult.lu_audit_reasons ON progressnotes.fk_audit_reason = lu_audit_reasons.pk
  WHERE "CONSULT_TYPE".pk <> 8
  ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, progressnotes.fk_problem;

ALTER TABLE clin_consult.vwprogressnotes OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotes TO easygp;
GRANT SELECT ON TABLE clin_consult.vwprogressnotes TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 61)
