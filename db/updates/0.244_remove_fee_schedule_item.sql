alter table billing.fee_schedule drop column item cascade;



create view billing.vwbulkbilleditems as
SELECT items_billed.pk AS pk_items_billed, items_billed.fk_invoice, items_billed.amount, items_billed.fk_lu_billing_type, invoices.fk_branch, invoices.fk_patient, invoices.fk_staff_provided_service, fee_schedule.mbs_item, invoices.paid, invoices.latex, invoices.fk_lu_bulk_billing_type, invoices.visit_date, (data_persons.firstname || ' '::text) || data_persons.surname AS patient_wholename, link_invoice_bulk_bill_claim.fk_claim
   FROM billing.invoices
   JOIN billing.items_billed ON invoices.pk = items_billed.fk_invoice
   JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
   JOIN clerical.data_patients ON invoices.fk_patient = data_patients.pk
   JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN billing.link_invoice_bulk_bill_claim ON invoices.pk = link_invoice_bulk_bill_claim.fk_invoice
  WHERE invoices.fk_lu_bulk_billing_type IS NOT NULL;

alter view billing.vwbulkbilleditems owner to easygp;
grant select on billing.vwbulkbilleditems to staff;

create view billing.vwitemsbilled as 
 SELECT items_billed.pk AS pk_items_billed, items_billed.fk_fee_schedule, items_billed.amount, items_billed.amount_gst, items_billed.fk_invoice, items_billed.fk_lu_billing_type, lu_billing_type.type AS billing_type, fee_schedule.mbs_item, fee_schedule.user_item, fee_schedule.ama_item, fee_schedule.descriptor, fee_schedule.descriptor_brief, fee_schedule.gst_rate, fee_schedule.percentage_fee_rule
   FROM billing.items_billed, billing.lu_billing_type, billing.fee_schedule
  WHERE lu_billing_type.pk = items_billed.fk_lu_billing_type AND items_billed.fk_fee_schedule = fee_schedule.pk;


alter view billing.vwitemsbilled owner to easygp;
grant select on billing.vwitembilled to staff;


create view billing.vwitemsandinvoices as
SELECT vwitemsbilled.pk_items_billed, vwitemsbilled.fk_fee_schedule, vwitemsbilled.amount, vwitemsbilled.amount_gst, vwitemsbilled.fk_lu_billing_type, vwitemsbilled.billing_type, vwitemsbilled.mbs_item, vwitemsbilled.user_item, vwitemsbilled.ama_item, vwitemsbilled.descriptor, vwitemsbilled.descriptor_brief, vwitemsbilled.gst_rate, vwitemsbilled.percentage_fee_rule, vwinvoices.fk_invoice, vwinvoices.notes, vwinvoices.fk_staff_invoicing, vwinvoices.fk_patient, vwinvoices.date_printed, vwinvoices.fk_staff_provided_service, vwinvoices.date_invoiced, vwinvoices.paid, vwinvoices.fk_payer_person, vwinvoices.fk_payer_branch, vwinvoices.account_to_name, vwinvoices.account_to_branch, vwinvoices.account_to_street, vwinvoices.account_to_town_postcode, vwinvoices.latex, vwinvoices.fk_branch, vwinvoices.visit_date, vwinvoices.fk_appointment, vwinvoices.appointment_time, vwinvoices.duration, vwinvoices.reference, vwinvoices.fk_lu_bulk_billing_type, vwinvoices.total_bill, vwinvoices.total_paid, vwinvoices.total_gst, vwinvoices.due, vwinvoices.staff_invoicing_wholename, vwinvoices.staff_provided_service_wholename, vwinvoices.staff_provided_service_provider_number, vwinvoices.australian_business_number, vwinvoices.patient_firstname, vwinvoices.patient_surname, vwinvoices.patient_title, vwinvoices.patient_fk_sex, vwinvoices.patient_sex, vwinvoices.patient_wholename, vwinvoices.fk_lu_centrelink_card_type, vwinvoices.fk_lu_default_billing_level, vwinvoices.branch
   FROM billing.vwitemsbilled, billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice;

alter view billing.vwitemsandinvoices owner to easygp;
grant select on billing.vwitemsandinvoices to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 244);
