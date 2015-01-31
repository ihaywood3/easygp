alter table billing.invoices add column online boolean default false not null;

comment on column billing.invoices.online is 'true if the invoice is to be uploaded via Medicare Online';

alter table billing.invoices add column result_code integer default -1;

comment on column billing.invoices.result_code is 'code returned by Medicare Online driver. 0 means success. -1 means never submitted';

alter table billing.invoices add column result_text text;

comment on column billing.invoices.result_code is 'text returned by medicare Online driver, only significant if result_code > 0';

drop table billing.link_invoice_bulk_bill_claim cascade;

alter table billing.bulk_billing_claims rename to claims;
-- alter table billing.claims add primary key (pk);
alter table billing.invoices add column fk_claim integer references billing.claims (pk);

COMMENT ON TABLE billing.claims
  IS 'Contains informaton about claims made online: bulk-billing or otherwise';
alter table billing.claims drop column html;
alter table billing.claims drop column fk_medclaim;
alter table billing.claims drop column  claim_amount;
alter table billing.claims drop column  voucher_count;
alter table billing.claims drop column  fk_lu_bulk_billing_type;
alter table billing.claims drop column  fk_staff_provided_service;
alter table billing.claims drop column  fk_staff_processed;
alter table billing.claims add column result_code integer default -2;
alter table billing.claims add column result_text text;

comment on column billing.claims.result_code is 'returned code for the whole claim. 0 means success';
comment on column billing.claims.result_text is 'only significant if report > 0, returned by the driver';

alter table billing.claims alter column claim_date type timestamp;

create or replace view billing.vwinvoices as
 SELECT invoices.pk AS pk_invoice, invoices.pk AS fk_invoice, invoices.notes, invoices.fk_staff_invoicing, invoices.fk_patient, invoices.date_printed, invoices.fk_staff_provided_service, invoices.date_invoiced, invoices.paid, invoices.fk_payer_person, invoices.fk_payer_branch, COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name, vworganisations.branch AS account_to_branch, COALESCE(COALESCE(vworganisations.street1 || ' '::text, vworganisations.street2 || ' '::text), COALESCE(vwpersonsincludingpatients.street1 || ' '::text, vwpersonsincludingpatients.street2 || ' '::text)) AS account_to_street, COALESCE((vworganisations.town || ' '::text) || vworganisations.postcode::text, (vwpersonsincludingpatients.town || ' '::text) || vwpersonsincludingpatients.postcode::text) AS account_to_town_postcode, invoices.latex, invoices.fk_branch, invoices.visit_date, invoices.fk_appointment, bookings.begin AS appointment_time, bookings.duration, invoices.reference, invoices.fk_lu_bulk_billing_type, invoices.total_bill, invoices.total_paid, invoices.total_gst, invoices.total_bill - invoices.total_paid AS due, staff_invoicing.wholename AS staff_invoicing_wholename, staff_provider.wholename AS staff_provided_service_wholename, staff_provider.provider_number AS staff_provided_service_provider_number, staff_provider.australian_business_number, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.title AS patient_title, vwpatients.fk_sex AS patient_fk_sex, vwpatients.sex AS patient_sex, vwpatients.wholename AS patient_wholename, vwpatients.fk_lu_centrelink_card_type, vwpatients.fk_lu_default_billing_level, vworganisations1.branch,
   claims.claim_id,
   claims.result_code as claim_result_code,
   claims.result_text as claim_result_text,
   claims.claim_date,
   claims.finalised
   FROM billing.invoices
   JOIN admin.vwstaff staff_invoicing ON invoices.fk_staff_invoicing = staff_invoicing.fk_staff
   JOIN admin.vwstaff staff_provider ON invoices.fk_staff_provided_service = staff_provider.fk_staff
   JOIN contacts.vworganisations vworganisations1 ON invoices.fk_branch = vworganisations1.fk_branch
   LEFT JOIN clerical.bookings ON invoices.fk_appointment = bookings.pk
   LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient
   LEFT JOIN billing.claims ON (invoices.fk_claim = claims.pk);


update db.lu_version set lu_minor=357;

