-- to enable the actual letter sent out for a recall to be reproduced save the LaTex definition
COMMENT ON COLUMN clin_recalls.sent.reminder_text IS 'the latex definition of the recall reminder sent';
ALTER TABLE "clin_recalls"."sent"
  RENAME COLUMN "reminder_text" TO "latex";
ALTER TABLE clin_recalls.sent DROP COLUMN fk_address;
-- to link to last date a recall reminder was sent
 alter table clin_recalls.recalls add column fk_sent integer default null;
 comment on column clin_recalls.recalls.fk_sent is
 'key to clin_recalls.sent table - gives info about when the last reminder was sent, who sent it
  the actual letter latex definition and how sent';
 alter table clin_recalls.recalls add column num_reminders integer default 0;
 comment on column clin_recalls.recalls.num_reminders is 
 'the number of times the practice has attempted to deal with this reminder';

-- give each template a default appointment length. this will over-ride a recalls appointment length
ALTER TABLE clin_recalls.lu_templates ADD COLUMN fk_lu_appointment_length integer default 1;
COMMENT ON COLUMN clin_recalls.lu_templates.fk_lu_appointment_length IS 
'key to common.lu_appointment_length, A Template for a recall must always have a default appointment length here a standard consult length=1';

-- new view for templates to include common.lu_appointment_length.length.

CREATE OR REPLACE VIEW clin_recalls.vwtemplates AS 
 SELECT lu_templates.pk, lu_templates.name, lu_templates.deleted, lu_templates.template, lu_templates.fk_lu_appointment_length, lu_appointment_length.length
   FROM clin_recalls.lu_templates, common.lu_appointment_length
  WHERE lu_templates.fk_lu_appointment_length = lu_appointment_length.pk AND lu_templates.template <> ''::text;

ALTER TABLE clin_recalls.vwtemplates OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwtemplates TO easygp;
GRANT ALL ON TABLE clin_recalls.vwtemplates TO staff;


-- Cascades to clin_history.vwcareplancomponents

DROP VIEW clin_recalls.vwrecalls cascade;

CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, 
 lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, 
 (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
 recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, 
 recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls."interval", 
 lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, 
 recalls.fk_progressnote, recalls.fk_template, 
 recalls.fk_sent, recalls.num_reminders,
 data_persons.firstname, data_persons.surname, data_persons.fk_title, 
 lu_contact_type.pk AS fk_contact_by, lu_recall_intervals."interval" AS default_interval, 
 lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit, 
 lu_templates.name AS template_name, lu_templates.template, 
 lu_templates.fk_lu_appointment_length as template_fk_lu_appointment_length, lu_appointment_length1.length as template_appointment_length,
 sent.latex
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
   left JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   left JOIN common.lu_appointment_length as lu_appointment_length1 ON clin_recalls.lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.sent on clin_recalls.recalls.fk_sent = sent.pk
  ORDER BY consult.fk_patient, recalls.due;

ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;

CREATE OR REPLACE VIEW clin_history.vwcareplancomponents AS 
 SELECT care_plan_components.fk_pasthistory, care_plan_components.component, care_plan_components.pk AS pk_careplan_components, 
 care_plan_components.due, care_plan_components.fk_recall, vwrecalls.fk_staff, vwrecalls."interval", 
 vwrecalls.reason, vwrecalls.fk_reason, vwrecalls.fk_interval_unit, vwrecalls.default_interval, 
 vwrecalls.fk_default_interval_unit, vwrecalls.fk_contact_by, vwrecalls.abbrev_text
   FROM clin_history.care_plan_components
   LEFT JOIN clin_recalls.vwrecalls ON care_plan_components.fk_recall = vwrecalls.pk_recall
  ORDER BY care_plan_components.fk_pasthistory, care_plan_components.due;

ALTER TABLE clin_history.vwcareplancomponents OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO staff;

drop view clin_recalls.vwRecallsDue;
CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
SELECT 
  clin_recalls.recalls.pk AS pk_recall,
  clin_recalls.recalls.fk_consult,
  clin_recalls.recalls.due,
  (recalls.due - date(now())) AS days_due,
  clin_recalls.recalls.fk_reason,
  clin_recalls.recalls.fk_contact_method,
  clin_recalls.recalls.fk_urgency,
  clin_recalls.recalls.fk_appointment_length,
  clin_recalls.recalls.fk_staff,
  clin_recalls.recalls.active,
  clin_recalls.recalls.additional_text,
  clin_recalls.recalls.deleted,
  clin_recalls.recalls.interval,
  clin_recalls.recalls.fk_interval_unit,
  clin_recalls.recalls.fk_progressnote,
  clin_recalls.recalls.fk_pasthistory,
  clin_recalls.recalls.fk_sent,
  clin_recalls.recalls.num_reminders,
  sent.latex, sent.date as date_reminder_sent,
  contacts.vwpatients.fk_person,
  contacts.vwpatients.wholename,
  contacts.vwpatients.firstname,
  contacts.vwpatients.surname,
  contacts.vwpatients.salutation,
  contacts.vwpatients.birthdate,
  contacts.vwpatients.age_numeric,
  contacts.vwpatients.sex,
  contacts.vwpatients.title,
  contacts.vwpatients.street1,
  contacts.vwpatients.street2,
  contacts.vwpatients.town,
  contacts.vwpatients.state,
  contacts.vwpatients.postcode,
  contacts.vwpatients.language_problems,
  contacts.vwpatients.language,
  clin_consult.consult.fk_patient,
  admin.vwstaff.firstname AS staff_to_see_firstname,
  admin.vwstaff.surname AS staff_to_see_surname,
  admin.vwstaff.wholename AS staff_to_see_wholename,
  admin.vwstaff.title AS staff_to_see_title,
  clin_recalls.lu_reasons.reason,
  common.lu_urgency.urgency,
  contacts.lu_contact_type.type AS contact_method,
  common.lu_appointment_length.length AS appointment_length,
  clin_consult.consult.consult_date,
  clin_recalls.recalls.fk_template,
  lu_appointment_length1.length,
  clin_recalls.lu_templates.name,
  clin_recalls.lu_templates.template
FROM
  clin_recalls.recalls
  INNER JOIN clin_consult.consult ON (clin_recalls.recalls.fk_consult = clin_consult.consult.pk)
  INNER JOIN contacts.vwpatients ON (clin_consult.consult.fk_patient = contacts.vwpatients.fk_patient)
  INNER JOIN admin.vwstaff ON (clin_recalls.recalls.fk_staff = admin.vwstaff.fk_staff)
  INNER JOIN clin_recalls.lu_reasons ON (clin_recalls.recalls.fk_reason = clin_recalls.lu_reasons.pk)
  INNER JOIN common.lu_urgency ON (clin_recalls.recalls.fk_urgency = common.lu_urgency.pk)
  INNER JOIN contacts.lu_contact_type ON (clin_recalls.recalls.fk_contact_method = contacts.lu_contact_type.pk)
  INNER JOIN common.lu_appointment_length ON (clin_recalls.recalls.fk_appointment_length = common.lu_appointment_length.pk)
  LEFT OUTER JOIN clin_recalls.lu_templates ON (clin_recalls.recalls.fk_template = clin_recalls.lu_templates.pk)
  LEFT OUTER JOIN common.lu_appointment_length lu_appointment_length1 ON (clin_recalls.lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk)
   LEFT JOIN clin_recalls.sent on (clin_recalls.recalls.fk_sent = sent.pk)
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

  ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 146);
