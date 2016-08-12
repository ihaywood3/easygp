-- View: clerical.vwappointments

-- DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_staff,
    bookings.begin,
    bookings.duration,
    bookings.notes,
    bookings.fk_staff_booked,
    bookings.fk_clinic,
    bookings.fk_lu_appointment_icon,
    bookings.fk_lu_appointment_status,
    bookings.deleted,
    bookings.invoiced,
    bookings.did_not_attend,
    bookings.fk_lu_reason_not_billed,
    bookings.comment_for_billing,
    bookings.elapsed_consult_time,
    vwpatients.fk_payer_person,
    vwpatients.fk_payer_branch,
    vwpatients.fk_doctor,
    vwpatients.fk_lu_default_billing_level,
    vwpatients.medicare_number,
    vwpatients.medicare_ref_number,
    vwpatients.medicare_expiry_date,
    vwpatients.fk_branch_pharmacy,
    vwpatients.memo_for_pharmacy,
    lu_veteran_card_type.type AS veteran_card_type,
    vwpatients.veteran_number,
    vwpatients.veteran_specific_condition,
    vwpatients.concession_card_number,
    vwpatients.concession_card_expiry_date,
    vwpatients.nursing_home_resident,
    vwpatients.fk_image,
    vwpatients.image,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.postcode,
    lu_centrelink_card_type.type AS concession_card_type,
    lu_private_health_funds.fund,
    lu_default_billing_level.level AS billing_level,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    data_persons.pk AS fk_person,
    lu_sex.sex,
    lu_title.title,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    age_display(age(data_persons.birthdate::timestamp with time zone)) AS age_display,
    date_part('year'::text, age(data_persons.birthdate::timestamp with time zone)) AS age_numeric,
    lu_reasons_not_billed.reason,
    vwpatients.language,
    vwpatients.language_problems,
    vwpatients.appointment_memo
   FROM clerical.bookings
     LEFT JOIN contacts.vwpatients ON bookings.fk_patient = vwpatients.fk_patient
     LEFT JOIN clerical.lu_centrelink_card_type ON vwpatients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
     LEFT JOIN clerical.lu_private_health_funds ON vwpatients.fk_lu_private_health_fund = lu_private_health_funds.pk
     LEFT JOIN clerical.lu_veteran_card_type ON vwpatients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
     LEFT JOIN contacts.data_persons ON vwpatients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
     LEFT JOIN billing.lu_default_billing_level ON vwpatients.fk_lu_default_billing_level = lu_default_billing_level.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN billing.lu_reasons_not_billed ON bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments
  OWNER TO richard;
GRANT ALL ON TABLE clerical.vwappointments TO richard;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;
