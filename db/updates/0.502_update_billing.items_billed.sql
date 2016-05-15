alter table billing.items_billed add column deleted boolean default false;
comment on COLUMN billing.items_billed.deleted is 'If True then the item has been deleted from an invoice';

CREATE OR REPLACE VIEW billing.vwitemsbilled AS 
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
    COALESCE(fee_schedule.mbs_item, fee_schedule.ama_item, fee_schedule.user_item) AS common_item,
    fee_schedule.descriptor,
    fee_schedule.descriptor_brief,
    fee_schedule.gst_rate,
    fee_schedule.percentage_fee_rule,
    items_billed.service_id,
    items_billed.reason_code,
    items_billed.comment,
    items_billed.error_level,
    lu_codes.description,
    fee_schedule.number_of_patients,
    items_billed.multiple_procedure,
    items_billed.aftercare,
    items_billed.duplicate,
    items_billed.separate_sites,
    items_billed.not_related,
    items_billed.procedure_duration,
    items_billed.field_quantity,
    items_billed.deleted
   FROM billing.items_billed
     JOIN billing.lu_billing_type ON lu_billing_type.pk = items_billed.fk_lu_billing_type
     JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
     LEFT JOIN billing.lu_codes ON items_billed.reason_code = lu_codes.code;

ALTER TABLE billing.vwitemsbilled   OWNER TO easygp;
GRANT SELECT ON TABLE billing.vwitemsbilled TO staff;


CREATE OR REPLACE VIEW billing.vwitemsandinvoices AS 
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
    vwinvoices.claimant_address_upload,
    vwitemsbilled.number_of_patients,
    vwitemsbilled.multiple_procedure,
    vwitemsbilled.aftercare,
    vwitemsbilled.duplicate,
    vwitemsbilled.separate_sites,
    vwitemsbilled.not_related,
    vwitemsbilled.procedure_duration,
    vwitemsbilled.field_quantity,
    vwinvoices.payee_provider_number,
    vwItemsBilled.deleted as item_deleted
   FROM billing.vwitemsbilled,
    billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice and vwItemsBilled.deleted is false;
  
ALTER TABLE billing.vwitemsandinvoices   OWNER TO easygp;
GRANT SELECT ON TABLE billing.vwitemsandinvoices TO staff;

DROP VIEW billing.vwdaysinvoicesandpayments;

CREATE OR REPLACE VIEW billing.vwdaysinvoicesandpayments AS 
 SELECT bookings.begin AS appointment_date,
    (data_persons.firstname || ' '::text) || data_persons.surname AS patient_wholename,
    COALESCE(data_organisations.organisation, (dp2.firstname || ' '::text) || dp2.surname) AS account_to_name,
    lu_bulk_billing_type.type AS bulk_billing_type,
    COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
    fee_schedule.descriptor_brief,
    items_billed.pk AS pk_items_billed,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.deleted as item_deleted,
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
    lu_payment_method.method AS payment_method,
    vwstaff.firstname AS staff_firstname,
    vwstaff.surname AS staff_surname
   FROM billing.invoices
     LEFT JOIN clerical.data_patients ON data_patients.pk = invoices.fk_patient
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN clerical.bookings ON bookings.pk = invoices.fk_appointment
     JOIN admin.vwstaff ON invoices.fk_staff_provided_service = vwstaff.fk_staff
     JOIN billing.items_billed ON items_billed.fk_invoice = invoices.pk
     LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
     LEFT JOIN contacts.data_branches ON data_branches.pk = invoices.fk_payer_branch
     LEFT JOIN contacts.data_organisations ON data_organisations.pk = data_branches.fk_organisation
     LEFT JOIN contacts.data_persons dp2 ON invoices.fk_payer_person = dp2.pk
     LEFT JOIN billing.payments_received ON invoices.pk = payments_received.fk_invoice
     LEFT JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
     JOIN billing.fee_schedule ON fee_schedule.pk = items_billed.fk_fee_schedule
    ;

ALTER TABLE billing.vwdaysinvoicesandpayments  OWNER TO easygp;
GRANT ALL ON TABLE billing.vwdaysinvoicesandpayments TO staff;

update db.lu_version set lu_minor = 502;
