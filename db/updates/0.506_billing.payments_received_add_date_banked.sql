-- adds a couple of fields to allow printing of a banking slip for cash/cheque payments
-- update the current data to cope with the new is_banked field, by definition EFT EFTPOS, medicare and veterans have been banked

alter table billing.payments_received add column date_banked timestamp without time zone default null;

comment on column billing.payments_received.date_banked is
'if not null, is the date this payment was banked - only applies to cash/cheques
 Used to print banking slip of those categories cash/cheques not banked since last banking slip';

DROP VIEW billing.vwdaysinvoicesandpayments;

CREATE OR REPLACE VIEW billing.vwdaysinvoicesandpayments AS 
 SELECT bookings.begin AS appointment_date,
    (data_persons.firstname || ' '::text) || data_persons.surname AS wholename,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    lu_title.title AS patient_title,
    COALESCE(data_organisations.organisation, (dp2.firstname || ' '::text) || dp2.surname) AS account_to_name,
    lu_bulk_billing_type.type AS bulk_billing_type,
    COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
    fee_schedule.descriptor_brief,
    items_billed.pk AS pk_items_billed,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.deleted AS item_deleted,
    invoices.pk AS fk_invoice,
    invoices.fk_staff_provided_service,
    invoices.fk_patient,
    invoices.date_invoiced,
    invoices.paid,
    invoices.notes,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.fk_branch,
    invoices.visit_date,
    invoices.fk_lu_bulk_billing_type,
    invoices.fk_appointment,
    invoices.total_bill,
    invoices.total_gst,
    invoices.total_paid,
    payments_received.fk_lu_payment_method,
    payments_received.date_paid,
    payments_received.date_banked,
    payments_received.referent,
    lu_payment_method.method AS payment_method,
    vwstaff.firstname AS staff_firstname,
    vwstaff.surname AS staff_surname
   FROM billing.invoices
     LEFT JOIN clerical.data_patients ON data_patients.pk = invoices.fk_patient
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN clerical.bookings ON bookings.pk = invoices.fk_appointment
     JOIN admin.vwstaff ON invoices.fk_staff_provided_service = vwstaff.fk_staff
     JOIN billing.items_billed ON items_billed.fk_invoice = invoices.pk
     LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
     LEFT JOIN contacts.data_branches ON data_branches.pk = invoices.fk_payer_branch
     LEFT JOIN contacts.data_organisations ON data_organisations.pk = data_branches.fk_organisation
     LEFT JOIN contacts.data_persons dp2 ON invoices.fk_payer_person = dp2.pk
     LEFT JOIN billing.payments_received ON invoices.pk = payments_received.fk_invoice
     LEFT JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
     JOIN billing.fee_schedule ON fee_schedule.pk = items_billed.fk_fee_schedule;

ALTER TABLE billing.vwdaysinvoicesandpayments   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwdaysinvoicesandpayments TO staff;

update db.lu_version set lu_minor = 505;-- 