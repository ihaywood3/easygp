-- drop view billing.vwDaysInvoicesAndPayments;

Create or replace View billing.vwDaysInvoicesAndPayments as
select
  bookings.begin AS appointment_date,
  data_persons.firstname || ' ' ::text || data_persons.surname as patient_wholename,
  COALESCE(data_organisations.organisation, DP2.firstname || ' '::text || DP2.surname) AS account_to_name,
  lu_bulk_billing_type.type as bulk_billing_type,
  COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
  fee_schedule.descriptor_brief,
  items_billed.pk as pk_items_billed,
  items_billed.amount,
  items_billed.amount_gst,
  billing.invoices.pk as fk_invoice,
  billing.invoices.fk_staff_provided_service,
  billing.invoices.fk_patient,
  billing.invoices.date_invoiced,
  billing.invoices.paid,
  billing.invoices.notes,
  billing.invoices.fk_payer_person,
  billing.invoices.fk_payer_branch,
  billing.invoices.fk_branch,
  billing.invoices.visit_date,
  billing.invoices.fk_lu_bulk_billing_type,
  billing.invoices.fk_appointment,
  billing.invoices.total_bill,
  billing.invoices.total_gst,
  billing.invoices.total_paid,
  payments_received.fk_lu_payment_method,
  payments_received.date_paid,
  lu_payment_method.method as payment_method,
  admin.vwstaff.firstname as  staff_firstname,
  admin.vwStaff.surname as staff_surname
FROM
  billing.invoices
  LEFT JOIN clerical.data_patients on data_patients.pk = billing.invoices.fk_patient
  LEFT JOIN contacts.data_persons on data_patients.fk_person = data_persons.pk
  LEFT JOIN clerical.bookings on bookings.pk = invoices.fk_appointment
  JOIN admin.vwstaff on invoices.fk_staff_provided_service = vwstaff.fk_staff
  JOIN billing.items_billed on items_billed.fk_invoice = invoices.pk
  LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
  LEFT JOIN contacts.data_branches on data_branches.pk = invoices.fk_payer_branch
  LEFT JOIN contacts.data_organisations on data_organisations.pk = data_branches.fk_organisation
  LEFT JOIN contacts.data_persons DP2 ON invoices.fk_payer_person = DP2.pk
  left join billing.payments_received ON invoices.pk = payments_received.fk_invoice
  Left join billing.lu_payment_method on payments_received.fk_lu_payment_method =  lu_payment_method.pk
  JOIN billing.fee_schedule ON fee_schedule.pk = items_billed.fk_fee_schedule
  ;

ALTER TABLE billing.vwDaysInvoicesAndPayments   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwDaysInvoicesAndPayments TO staff;

  
  update db.lu_version set lu_minor = 499;
