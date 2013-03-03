-- alter table billing.bulk_billing_claims ADD CONSTRAINT bulk_billing_claims_pkey PRIMARY KEY (pk );
-- alter table billing.bulk_billing_claims ADD CONSTRAINT bulk_billing_claims_fk_branch_fkey FOREIGN KEY (fk_branch)  REFERENCES contacts.data_branches (pk) MATCH SIMPLE  ON UPDATE NO ACTION ON DELETE NO ACTION;
-- alter table billing.bulk_billing_claims ADD CONSTRAINT bulk_billing_claims_fk_doctor_provided_service_fkey FOREIGN KEY (fk_staff_provided_service) REFERENCES admin.staff (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- alter table billing.bulk_billing_claims ADD CONSTRAINT  bulk_billing_claims_fk_lu_bulk_billing_type_fkey FOREIGN KEY (fk_lu_bulk_billing_type) REFERENCES billing.lu_bulk_billing_type (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- alter table billing.bulk_billing_claims ADD CONSTRAINT bulk_billing_claims_fk_staff_processed_fkey FOREIGN KEY (fk_staff_processed) REFERENCES admin.staff (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
           
-- alter table billing.fee_schedule  ADD  CONSTRAINT fee_schedule_pkey PRIMARY KEY (pk );
-- alter table billing.fee_schedule  ADD CONSTRAINT schedule_ama_item_key UNIQUE (ama_item );
-- alter table billing.fee_schedule  ADD CONSTRAINT schedule_item_key UNIQUE (item );
 
-- ALTER TABLE billing.invoices ADD CONSTRAINT invoices_pkey PRIMARY KEY (pk );
-- ALTER TABLE billing.invoices ADD  CONSTRAINT invoices_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES contacts.data_branches (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.invoices ADD  CONSTRAINT invoices_fk_doctor_raising_fkey FOREIGN KEY (fk_staff_provided_service) REFERENCES admin.staff (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.invoices ADD  CONSTRAINT invoices_fk_patient_fkey FOREIGN KEY (fk_patient) REFERENCES clerical.data_patients (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.invoices ADD  CONSTRAINT invoices_fk_payer_branch_fkey FOREIGN KEY (fk_payer_branch) REFERENCES contacts.data_branches (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.invoices ADD CONSTRAINT invoices_fk_payer_person_fkey FOREIGN KEY (fk_payer_person) REFERENCES contacts.data_persons (pk) MATCH SIMPLE  ON UPDATE NO ACTION ON DELETE NO ACTION;
      
      
-- ALTER TABLE billing.items_billed ADD CONSTRAINT items_billed_pkey PRIMARY KEY (pk );
-- ALTER TABLE billing.items_billed ADD   CONSTRAINT items_billed_fk_fee_schedule_fkey FOREIGN KEY (fk_fee_schedule) REFERENCES billing.fee_schedule (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.items_billed ADD  CONSTRAINT items_billed_fk_invoice_fkey FOREIGN KEY (fk_invoice) REFERENCES billing.invoices (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.items_billed ADD CONSTRAINT prices_fk_lu_billing_type_fkey FOREIGN KEY (fk_lu_billing_type) REFERENCES billing.lu_billing_type (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

-- ALTER TABLE billing.link_invoice_bulk_bill_claim ADD CONSTRAINT link_invoice_bulk_bill_claim_pkey PRIMARY KEY (pk );
-- GRANT ALL ON TABLE billing.link_invoice_bulk_bill_claim TO easygp;
-- GRANT ALL ON TABLE billing.link_invoice_bulk_bill_claim TO staff;

-- ALTER TABLE billing.lu_invoice_comments ADD CONSTRAINT lu_invoice_comments_pkey PRIMARY KEY (pk);
-- ALTER TABLE billing.lu_payment_method ADD CONSTRAINT lu_payment_method_pkey PRIMARY KEY (pk );
-- ALTER TABLE billing.lu_reasons_not_billed ADD CONSTRAINT lu_reasons_not_billed_pkey PRIMARY KEY (pk );

-- ALTER TABLE billing.payments_received ADD CONSTRAINT payments_received_pkey PRIMARY KEY (pk );
-- ALTER TABLE billing.payments_received ADD CONSTRAINT payments_received_fk_invoice_fkey FOREIGN KEY (fk_invoice) REFERENCES billing.invoices (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.payments_received ADD CONSTRAINT  payments_received_fk_staff_receipted_fkey FOREIGN KEY (fk_staff_receipted) REFERENCES admin.staff (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION ;


-- ALTER TABLE billing.prices ADD CONSTRAINT prices_pkey PRIMARY KEY (pk ); 
-- ALTER TABLE billing.prices ADD  CONSTRAINT prices_fk_fee_schedule_fkey FOREIGN KEY (fk_fee_schedule) REFERENCES billing.fee_schedule (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
-- ALTER TABLE billing.prices ADD  CONSTRAINT prices_fk_lu_billing_type_fkey FOREIGN KEY (fk_lu_billing_type) REFERENCES billing.lu_billing_type (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

-- CREATE TABLE billing.lu_reports
-- (
--   pk serial primary key,
  -- report_title text NOT NULL);
  
-- ALTER TABLE billing.lu_reports OWNER TO easygp;
-- GRANT ALL ON TABLE billing.reports TO easygp;
-- GRANT ALL ON TABLE billing.reports TO staff;

-- Insert into billing.lu_reports (report_title) values('Consultations Not Charged');
-- ert into billing.lu_reports (report_title) values('Day List of Patients Seen');
-- ert into billing.lu_reports (report_title) values('Payments Received');


-- P TABLE billing.reports;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 243);


