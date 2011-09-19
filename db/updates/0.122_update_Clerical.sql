
Create or replace view clerical.vwAppointments as
SELECT 
  clerical.bookings.pk,
  clerical.bookings.fk_patient,
  clerical.bookings.fk_staff,
  clerical.bookings.begin,
  clerical.bookings.duration,
  clerical.bookings.notes,
  clerical.bookings.fk_staff_booked,
  clerical.bookings.fk_clinic,
  clerical.bookings.deleted,
  admin.vwstaffinclinics.wholename AS staff_booked_wholename,
  admin.vwstaffinclinics.title AS staff_booked_title,
  vwPatients.fk_address, 
  vwPatients.fk_person, vwPatients.wholename, 
  vwPatients.firstname, vwPatients.surname, vwPatients.salutation, vwPatients.birthdate, vwPatients.age_display,  vwPatients.age_numeric,
  vwPatients.language_problems, vwPatients.marital, vwPatients.sex, vwPatients.title, vwPatients.country, vwPatients.language, vwPatients.ethnicity, vwPatients.occupation, 
vwPatients.street1, vwPatients.street2, vwPatients.town, vwPatients.state, vwPatients.postcode, vwPatients.fk_town,
 vwPatients.address_type, vwPatients.fk_lu_address_type, vwPatients.preferred_address, vwPatients.postal_address, vwPatients.head_office, vwPatients.geolocation, 
vwPatients.country_code, vwPatients.address_deleted, vwPatients.fk_ethnicity, vwPatients.fk_language, vwPatients.memo, 
vwPatients.fk_marital, vwPatients.fk_title, vwPatients.fk_sex, vwPatients.fk_occupation, vwPatients.retired, 
vwPatients.deceased, vwPatients.date_deceased, vwPatients.fk_doctor, vwPatients.fk_next_of_kin, vwPatients.fk_payer, 
vwPatients.fk_family, vwPatients.active_status, vwPatients.medicare_number, vwPatients.medicare_ref_number, vwPatients.medicare_expiry_date,
 vwPatients.veteran_number, vwPatients.veteran_card_type, vwPatients.veteran_specific_condition, vwPatients.concession_card_name, 
vwPatients.concession_type, vwPatients.concession_number, vwPatients.concession_expiry_date, vwPatients.file_paper_number, 
vwPatients.atsi, vwPatients.file_racgp_format, vwPatients.file_chart_status, vwPatients.private_billing_concession, 
vwPatients.private_insurance, vwPatients.patient_memo, vwPatients.fk_image, vwPatients.image
FROM
  clerical.bookings
  INNER JOIN admin.vwstaffinclinics ON (clerical.bookings.fk_staff_booked = admin.vwstaffinclinics.fk_staff)
  LEFT OUTER JOIN contacts.vwpatients ON (clerical.bookings.fk_patient = contacts.vwpatients.fk_patient)
  order by begin;

  ALTER TABLE clerical.vwAppointments OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwAppointments TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 122);

