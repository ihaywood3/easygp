-- work on keeping data for banking slips generated and mods to billing

Comment on table billing.bank_details is 'used in billing, not to save the bank_details of the practice';

create table billing.banking_slips
(pk serial primary key,
 fk_staff integer not null references admin.staff (pk),
 date_generated date not null,
 date_from date not null,
 date_to date not null,
 bank_account_name text not null,
 cash_for_cheques text default null,
 html_slip text not null,
 html_cash_cheques text not null
 );

ALTER TABLE billing.banking_slips   OWNER TO easygp;
grant all on table billing.banking_slips  to easygp;
grant all on table billing.banking_slips  to staff;

 Comment on table billing.banking_slips is 
 'the records of banking slips, generated for cheques and cash
  from the last date banked to now(), and linked back to these
  payments in the billing.payments_received table)
  A dummy record with a key of zero(0) is created as I had to
  mark all previous payments made as 0 from whatever date
  one started using the banking slips, leaving it null wasn''t
  any good as the field need be non zero or null, and null means
  no banking slip for this payment and is used to create
  latest banking slip. Ian would have had a better solution but
  this one works
  ';
  
  comment on column billing.banking_slips.fk_staff is 
  'the staff member who generated the banking slip';
  comment on column billing.banking_slips.bank_account_name is
   'the name of the account the money/cheques were banked into';
  comment on column billing.banking_slips.date_from is
   'the first date included in the banking slip';
  comment on column billing.banking_slips.date_to is
  'the last date included in the monies taken - cannot be a partial days takings';
  comment on column billing.banking_slips.html_slip is
  'the html rendition of the banking slip';
    comment on column billing.banking_slips.html_cash_cheques is
  'the html rendition ofall the entries for cash and cheque with full details of patient names, dates';
  comment on column billing.banking_slips.cash_for_cheques is 
  'As this will never be big and never searched is kept as a pipe delimited
   field eg 01/01/2010, $200.00, Payee | next one.... |next one
   and is split up back in the gui';

 ALTER SEQUENCE billing.banking_slips_pk_seq
       INCREMENT 1  MINVALUE 0
       MAXVALUE 9223372036854775807  RESTART 0
       CACHE 1  NO CYCLE;
   
 ALTER TABLE billing.banking_slips_pk_seq   OWNER TO easygp;
grant all on table billing.banking_slips_pk_seq  to easygp;
grant all on table billing.banking_slips_pk_seq  to staff;

insert into billing.banking_slips (fk_staff,date_generated, date_from, date_to, bank_account_name, html_slip, html_cash_cheques) values (1, Now(), Now(), Now(), 'dummy account name', 'dummy html slip', 'dummy html cash and cheques');
 
Alter table billing.payments_received add column fk_banking_slip integer default null references billing.banking_slips (pk);

Comment on column billing.payments_received.fk_banking_slip is
'if not null, then this payment will be on the banking slip pointed to buy the key in
 the table billing.banking_slips';

-- This is a temporary view until I finish the coding

drop view billing.vwdaysinvoicesandpayments;

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
    fee_schedule.number_of_patients,
    items_billed.pk AS pk_items_billed,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.deleted AS item_deleted,
    items_billed.reason_code,
    lu_codes.description AS reason_code_description,
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
    payments_received.pk as fk_payment_received,
    payments_received.fk_lu_payment_method,
    payments_received.date_paid,
    payments_received.amount AS amount_paid,
    payments_received.date_banked,
    payments_received.referent,
    lu_payment_method.method AS payment_method,
    vwstaff.firstname AS staff_firstname,
    vwstaff.surname AS staff_surname,
    payments_received.fk_banking_slip
   FROM billing.invoices
     LEFT JOIN clerical.data_patients ON data_patients.pk = invoices.fk_patient
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN clerical.bookings ON bookings.pk = invoices.fk_appointment
     JOIN admin.vwstaff ON invoices.fk_staff_provided_service = vwstaff.fk_staff
     JOIN billing.items_billed ON items_billed.fk_invoice = invoices.pk
     LEFT JOIN billing.lu_codes ON lu_codes.code = items_billed.reason_code
     LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
     LEFT JOIN contacts.data_branches ON data_branches.pk = invoices.fk_payer_branch
     LEFT JOIN contacts.data_organisations ON data_organisations.pk = data_branches.fk_organisation
     LEFT JOIN contacts.data_persons dp2 ON invoices.fk_payer_person = dp2.pk
     LEFT JOIN billing.payments_received ON invoices.pk = payments_received.fk_invoice
     LEFT JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
     JOIN billing.fee_schedule ON fee_schedule.pk = items_billed.fk_fee_schedule;

ALTER TABLE billing.vwdaysinvoicesandpayments   OWNER TO easygp;
grant all on table billing.vwdaysinvoicesandpayments  to easygp;
grant all on table billing.vwdaysinvoicesandpayments  to staff;


update db.lu_version set lu_minor=527;
  
 