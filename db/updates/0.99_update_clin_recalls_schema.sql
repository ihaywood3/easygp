-- more changes to recalls as I move towards production use.
-- User now selects a template to accompany the letter from within the editing area
-- additional text still addable below that.

SET search_path = clin_recalls, pg_catalog;

alter Table clin_recalls.lu_templates alter column deleted set default false;

alter table clin_recalls.links_forms rename column fk_recalls to fk_recall;

delete from lu_templates;

SELECT pg_catalog.setval('lu_templates_pk_seq', 2, true);

Alter table  clin_recalls.recalls add column fk_template integer default null;

comment on column clin_recalls.recalls.fk_template is
'If not null, then the template text will be included in the patients recalls';


INSERT INTO lu_templates (pk, name, deleted, template) VALUES (1, 'Do not use template', false, '');
INSERT INTO lu_templates (pk, name, deleted, template) VALUES (2, 'Annual Checkup', false, '<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:7pt;font-family:Helvetica">
<p align="center"><span style="font-weight:600;text-decoration:underline">Annual Checkup </span></p>
<p>The annual checkup is one of the most important facets of your medical care. When you ring for an appointment you should request a long consultation.</p>
<p>On the morning of your checkup, you should do one or more of the following, unless your doctor has given you specific instructions which contradict this:</P>
<ul type="disc">
<li>If you are<span style="font-weight:600"> not a known diabetic</span> you should fast overnight, and drink plenty of water in the morning</li>
<li>If you have diabetes you may eat breakfast and drink fluids as per normal</li>
<li>Take your medications as usual in the morning.</li></ul>
<p>Have a think about any health issues you wish to discuss prior to the consultation, and attend the surgery at least 10 minutes prior to your consulation 
to allow time to check in with the secretary and provide a urine specimen.</p>
</body></html>
');

DROP VIEW clin_recalls.vwrecalls;

CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, lu_contact_type.type AS contact_by, 
 lu_appointment_length.length, lu_title.title, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, recalls.fk_consult,
 recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, 
 recalls.active, recalls."interval", lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, 
 recalls.fk_pasthistory, recalls.fk_progressnote, recalls.fk_template,
 data_persons.firstname, data_persons.surname, 
 data_persons.fk_title, lu_contact_type.pk AS fk_contact_by, lu_recall_intervals."interval" AS default_interval, 
 lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit, lu_templates.name as template_name, lu_templates.template
   FROM clin_recalls.recalls
   JOIN clin_recalls.lu_recall_intervals ON recalls.fk_reason = lu_recall_intervals.fk_reason
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   LEFT JOIN clin_recalls.lu_templates on recalls.fk_template = lu_templates.pk
   LEFT JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
  ORDER BY consult.fk_patient, recalls.due;

ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 99);

