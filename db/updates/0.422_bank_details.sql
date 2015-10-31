create table billing.bank_details (
       pk serial primary key,
       fk_invoice integer references billing.invoices(pk) not null,
       bsb char(6) check (bsb ~ '^[0-9]{6}$') not null,
       account_number varchar(10) check (account_number ~ '^[0-9]{4,10}$') not null,
       account_name text not null
);

grant all on billing.bank_details to staff;
grant all on billing.bank_details_pk_seq to staff;

alter table billing.invoices add column claimant_address_upload boolean not null default false;
alter table billing.invoices add column bank_details_upload boolean not null default false;
comment on column billing.invoices.claimant_address_upload is 'true if claimant''s address is to be uploaded using Medicare Online';
comment on column billing.invoices.bank_details_upload is 'true if claimant''s bank details are to be uploaded using Medicare Online';
alter table billing.invoices add constraint flags_online check (not ((not online) and (bank_details_upload or claimant_address_upload)));
alter table billing.invoices add constraint has_claimant check (not (claimant_address_upload and fk_payer_person is null));

create or replace view billing.vwinvoices as
 SELECT invoices.pk AS pk_invoice,
    invoices.pk AS fk_invoice,
    invoices.notes,
    invoices.fk_staff_invoicing,
    invoices.fk_patient,
    invoices.date_printed,
    invoices.fk_staff_provided_service,
    invoices.date_invoiced,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    vworganisations.branch AS account_to_branch,
    COALESCE(vworganisations.street1 || ' '::text || vworganisations.street2, vworganisations.street1, vwpersonsincludingpatients.street1 || ' '::text || vwpersonsincludingpatients.street2,vwpersonsincludingpatients.street1) AS account_to_street,
    COALESCE((vworganisations.town || ' '::text) || vworganisations.postcode::text, (vwpersonsincludingpatients.town || ' '::text) || vwpersonsincludingpatients.postcode::text) AS account_to_town_postcode,
    invoices.latex,
    invoices.fk_branch,
    invoices.visit_date,
    invoices.fk_appointment,
    bookings.begin AS appointment_time,
    bookings.duration,
    invoices.reference,
    invoices.fk_lu_bulk_billing_type,
    invoices.total_bill,
    invoices.total_paid,
    invoices.total_gst,
    invoices.total_bill - invoices.total_paid AS due,
    staff_invoicing.wholename AS staff_invoicing_wholename,
    staff_provider.wholename AS staff_provided_service_wholename,
    staff_provider.provider_number AS staff_provided_service_provider_number,
    staff_provider.australian_business_number,
    vwpatients.firstname AS patient_firstname,
    vwpatients.surname AS patient_surname,
    vwpatients.title AS patient_title,
    vwpatients.fk_sex AS patient_fk_sex,
    vwpatients.sex AS patient_sex,
    vwpatients.wholename AS patient_wholename,
    vwpatients.fk_lu_centrelink_card_type,
    vwpatients.fk_lu_default_billing_level,
    vworganisations1.branch,
    claims.claim_id,
    claims.result_code AS claim_result_code,
    claims.result_text AS claim_result_text,
    claims.claim_date,
    invoices.online,
    invoices.fk_claim,
    invoices.voucher_id,
    invoices.referrer_provider_number,
    invoices.referral_date,
    invoices.referral_duration,
    invoices.result_code,
    invoices.result_text,
    invoices.error_level,
    invoices.pms_claim_id,
    c1.description,
    c2.description AS claim_description,
    invoices.bank_details_upload,
    invoices.claimant_address_upload,
    vp2.medicare_number as account_to_medicare_number,
    vp2.medicare_ref_number as account_to_medicare_ref_number,
    vp2.birthdate as account_to_birthdate
   FROM billing.invoices
     JOIN admin.vwstaff staff_invoicing ON invoices.fk_staff_invoicing = staff_invoicing.fk_staff
     JOIN admin.vwstaff staff_provider ON invoices.fk_staff_provided_service = staff_provider.fk_staff
     JOIN contacts.vworganisations vworganisations1 ON invoices.fk_branch = vworganisations1.fk_branch
     LEFT JOIN clerical.bookings ON invoices.fk_appointment = bookings.pk
     LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
     LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
     LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient
     LEFT JOIN billing.claims ON invoices.fk_claim = claims.pk
     LEFT JOIN billing.lu_codes c1 ON invoices.result_code = c1.code
     LEFT JOIN billing.lu_codes c2 ON claims.result_code = c2.code
     LEFT JOIN contacts.vwpatients vp2 ON (invoices.fk_payer_person = vp2.fk_person);

create or replace view billing.vwitemsandinvoices as 
 SELECT vwitemsbilled.pk_items_billed,
    vwitemsbilled.fk_fee_schedule,
    vwitemsbilled.amount,
    vwitemsbilled.amount_gst,
    vwitemsbilled.fk_lu_billing_type,
    vwitemsbilled.billing_type,
    vwitemsbilled.mbs_item,
    vwitemsbilled.user_item,
    vwitemsbilled.ama_item,
    vwitemsbilled.descriptor,
    vwitemsbilled.descriptor_brief,
    vwitemsbilled.gst_rate,
    vwitemsbilled.percentage_fee_rule,
    vwinvoices.fk_invoice,
    vwinvoices.notes,
    vwinvoices.fk_staff_invoicing,
    vwinvoices.fk_patient,
    vwinvoices.date_printed,
    vwinvoices.fk_staff_provided_service,
    vwinvoices.date_invoiced,
    vwinvoices.paid,
    vwinvoices.fk_payer_person,
    vwinvoices.fk_payer_branch,
    vwinvoices.account_to_name,
    vwinvoices.account_to_branch,
    vwinvoices.account_to_street,
    vwinvoices.account_to_town_postcode,
    vwinvoices.latex,
    vwinvoices.fk_branch,
    vwinvoices.visit_date,
    vwinvoices.fk_appointment,
    vwinvoices.appointment_time,
    vwinvoices.duration,
    vwinvoices.reference,
    vwinvoices.fk_lu_bulk_billing_type,
    vwinvoices.total_bill,
    vwinvoices.total_paid,
    vwinvoices.total_gst,
    vwinvoices.due,
    vwinvoices.staff_invoicing_wholename,
    vwinvoices.staff_provided_service_wholename,
    vwinvoices.staff_provided_service_provider_number,
    vwinvoices.australian_business_number,
    vwinvoices.patient_firstname,
    vwinvoices.patient_surname,
    vwinvoices.patient_title,
    vwinvoices.patient_fk_sex,
    vwinvoices.patient_sex,
    vwinvoices.patient_wholename,
    vwinvoices.fk_lu_centrelink_card_type,
    vwinvoices.fk_lu_default_billing_level,
    vwinvoices.branch,
    vwinvoices.result_code,
    vwinvoices.result_text,
    vwitemsbilled.reason_code,
    vwitemsbilled.comment AS item_comment,
    vwitemsbilled.service_id,
    vwinvoices.voucher_id,
    vwinvoices.fk_claim,
    vwinvoices.pms_claim_id,
    vwinvoices.error_level,
    vwinvoices.description,
    vwitemsbilled.error_level AS item_error_level,
    vwitemsbilled.description AS item_description,
    vwinvoices.claim_description,
    vwinvoices.claim_result_code,
    vwinvoices.claim_result_text,
    vwinvoices.online,
    vwitemsbilled.common_item,
    vwinvoices.claim_id,
    vwinvoices.claim_date,
    vwinvoices.bank_details_upload,
    vwinvoices.claimant_address_upload
   FROM billing.vwitemsbilled,
    billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice;

update db.lu_version set lu_minor=422; 
