
-- give each template a default appointment length. this will over-ride a recalls appointment length
ALTER TABLE clin_recalls.lu_templates ADD COLUMN fk_appointment_length integer default 1;
COMMENT ON COLUMN clin_recalls.lu_templates.fk_lu_appointment_length IS 
'key to common.lu_appointment_length, A Template for a recall must always have a default appointment length here a standard consult length=1';

-- new view for templates to include common.lu_appointment_length.length.
create or replace view clin_recalls.vwTemplates as 
select lu_templates.*, lu_appointment_length.length as appointment_length 
from clin_recalls.lu_templates 
JOIN common.lu_appointment_length ON lu_templates.fk_lu_appointment_length = lu_appointment_length.pk 
where clin_recalls.lu_templates.template<> '';

ALTER TABLE clin_recalls.vwTemplates OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwTemplates TO easygp;
GRANT ALL ON TABLE clin_recalls.vwTemplates TO staff;

-- Cascades to clin_history.vwcareplancomponents

DROP VIEW clin_recalls.vwrecalls cascade;

CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, 
 lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, 
 (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
 recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, 
 recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls."interval", 
 lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, 
 recalls.fk_progressnote, recalls.fk_template, data_persons.firstname, data_persons.surname, data_persons.fk_title, 
 lu_contact_type.pk AS fk_contact_by, lu_recall_intervals."interval" AS default_interval, 
 lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit, 
 lu_templates.name AS template_name, lu_templates.template, 
 lu_templates.fk_lu_appointment_length as template_fk_lu_appointment_length, lu_appointment_length1.length as template_appointment_length
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
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   JOIN common.lu_appointment_length as lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
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


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 146);

