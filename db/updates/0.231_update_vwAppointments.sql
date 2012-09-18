 DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, bookings.duration, 
 bookings.notes, bookings.fk_staff_booked, bookings.fk_clinic, bookings.fk_lu_appointment_icon, bookings.fk_lu_appointment_status, 
 bookings.deleted, data_patients.fk_person, data_patients.fk_doctor, data_patients.fk_lu_default_billing_level, 
 data_patients.medicare_number, data_patients.medicare_ref_number, data_patients.medicare_expiry_date, 
 lu_veteran_card_type.type as veteran_card_type, data_patients.veteran_number, data_patients.veteran_specific_condition,
 data_patients.concession_card_number, data_patients.concession_card_expiry_date,
 lu_centrelink_card_type.type as concession_card_type, lu_private_health_funds.fund,
 lu_default_billing_level.level AS billing_level, data_persons.firstname, data_persons.surname, 
 data_persons.birthdate, lu_sex.sex, lu_title.title, 
 ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
 bookings.invoiced, bookings.did_not_attend
   FROM clerical.bookings
   LEFT JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
   LEFT JOIN clerical.lu_centrelink_card_type ON data_patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
   LEFT JOIN clerical.lu_private_health_funds ON data_patients.fk_lu_private_health_fund  = lu_private_health_funds.pk
   LEFT JOIN clerical.lu_veteran_card_type  ON data_patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
   LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN billing.lu_default_billing_level ON data_patients.fk_lu_default_billing_level = lu_default_billing_level.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 231);


