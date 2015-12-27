alter table billing.items_billed add column multiple_procedure boolean not null default 'f';
comment on column billing.items_billed.multiple_procedure is 'flag for multiple procedure override on Medicare Online';
alter table billing.items_billed add column aftercare boolean not null default 'f';
comment on column billing.items_billed.aftercare is 'flag for ''not normal aftercare'' on Medicare Online';
alter table billing.items_billed add column duplicate boolean not null default 'f';
comment on column billing.items_billed.duplicate is 'flag for ''duplicate service'' on Medicare Online';
alter table billing.items_billed add column separate_sites boolean not null default 'f';
comment on column billing.items_billed.separate_sites is 'flag for ''separate (procedure) sites'' on Medicare Online';
alter table billing.items_billed add column not_related boolean not null default 'f';
comment on column billing.items_billed.not_related is 'flag for ''not realted 9to care plan)'' on Medicare Online';
alter table billing.items_billed add column procedure_duration integer not null default 0;
comment on column billing.items_billed.procedure_duration is 'field for duration in certai special (usually anaesthetic) items on Medicare Online. Expressed in minutes, must be a mutiple of 15';
alter table billing.items_billed add column field_quantity integer not null default 0;
comment on column billing.items_billed.field_quantity is 'special field for a small number of items on Medicare Online: radiotherapy, and certain anaesthetic items';


alter table contacts.data_numbers add column payee_provider_number text;
alter table contacts.data_numbers add constraint "payee_pn_is_alphanumber" CHECK (payee_provider_number ~ '^[0-9]{5,7}[A-Z]{1,2}$'::text);

create or replace view admin.vwstaffinclinics as SELECT DISTINCT ON (staff.pk, clinics.pk) (staff.pk || '-'::text) || data_addresses.pk AS pk_view,
    (data_persons.firstname || ' '::text) || data_persons.surname AS wholename,
    staff.fk_person,
    staff.fk_role,
    staff.fk_status,
    staff.logon_name,
    employee_numbers.provider_number,
    data_numbers_persons.prescriber_number,
    staff.fk_lu_staff_type,
    staff.logon_date_from,
    staff.logon_date_to,
    link_staff_clinics1.fk_staff,
    link_staff_clinics1.fk_clinic,
    clinics.fk_branch,
    data_branches.branch,
    data_branches.fk_organisation,
    data_branches.fk_address,
    data_branches.memo AS branch_memo,
    data_branches.fk_category AS branch_category,
    data_branches.deleted AS branch_deleted,
    data_employees.pk AS fk_employee,
    data_employees.fk_occupation,
    data_employees.memo AS employee_memo,
    data_employees.deleted AS employee_deleted,
    data_persons.firstname,
    data_persons.surname,
    data_persons.salutation,
    data_persons.birthdate,
    data_persons.fk_ethnicity,
    data_persons.fk_language,
    data_persons.memo AS person_memo,
    data_persons.fk_marital,
    data_persons.fk_title,
    data_persons.fk_sex,
    data_persons.country_code AS person_country_code,
    data_persons.fk_image,
    data_persons.retired,
    data_persons.deleted AS person_deleted,
    data_persons.deceased,
    data_persons.date_deceased,
    lu_title.title,
    lu_marital.marital,
    lu_sex.sex,
    lu_occupations.occupation,
    lu_ethnicity.ethnicity,
    lu_languages.language,
    images.image,
    images.md5sum,
    images.tag,
    images.fk_consult AS fk_consult_image,
    images.deleted AS image_deleted,
    lu_staff_roles.role,
    lu_staff_type.type AS staff_type,
    lu_employee_status.status,
    data_organisations.organisation,
    data_organisations.deleted AS organisation_deleted,
    data_addresses.street1,
    data_addresses.street2,
    data_addresses.fk_town,
    lu_address_types.type AS address_type,
    data_addresses.preferred_address,
    data_addresses.postal_address,
    data_addresses.head_office,
    data_addresses.geolocation,
 data_addresses.country_code,
    data_addresses.fk_lu_address_type,
    data_addresses.deleted AS address_deleted,
    lu_towns.postcode,
    lu_towns.town,
    lu_towns.state,
    link_staff_clinics1.pk AS fk_link_staff_clinic,
    staff.qualifications,
    data_persons.surname_normalised,
    data_numbers_persons.hpii,
    org_numbers.hpio,
    org_numbers.hic_location_id,
    employee_numbers.australian_business_number,
    employee_numbers.payee_provider_number as payee_provider_number
   FROM admin.staff
     JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
     JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
     JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
     JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
     JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
     JOIN admin.lu_staff_type ON staff.fk_lu_staff_type = lu_staff_type.pk
     LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
     LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = staff.fk_person
     LEFT JOIN contacts.data_numbers employee_numbers ON employee_numbers.fk_branch = clinics.fk_branch AND employee_numbers.fk_person = staff.fk_person
     LEFT JOIN contacts.data_numbers org_numbers ON org_numbers.fk_person IS NULL AND clinics.fk_branch = org_numbers.fk_branch
     LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
     LEFT JOIN common.lu_ethnicity ON data_persons.fk_ethnicity = lu_ethnicity.pk
     LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
     LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
     JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
     JOIN contacts.lu_employee_status ON staff.fk_status = lu_employee_status.pk
     JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
     LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
     LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
     LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk;




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
    COALESCE((vworganisations.street1 || ' '::text) || vworganisations.street2, vworganisations.street1, (vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.street2, vwpersonsincludingpatients.street1) AS account_to_street,
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
    vp2.medicare_number AS account_to_medicare_number,
    vp2.medicare_ref_number AS account_to_medicare_ref_number,
    vp2.birthdate AS account_to_birthdate,
    staff_provider.payee_provider_number as payee_provider_number
   FROM billing.invoices
     JOIN admin.vwstaffinclinics staff_invoicing ON (invoices.fk_staff_invoicing = staff_invoicing.fk_staff and invoices.fk_branch = staff_invoicing.fk_branch)
     JOIN admin.vwstaffinclinics staff_provider ON (invoices.fk_staff_provided_service = staff_provider.fk_staff and invoices.fk_branch = staff_provider.fk_branch)
     JOIN contacts.vworganisations vworganisations1 ON invoices.fk_branch = vworganisations1.fk_branch
     LEFT JOIN clerical.bookings ON invoices.fk_appointment = bookings.pk
     LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
     LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
     LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient
     LEFT JOIN billing.claims ON invoices.fk_claim = claims.pk
     LEFT JOIN billing.lu_codes c1 ON invoices.result_code = c1.code
     LEFT JOIN billing.lu_codes c2 ON claims.result_code = c2.code
     LEFT JOIN contacts.vwpatients vp2 ON invoices.fk_payer_person = vp2.fk_person;



create or replace view billing.vwitemsbilled as
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
    items_billed.field_quantity  
   FROM billing.items_billed
     JOIN billing.lu_billing_type ON lu_billing_type.pk = items_billed.fk_lu_billing_type
     JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
     LEFT JOIN billing.lu_codes ON items_billed.reason_code = lu_codes.code;

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
    vwinvoices.claimant_address_upload,
    vwitemsbilled.number_of_patients,
    vwitemsbilled.multiple_procedure,
    vwitemsbilled.aftercare,
    vwitemsbilled.duplicate,
    vwitemsbilled.separate_sites,
    vwitemsbilled.not_related,
    vwitemsbilled.procedure_duration,
    vwitemsbilled.field_quantity,
    vwinvoices.payee_provider_number as payee_provider_number
   FROM billing.vwitemsbilled,
    billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice;

alter table billing.fee_schedule alter column number_of_patients set default 0;
update billing.fee_schedule set number_of_patients = 0 where mbs_item <> '4';

update db.lu_version set lu_minor=423;
