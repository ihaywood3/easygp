-- added fk_person to allow loading contacts in FBillingPatientCards and its embedded FCommunicationData form
-- so that staff can modify patients contacts when using billing.

DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk,
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
    data_patients.fk_payer_person,
    data_patients.fk_payer_branch,
    data_patients.fk_doctor,
    data_patients.fk_lu_default_billing_level,
    data_patients.medicare_number,
    data_patients.medicare_ref_number,
    data_patients.medicare_expiry_date,
    lu_veteran_card_type.type AS veteran_card_type,
    data_patients.veteran_number,
    data_patients.veteran_specific_condition,
    data_patients.concession_card_number,
    data_patients.concession_card_expiry_date,
    data_patients.nursing_home_resident,
    lu_centrelink_card_type.type AS concession_card_type,
    lu_private_health_funds.fund,
    lu_default_billing_level.level AS billing_level,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    data_persons.pk as fk_person,
    lu_sex.sex,
    lu_title.title,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    age_display(age(data_persons.birthdate::timestamp with time zone)) AS age_display,
    date_part('year'::text, age(data_persons.birthdate::timestamp with time zone)) AS age_numeric,
    lu_reasons_not_billed.reason
   FROM clerical.bookings
     LEFT JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     LEFT JOIN clerical.lu_centrelink_card_type ON data_patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
     LEFT JOIN clerical.lu_private_health_funds ON data_patients.fk_lu_private_health_fund = lu_private_health_funds.pk
     LEFT JOIN clerical.lu_veteran_card_type ON data_patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
     LEFT JOIN billing.lu_default_billing_level ON data_patients.fk_lu_default_billing_level = lu_default_billing_level.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN billing.lu_reasons_not_billed ON bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;

update db.lu_version set lu_minor=398;
