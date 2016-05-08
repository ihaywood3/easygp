-- View: clerical.vwappointmentsnotbilled

 -- DROP VIEW clerical.vwappointmentsnotbilled;

CREATE OR REPLACE VIEW clerical.vwappointmentsnotbilled AS 
 SELECT bookings.begin AS appointment_date,
    (data_persons.firstname || ' '::text) || data_persons.surname AS patient_wholename,
    bookings.fk_staff AS fk_staff_provided_service,
    bookings.fk_patient,
    clinics.fk_branch,
    bookings.begin AS visit_date,
    bookings.pk AS pk_appointment,
    vwstaff.firstname AS staff_firstname,
    vwstaff.surname AS staff_surname,
    bookings.comment_for_billing,
    bookings.fk_lu_reason_not_billed,
    bookings.fk_lu_appointment_status,
    lu_appointment_status.status,
    lu_reasons_not_billed.reason AS reason_not_billed
   FROM clerical.bookings
     LEFT JOIN clerical.data_patients ON data_patients.pk = bookings.fk_patient
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     JOIN admin.clinics ON clinics.pk = bookings.fk_clinic
     JOIN admin.vwstaff ON bookings.fk_staff = vwstaff.fk_staff
     LEFT JOIN billing.lu_reasons_not_billed ON lu_reasons_not_billed.pk = bookings.fk_lu_reason_not_billed
     LEFT JOIN clerical.lu_appointment_status ON lu_appointment_status.pk = bookings.fk_lu_appointment_status
  WHERE bookings.invoiced = false AND bookings.fk_patient IS NOT NULL and bookings.deleted is False;

ALTER TABLE clerical.vwappointmentsnotbilled  OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointmentsnotbilled TO easygp;
GRANT SELECT ON TABLE clerical.vwappointmentsnotbilled TO staff;
  
  update db.lu_version set lu_minor = 500;
