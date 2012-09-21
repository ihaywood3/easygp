Delete from billing.invoices;

Alter table billing.invoices add column fk_payer_person integer default null;
COMMENT ON COLUMN billing.invoices.fk_payer_person IS 'if not null then the key to the person who pays the bill';
alter table billing.invoices add CONSTRAINT invoices_fk_payer_person_fkey FOREIGN KEY (fk_payer_person)
      REFERENCES contacts.data_persons (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

Alter table billing.invoices add column fk_payer_branch integer default null;
COMMENT ON COLUMN billing.invoices.fk_payer_branch IS 'if not null then payer is an organisation/branch';
Alter table billing.invoices add CONSTRAINT invoices_fk_payer_branch_fkey FOREIGN KEY (fk_payer_branch)
      REFERENCES contacts.data_branches (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

Alter table billing.invoices add column latex text default null;
COMMENT ON COLUMN billing.invoices.latex is
 'The null is because of the chicken and the egg
  the invoice must be saved to get the pk before the latex is generated (or does it- FIXME)
 the LaTeX definition of the invoice generated';

Alter table billing.invoices add column fk_branch integer not null;
COMMENT ON COLUMN billing.invoices.fk_branch IS 'The branch at which the patient was provided with the service';
Alter table billing.invoices add CONSTRAINT invoices_fk_branch_fkey FOREIGN KEY (fk_branch)
      REFERENCES contacts.data_branches (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

Alter table billing.invoices add column visit_date date default null;
COMMENT ON COLUMN billing.invoices.visit_date IS 'The date time of the patient visit - may be null because the invoice could be raised not in relation to a visit';

--DROP VIEW billing.vwitemsbilled;

CREATE OR REPLACE VIEW billing.vwitemsbilled AS 
 SELECT items_billed.pk AS pk_items_billed, vwstaffinclinics.firstname AS staff_invoiced_firstname, 
vwstaffinclinics.surname AS staff_invoiced_surname, vwstaffinclinics.wholename AS staff_invoiced_wholename, 
vwstaffinclinics.title AS staff_invoiced_title, invoices.fk_staff_invoicing, invoices.date_printed, 
invoices.notes, invoices.fk_staff_provided_service, invoices.fk_patient, 
vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, 
vwpatients.title AS patient_title, vwpatients.fk_sex AS patient_fk_sex, vwpatients.sex AS patient_sex, 
vwpatients.wholename AS patient_wholename, invoices.fk_payer_person, invoices.fk_payer_branch, 
invoices.date_invoiced, invoices.paid, invoices.latex, invoices.visit_date, 
vwstaffinclinics1.provider_number AS staff_provided_service_provider_number, 
vwstaffinclinics1.firstname AS staff_provided_service_firstname, 
vwstaffinclinics1.surname AS staff_provided_service_surname, 
vwstaffinclinics1.wholename AS staff_provided_service_wholename, 
vwstaffinclinics1.title AS staff_provided_service_title, data_branches.branch, 
items_billed.fk_fee_schedule, items_billed.amount, items_billed.fk_invoice, 
items_billed.fk_lu_billing_type, lu_billing_type.type AS billing_type, fee_schedule.item, 
fee_schedule.mbs_item, fee_schedule.user_item, fee_schedule.ama_item, fee_schedule.descriptor, 
fee_schedule.descriptor_brief, fee_schedule.gst_rate, fee_schedule.percentage_fee_rule
   FROM billing.invoices
   JOIN admin.vwstaffinclinics ON invoices.fk_staff_invoicing = vwstaffinclinics.fk_staff
   JOIN admin.vwstaffinclinics vwstaffinclinics1 ON invoices.fk_staff_provided_service = vwstaffinclinics1.fk_staff
   JOIN billing.items_billed ON invoices.pk = items_billed.fk_invoice
   JOIN billing.lu_billing_type ON items_billed.fk_lu_billing_type = lu_billing_type.pk
   JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
   JOIN contacts.data_branches ON invoices.fk_branch = data_branches.pk
   LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient;

ALTER TABLE billing.vwitemsbilled   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwitemsbilled TO easygp;
GRANT ALL ON TABLE billing.vwitemsbilled TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 232);

