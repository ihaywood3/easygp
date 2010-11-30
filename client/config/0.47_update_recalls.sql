Create or replace view clin_recalls.vwRecallsDue as
SELECT 
  clin_recalls.recalls.pk AS pk_recall,
  clin_recalls.recalls.fk_consult,
  clin_recalls.recalls.due,
  clin_recalls.recalls.fk_reason,
  clin_recalls.recalls.fk_contact_method,
  clin_recalls.recalls.fk_urgency,
  clin_recalls.recalls.fk_appointment_length,
  clin_recalls.recalls.fk_staff,
  clin_recalls.recalls.fk_status,
  clin_recalls.recalls.additional_text,
  clin_recalls.recalls.deleted,
  clin_recalls.recalls.interval,
  clin_recalls.recalls.fk_interval_unit,
  clin_recalls.recalls.fk_audit,
  clin_recalls.recalls.fk_progressnote,
  clin_recalls.recalls.fk_pasthistory,
  contacts.vwpatients.fk_person,
  contacts.vwpatients.wholename,
  contacts.vwpatients.firstname,
  contacts.vwpatients.surname,
  contacts.vwpatients.salutation,
  contacts.vwpatients.birthdate,
  contacts.vwpatients."age",
  contacts.vwpatients.sex,
  contacts.vwpatients.title,
  contacts.vwpatients.street,
  contacts.vwpatients.town,
  contacts.vwpatients.state,
  contacts.vwpatients.postcode,
  clin_consult.consult.fk_patient,
  admin.vwstaff.firstname AS staff_to_see_firstname,
  admin.vwstaff.surname AS staff_to_see_surname,
  admin.vwstaff.wholename AS staff_to_see_wholename,
  admin.vwstaff.title AS staff_to_see_title,
  clin_recalls.lu_reasons.reason,
  common.lu_urgency.urgency,
  contacts.lu_contact_type.type AS contact_method,
  common.lu_appointment_length.length AS appointment_length,
  clin_recalls.lu_status.status,
  clin_consult.consult.consult_date
FROM
  clin_recalls.recalls
  INNER JOIN clin_consult.consult ON (clin_recalls.recalls.fk_consult = clin_consult.consult.pk)
  INNER JOIN contacts.vwpatients ON (clin_consult.consult.fk_patient = contacts.vwpatients.fk_patient)
  INNER JOIN admin.vwstaff ON (clin_recalls.recalls.fk_staff = admin.vwstaff.fk_staff)
  INNER JOIN clin_recalls.lu_reasons ON (clin_recalls.recalls.fk_reason = clin_recalls.lu_reasons.pk)
  INNER JOIN common.lu_urgency ON (clin_recalls.recalls.fk_urgency = common.lu_urgency.pk)
  INNER JOIN contacts.lu_contact_type ON (clin_recalls.recalls.fk_contact_method = contacts.lu_contact_type.pk)
  INNER JOIN common.lu_appointment_length ON (clin_recalls.recalls.fk_appointment_length = common.lu_appointment_length.pk)
  INNER JOIN clin_recalls.lu_status ON (clin_recalls.recalls.fk_status = clin_recalls.lu_status.pk)
 where
   recalls.deleted = False
 order by recalls.due, fk_patient;
 
ALTER TABLE clin_recalls.vwRecallsDue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwRecallsDue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwRecallsDue TO staff;

 CREATE INDEX date_recall_due_idx
  ON clin_recalls.recalls
  USING btree
  (due);

 truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 47);