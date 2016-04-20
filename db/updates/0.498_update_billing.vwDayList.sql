-- View: billing.vwdaylist

DROP VIEW billing.vwdaylist;

CREATE OR REPLACE VIEW billing.vwdaylist AS 
 SELECT (bookings.pk || '-'::text) || items_billed.pk AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    data_patients.fk_lu_centrelink_card_type,
    invoices.pk AS fk_invoice,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.latex,
    invoices.total_bill,
    invoices.total_gst,
    invoices.total_paid,
    invoices.fk_staff_provided_service,
    invoices.fk_lu_bulk_billing_type,
    invoices.notes,
    lu_bulk_billing_type.type AS bulk_billing_type,
    bookings.begin AS appointment_date,
    COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
    fee_schedule.descriptor_brief,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.pk AS fk_items_billed,
    payments_received.fk_lu_payment_method,
    payments_received.amount AS payment_amount,
    lu_billing_type.type AS billing_type,
    lu_payment_method.method AS payment_method,
    NULL::text AS reason_not_billed,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    clinics.fk_branch
   FROM clerical.bookings
     JOIN billing.invoices ON invoices.fk_appointment = bookings.pk
     JOIN admin.clinics ON bookings.fk_clinic = clinics.pk
     JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
     JOIN billing.items_billed ON invoices.pk = items_billed.fk_invoice
     JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
     JOIN billing.lu_billing_type ON items_billed.fk_lu_billing_type = lu_billing_type.pk
     LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
     LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN billing.payments_received ON invoices.pk = payments_received.fk_invoice
     LEFT JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
  WHERE bookings.fk_lu_reason_not_billed IS NULL
UNION
 SELECT (bookings.pk || '-'::text) || '0'::text AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    NULL::integer AS fk_lu_centrelink_card_type,
    NULL::integer AS fk_invoice,
    NULL::boolean AS paid,
    NULL::integer AS fk_payer_person,
    NULL::integer AS fk_payer_branch,
    NULL::text AS latex,
    NULL::money AS total_bill,
    NULL::money AS total_gst,
    NULL::money AS total_paid,
    bookings.fk_staff AS fk_staff_provided_service,
    NULL::integer AS fk_lu_bulk_billing_type,
    NULL::text as notes,
    NULL::text AS bulk_billing_type,
    bookings.begin AS appointment_date,
    NULL::text AS item,
    NULL::text AS descriptor_brief,
    NULL::money AS amount,
    NULL::money AS amount_gst,
    NULL::integer AS fk_items_billed,
    NULL::integer AS fk_lu_payment_method,
    NULL::money AS payment_amount,
    NULL::text AS billing_type,
    NULL::text AS payment_method,
    lu_reasons_not_billed.reason AS reason_not_billed,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    NULL::text AS account_to_name,
    clinics.fk_branch
   FROM clerical.bookings
     JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     JOIN admin.clinics ON bookings.fk_clinic = clinics.pk
     LEFT JOIN billing.lu_reasons_not_billed ON bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  WHERE bookings.fk_lu_reason_not_billed IS NOT NULL;

ALTER TABLE billing.vwdaylist   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwdaylist TO staff;

update db.lu_version set lu_minor = 498;

