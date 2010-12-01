DROP VIEW clin_recalls.vwrecallsdue;

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.fk_status, recalls.additional_text, recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_audit, recalls.fk_progressnote, recalls.fk_pasthistory, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age, vwpatients.sex, vwpatients.title, vwpatients.street, vwpatients.town, vwpatients.state, vwpatients.postcode, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, lu_status.status, consult.consult_date
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   JOIN clin_recalls.lu_status ON recalls.fk_status = lu_status.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;
