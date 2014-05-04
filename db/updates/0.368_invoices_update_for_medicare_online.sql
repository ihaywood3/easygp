drop view billing.vwinvoices cascade; -- will cascade to vwitemandinvoices
drop view billing.vwitemsbilled;

alter table billing.invoices add column voucher_id varchar(2);
alter table billing.invoices add column referrer_provider_number varchar(8);
alter table billing.invoices add column referral_date date;
alter table billing.invoices add column referral_duration integer;
alter table billing.claims add column provider_number varchar(8);
alter table billing.claims add column payment_report_run_date timestamp;
alter table billing.claims add column processing_report_run_date timestamp;
alter table billing.claims add column payment_report text;
alter table billing.claims drop column finalised;
alter table billing.claims alter column claim_id drop not null;

alter table billing.items_billed add column service_id char(4);
alter table billing.items_billed add column reason_code integer;
alter table billing.items_billed add column comment text;

create view billing.vwinvoices as SELECT invoices.pk AS pk_invoice, invoices.pk AS fk_invoice, invoices.notes, invoices.fk_staff_invoicing, invoices.fk_patient, invoices.date_printed, invoices.fk_staff_provided_service, invoices.date_invoiced, invoices.paid, invoices.fk_payer_person, invoices.fk_payer_branch, COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name, vworganisations.branch AS account_to_branch, COALESCE(COALESCE(vworganisations.street1 || ' '::text, vworganisations.street2 || ' '::text), COALESCE(vwpersonsincludingpatients.street1 || ' '::text, vwpersonsincludingpatients.street2 || ' '::text)) AS account_to_street, COALESCE((vworganisations.town || ' '::text) || vworganisations.postcode::text, (vwpersonsincludingpatients.town || ' '::text) || vwpersonsincludingpatients.postcode::text) AS account_to_town_postcode, invoices.latex, invoices.fk_branch, invoices.visit_date, invoices.fk_appointment, bookings.begin AS appointment_time, bookings.duration, invoices.reference, invoices.fk_lu_bulk_billing_type, invoices.total_bill, invoices.total_paid, invoices.total_gst, invoices.total_bill - invoices.total_paid AS due, staff_invoicing.wholename AS staff_invoicing_wholename, staff_provider.wholename AS staff_provided_service_wholename, staff_provider.provider_number AS staff_provided_service_provider_number, staff_provider.australian_business_number, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.title AS patient_title, vwpatients.fk_sex AS patient_fk_sex, vwpatients.sex AS patient_sex, vwpatients.wholename AS patient_wholename, vwpatients.fk_lu_centrelink_card_type, vwpatients.fk_lu_default_billing_level, vworganisations1.branch, claims.claim_id, claims.result_code AS claim_result_code, claims.result_text AS claim_result_text, claims.claim_date, invoices.online as online, invoices.fk_claim as fk_claim, invoices.voucher_id, invoices.referrer_provider_number, invoices.referral_date, invoices.referral_duration, invoices.result_code, invoices.result_text
   FROM billing.invoices
   JOIN admin.vwstaff staff_invoicing ON invoices.fk_staff_invoicing = staff_invoicing.fk_staff
   JOIN admin.vwstaff staff_provider ON invoices.fk_staff_provided_service = staff_provider.fk_staff
   JOIN contacts.vworganisations vworganisations1 ON invoices.fk_branch = vworganisations1.fk_branch
   LEFT JOIN clerical.bookings ON invoices.fk_appointment = bookings.pk
   LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient
   LEFT JOIN billing.claims ON invoices.fk_claim = claims.pk;


create view billing.vwitemsbilled as
SELECT items_billed.pk AS pk_items_billed,
    items_billed.fk_fee_schedule,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.fk_invoice,
    items_billed.fk_lu_billing_type,
    lu_billing_type.type AS billing_type,
    fee_schedule.mbs_item,
    fee_schedule.user_item,
    fee_schedule.ama_item,
    fee_schedule.descriptor,
    fee_schedule.descriptor_brief,
    fee_schedule.gst_rate,
    fee_schedule.percentage_fee_rule,
    items_billed.service_id,
    items_billed.reason_code,
    items_billed.comment
   FROM billing.items_billed,
    billing.lu_billing_type,
    billing.fee_schedule
  WHERE lu_billing_type.pk = items_billed.fk_lu_billing_type AND items_billed.fk_fee_schedule = fee_schedule.pk;


create view billing.vwitemsandinvoices as
 SELECT vwitemsbilled.pk_items_billed, vwitemsbilled.fk_fee_schedule, vwitemsbilled.amount, vwitemsbilled.amount_gst, vwitemsbilled.fk_lu_billing_type, vwitemsbilled.billing_type, vwitemsbilled.mbs_item, vwitemsbilled.user_item, vwitemsbilled.ama_item, vwitemsbilled.descriptor, vwitemsbilled.descriptor_brief, vwitemsbilled.gst_rate, vwitemsbilled.percentage_fee_rule, vwinvoices.fk_invoice, vwinvoices.notes, vwinvoices.fk_staff_invoicing, vwinvoices.fk_patient, vwinvoices.date_printed, vwinvoices.fk_staff_provided_service, vwinvoices.date_invoiced, vwinvoices.paid, vwinvoices.fk_payer_person, vwinvoices.fk_payer_branch, vwinvoices.account_to_name, vwinvoices.account_to_branch, vwinvoices.account_to_street, vwinvoices.account_to_town_postcode, vwinvoices.latex, vwinvoices.fk_branch, vwinvoices.visit_date, vwinvoices.fk_appointment, vwinvoices.appointment_time, vwinvoices.duration, vwinvoices.reference, vwinvoices.fk_lu_bulk_billing_type, vwinvoices.total_bill, vwinvoices.total_paid, vwinvoices.total_gst, vwinvoices.due, vwinvoices.staff_invoicing_wholename, vwinvoices.staff_provided_service_wholename, vwinvoices.staff_provided_service_provider_number, vwinvoices.australian_business_number, vwinvoices.patient_firstname, vwinvoices.patient_surname, vwinvoices.patient_title, vwinvoices.patient_fk_sex, vwinvoices.patient_sex, vwinvoices.patient_wholename, vwinvoices.fk_lu_centrelink_card_type, vwinvoices.fk_lu_default_billing_level, vwinvoices.branch, vwinvoices.result_code, vwinvoices.result_text, vwitemsbilled.reason_code, vwitemsbilled.comment as item_comment, vwitemsbilled.service_id, vwinvoices.voucher_id, vwinvoices.fk_claim
   FROM billing.vwitemsbilled, billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice;

insert into billing.lu_payment_method (pk,"method") values (5, 'medicare');

grant select on billing.vwitemsandinvoices to staff;
grant select on billing.vwinvoices to staff;
grant select on billing.vwitemsbilled to staff;

update db.lu_version set lu_minor=368;
