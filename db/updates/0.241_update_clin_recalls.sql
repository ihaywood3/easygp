DROP VIEW clin_recalls.vwrecalls cascade;

CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, 
 lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, 
 (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, recalls.fk_consult, 
 recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, 
 recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls."interval", lu_units.abbrev_text, 
 recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, 
 recalls.fk_progressnote, recalls.fk_template, recalls.fk_sent, recalls.num_reminders, 
 data_persons.firstname, data_persons.surname, data_persons.fk_title, data_persons.deceased,
 lu_contact_type.pk AS fk_contact_by, lu_recall_intervals."interval" AS default_interval, 
 lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit, lu_templates.name AS template_name, 
 lu_templates.template, lu_templates.fk_lu_appointment_length AS template_fk_lu_appointment_length, 
 lu_appointment_length1.length AS template_appointment_length, sent.latex, data_patients.fk_lu_active_status
   FROM clin_recalls.recalls
   JOIN clin_recalls.lu_recall_intervals ON recalls.fk_reason = lu_recall_intervals.fk_reason
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
   LEFT JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   LEFT JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
   JOIN clerical.data_patients on consult.fk_patient =  data_patients.pk
  ORDER BY consult.fk_patient, recalls.due;

ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;

CREATE OR REPLACE VIEW clin_history.vwcareplancomponents AS 
 SELECT care_plan_components.fk_pasthistory, care_plan_components.component, care_plan_components.pk AS pk_careplan_components, 
 care_plan_components.due, care_plan_components.fk_recall, vwrecalls.fk_staff, vwrecalls."interval", vwrecalls.reason, 
 vwrecalls.fk_reason, vwrecalls.fk_interval_unit, vwrecalls.default_interval, 
 vwrecalls.fk_default_interval_unit, vwrecalls.fk_contact_by, vwrecalls.abbrev_text
   FROM clin_history.care_plan_components
   LEFT JOIN clin_recalls.vwrecalls ON care_plan_components.fk_recall = vwrecalls.pk_recall
  ORDER BY care_plan_components.fk_pasthistory, care_plan_components.due;

ALTER TABLE clin_history.vwcareplancomponents OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO staff;

DROP VIEW clin_recalls.vwrecallsdue;

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, 
 recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, 
 recalls.fk_staff, recalls.active, recalls.additional_text, recalls.deleted, recalls."interval", 
 recalls.fk_interval_unit, recalls.fk_progressnote, recalls.fk_pasthistory, recalls.fk_sent, 
 recalls.num_reminders, sent.latex, sent.date AS date_reminder_sent, lu_units.abbrev_text, 
 vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, 
 vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.sex, vwpatients.deceased,
 vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, 
 vwpatients.postcode, vwpatients.language_problems, vwpatients.language, consult.fk_patient, 
 vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, 
 vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, 
 lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, 
 lu_appointment_length.length AS appointment_length, consult.consult_date, recalls.fk_template, 
 lu_appointment_length1.length, lu_templates.name, lu_templates.template
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
   LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 241);


