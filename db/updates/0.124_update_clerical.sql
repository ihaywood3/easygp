alter TABLE clerical.bookings rename column fk_appointment_icon to fk_lu_appointment_icon;
DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, bookings.duration, 
 bookings.notes, bookings.fk_staff_booked, bookings.fk_clinic, bookings.fk_lu_appointment_icon,
 bookings.deleted, vwstaffinclinics.wholename AS staff_booked_wholename, vwstaffinclinics.title AS staff_booked_title, 
 vwpatients.fk_address, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, 
 vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age_display, 
 vwpatients.age_numeric, vwpatients.language_problems, vwpatients.marital, vwpatients.sex, 
 vwpatients.title, vwpatients.country, vwpatients.language, vwpatients.ethnicity, vwpatients.occupation, 
 vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, 
 vwpatients.fk_town, vwpatients.address_type, vwpatients.fk_lu_address_type, vwpatients.preferred_address, 
 vwpatients.postal_address, vwpatients.head_office, vwpatients.geolocation, vwpatients.country_code, 
 vwpatients.address_deleted, vwpatients.fk_ethnicity, vwpatients.fk_language, vwpatients.memo, 
 vwpatients.fk_marital, vwpatients.fk_title, vwpatients.fk_sex, vwpatients.fk_occupation, 
 vwpatients.retired, vwpatients.deceased, vwpatients.date_deceased, vwpatients.fk_doctor, 
 vwpatients.fk_next_of_kin, vwpatients.fk_payer, vwpatients.fk_family, vwpatients.active_status, 
 vwpatients.medicare_number, vwpatients.medicare_ref_number, vwpatients.medicare_expiry_date, 
 vwpatients.veteran_number, vwpatients.veteran_card_type, vwpatients.veteran_specific_condition, 
 vwpatients.concession_card_name, vwpatients.concession_type, vwpatients.concession_number, 
 vwpatients.concession_expiry_date, vwpatients.file_paper_number, vwpatients.atsi, 
 vwpatients.file_racgp_format, vwpatients.file_chart_status, vwpatients.private_billing_concession, 
 vwpatients.private_insurance, vwpatients.patient_memo, vwpatients.fk_image, vwpatients.image
   FROM clerical.bookings
   JOIN admin.vwstaffinclinics ON bookings.fk_staff_booked = vwstaffinclinics.fk_staff
   LEFT JOIN contacts.vwpatients ON bookings.fk_patient = vwpatients.fk_patient
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 124);

