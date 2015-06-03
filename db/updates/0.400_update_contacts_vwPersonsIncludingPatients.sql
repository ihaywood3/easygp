DROP VIEW contacts.vwpersonsincludingpatients cascade;

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person,
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view,
    addresses.pk AS fk_address,
    ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname AS wholename,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age,
    marital.marital,
    sex.sex,
    title.title,
    countries.country,
    languages.language,
    countries1.country AS country_birth,
    ethnicity.ethnicity,
    addresses.street1,
    addresses.street2,
    towns.town,
    towns.state,
    towns.postcode,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.geolocation,
    addresses.country_code,
    addresses.fk_lu_address_type AS fk_address_type,
    addresses.deleted AS address_deleted,
    persons.fk_ethnicity,
    persons.fk_language,
    persons.language_problems,
    persons.memo,
    persons.fk_marital,
    persons.country_code AS country_birth_country_code,
    persons.fk_title,
    persons.deceased,
    persons.date_deceased,
    persons.fk_sex,
    images.pk AS fk_image,
    images.image,
    images.md5sum,
    images.tag,
    images.fk_consult AS fk_consult_image,
    persons.surname_normalised,
    data_patients.pk AS fk_patient
   FROM contacts.data_persons persons
     LEFT JOIN clerical.data_patients ON persons.pk = data_patients.fk_person
     LEFT JOIN contacts.links_persons_addresses ON persons.pk = links_persons_addresses.fk_person
     LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
     LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
     LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
     LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
     LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
     LEFT JOIN blobs.images ON persons.fk_image = images.pk
     LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
     LEFT JOIN contacts.data_addresses addresses ON links_persons_addresses.fk_address = addresses.pk
     LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
     LEFT JOIN common.lu_countries countries1 ON addresses.country_code = countries1.country_code;

ALTER TABLE contacts.vwpersonsincludingpatients  OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients   IS 'a view of all persons including those who are patients';

--view billing.vwdaylist depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW billing.vwdaylist AS 
 SELECT (bookings.pk || '-'::text) || items_billed.pk AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    data_patients.fk_lu_centrelink_card_type,
    invoices.pk AS fk_invoice,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.latex,
    invoices.total_bill,
    invoices.total_gst,
    invoices.total_paid,
    invoices.fk_staff_provided_service,
    invoices.fk_lu_bulk_billing_type,
    lu_bulk_billing_type.type AS bulk_billing_type,
    bookings.begin AS appointment_date,
    COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
    fee_schedule.descriptor_brief,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.pk AS fk_items_billed,
    payments_received.fk_lu_payment_method,
    payments_received.amount AS payment_amount,
    lu_billing_type.type AS billing_type,
    lu_payment_method.method AS payment_method,
    NULL::text AS reason_not_billed,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    clinics.fk_branch
   FROM clerical.bookings
     JOIN billing.invoices ON invoices.fk_appointment = bookings.pk
     JOIN admin.clinics ON bookings.fk_clinic = clinics.pk
     JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     LEFT JOIN billing.lu_bulk_billing_type ON invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk
     JOIN billing.items_billed ON invoices.pk = items_billed.fk_invoice
     JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
     JOIN billing.lu_billing_type ON items_billed.fk_lu_billing_type = lu_billing_type.pk
     LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
     LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN billing.payments_received ON invoices.pk = payments_received.fk_invoice
     LEFT JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
  WHERE bookings.fk_lu_reason_not_billed IS NULL
UNION
 SELECT (bookings.pk || '-'::text) || '0'::text AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    NULL::integer AS fk_lu_centrelink_card_type,
    NULL::integer AS fk_invoice,
    NULL::boolean AS paid,
    NULL::integer AS fk_payer_person,
    NULL::integer AS fk_payer_branch,
    NULL::text AS latex,
    NULL::money AS total_bill,
    NULL::money AS total_gst,
    NULL::money AS total_paid,
    bookings.fk_staff AS fk_staff_provided_service,
    NULL::integer AS fk_lu_bulk_billing_type,
    NULL::text AS bulk_billing_type,
    bookings.begin AS appointment_date,
    NULL::text AS item,
    NULL::text AS descriptor_brief,
    NULL::money AS amount,
    NULL::money AS amount_gst,
    NULL::integer AS fk_items_billed,
    NULL::integer AS fk_lu_payment_method,
    NULL::money AS payment_amount,
    NULL::text AS billing_type,
    NULL::text AS payment_method,
    lu_reasons_not_billed.reason AS reason_not_billed,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    NULL::text AS account_to_name,
    clinics.fk_branch
   FROM clerical.bookings
     JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     JOIN admin.clinics ON bookings.fk_clinic = clinics.pk
     LEFT JOIN billing.lu_reasons_not_billed ON bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  WHERE bookings.fk_lu_reason_not_billed IS NOT NULL;

ALTER TABLE billing.vwdaylist   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwdaylist TO easygp;
GRANT ALL ON TABLE billing.vwdaylist TO staff;

--view billing.vwpaymentsreceived depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW billing.vwpaymentsreceived AS 
 SELECT payments_received.pk AS pk_view,
    payments_received.pk AS fk_payment_received,
    payments_received.date_paid,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS patient_wholename,
    payments_received.fk_invoice,
    payments_received.referent,
    payments_received.amount,
    payments_received.fk_lu_payment_method,
    payments_received.fk_staff_receipted,
    lu_payment_method.method AS payment_method,
    invoices.fk_patient,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.fk_staff_provided_service,
    invoices.fk_branch AS fk_clinic_branch,
    invoices.visit_date,
    invoices.latex,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title
   FROM billing.payments_received
     JOIN billing.lu_payment_method ON payments_received.fk_lu_payment_method = lu_payment_method.pk
     JOIN billing.invoices ON payments_received.fk_invoice = invoices.pk
     LEFT JOIN clerical.data_patients ON invoices.fk_patient = data_patients.pk
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
     LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person;

ALTER TABLE billing.vwpaymentsreceived   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwpaymentsreceived TO easygp;
GRANT ALL ON TABLE billing.vwpaymentsreceived TO staff;

--view clin_history.vwsocialhistory depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory,
    sh.fk_consult,
    consult.fk_patient,
    sh.history,
    sh.deleted,
    sh.fk_responsible_person,
    sh.responsible_person,
    sh.responsible_person_street1,
    sh.responsible_person_street2,
    sh.responsible_person_town,
    sh.responsible_person_state,
    sh.responsible_person_postcode,
    sh.responsible_person_contacts,
    sh.country_code,
    sh.do_not_print_confidential_notes,
    sh.fk_staff_may_view_confidential,
    sh.restrict_view_to_roles,
    sh.history_confidential,
    sh.fk_progressnote,
    sh.fk_progressnote_confidential,
    lu_countries.country,
    sh.responsible_person_notes,
    vwpersonsincludingpatients.title AS person_responsible_title,
    vwpersonsincludingpatients.firstname AS person_responsible_firstname,
    vwpersonsincludingpatients.surname AS person_responsible_surname,
    vwpersonsincludingpatients.wholename AS person_responsible_wholename,
    vwpersonsincludingpatients.street1 AS person_responsible_street1,
    vwpersonsincludingpatients.street2 AS person_responsible_street2,
    vwpersonsincludingpatients.town AS person_responsible_town,
    vwpersonsincludingpatients.postcode AS person_responsible_postcode,
    vwpersonsincludingpatients.state AS person_responsible_state,
    vwpersonsincludingpatients.fk_town AS patient_fk_town,
    vwstaff.wholename AS staff_may_view_confidential_wholename
   FROM clin_history.social_history sh
     JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
     LEFT JOIN contacts.vwpersonsincludingpatients ON vwpersonsincludingpatients.fk_person = sh.fk_responsible_person
     LEFT JOIN common.lu_countries ON lu_countries.country_code::text = sh.country_code
     LEFT JOIN admin.vwstaff ON vwstaff.fk_staff = sh.fk_staff_may_view_confidential
  WHERE sh.deleted = false;

ALTER TABLE clin_history.vwsocialhistory   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO easygp;
GRANT SELECT ON TABLE clin_history.vwsocialhistory TO staff;
COMMENT ON VIEW clin_history.vwsocialhistory
  IS 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null/0 then we keep the responsible person
    address as given in a straight text field
    Anyway, two types of social history:
    i)  The ordinary history which if made public is not of great consequence
    ii) The confidential history which if made public could be disasterous
        hence this is restricted by default to a role or to a fk_staff 
        if only the doctor entering the information gets to see this';

--view clin_history.vwresponsiblepersons depends on view clin_history.vwsocialhistory
CREATE OR REPLACE VIEW clin_history.vwresponsiblepersons AS 
 SELECT vwpatients.surname,
    vwpatients.firstname,
    vwsocialhistory.responsible_person,
    vwsocialhistory.fk_responsible_person,
    vwsocialhistory.person_responsible_wholename,
    vwsocialhistory.history,
    vwpatients.active_status,
    vwpatients.age_numeric,
    vwpatients.deceased
   FROM clin_history.vwsocialhistory,
    contacts.vwpatients
  WHERE vwsocialhistory.fk_patient = vwpatients.fk_patient AND vwpatients.age_numeric < 90::double precision AND vwpatients.active_status = 'active'::text AND vwpatients.deceased = false AND vwpatients.person_deleted = false;

ALTER TABLE clin_history.vwresponsiblepersons   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwresponsiblepersons TO easygp;
GRANT SELECT ON TABLE clin_history.vwresponsiblepersons TO staff;

--view clin_mentalhealth.vwteamcaremembers depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
 SELECT team_care_members.fk_team_care_arrangement,
    team_care_members.pk,
    team_care_members.pk AS fk_team_care_member,
    team_care_members.fk_branch,
    team_care_members.fk_employee,
    team_care_members.fk_person,
    team_care_members.fk_document_tca,
    team_care_members.health_issue_keys,
    team_care_members.family_history_keys,
    team_care_members.fk_provider_of_care,
    team_care_members.num_epc_sessions,
    team_care_members.fk_lu_allied_health_care_type,
    team_care_members.fk_document_allied_health_form,
    team_care_members.latex_allied_health_form,
    team_care_members.fk_document_gp_management_plan,
    team_care_members.special_note,
    team_care_members.progress_towards_goals,
    team_care_members.deleted,
    lu_allied_health_care_types.type AS allied_health_care_type,
    documents.source_file AS filename
   FROM clin_history.team_care_members
     LEFT JOIN clin_history.lu_allied_health_care_types ON team_care_members.fk_lu_allied_health_care_type = lu_allied_health_care_types.pk
     LEFT JOIN documents.documents ON team_care_members.fk_document_allied_health_form = documents.pk;

ALTER TABLE clin_history.vwteamcaremembers   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT SELECT ON TABLE clin_history.vwteamcaremembers TO staff;

--view clin_referrals.vwreferrals depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_pasthistory,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    vworganisationsemployees.wholename,
    vworganisationsemployees.occupation,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.salutation,
    vworganisationsemployees.sex,
    vworganisationsemployees.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    past_history.description,
    vworganisationsemployees.provider_number AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_pasthistory,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vwpersonsincludingpatients.street1,
    vwpersonsincludingpatients.street2,
    vwpersonsincludingpatients.town,
    vwpersonsincludingpatients.state,
    vwpersonsincludingpatients.postcode,
    NULL::text AS organisation,
    NULL::text AS branch,
    vwpersonsincludingpatients.wholename,
    NULL::text AS occupation,
    vwpersonsincludingpatients.firstname,
    vwpersonsincludingpatients.surname,
    vwpersonsincludingpatients.salutation,
    vwpersonsincludingpatients.sex,
    vwpersonsincludingpatients.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    past_history.description,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_pasthistory,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    NULL::text AS wholename,
    NULL::text AS occupation,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS salutation,
    NULL::text AS sex,
    NULL::text AS title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    past_history.description,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
     LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;

--view billing.vwinvoices depends on view contacts.vwpersonsincludingpatients
CREATE OR REPLACE VIEW billing.vwinvoices AS 
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
    COALESCE(COALESCE(vworganisations.street1 || ' '::text, vworganisations.street2 || ' '::text), COALESCE(vwpersonsincludingpatients.street1 || ' '::text, vwpersonsincludingpatients.street2 || ' '::text)) AS account_to_street,
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
    c2.description AS claim_description
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
     LEFT JOIN billing.lu_codes c2 ON claims.result_code = c2.code;

ALTER TABLE billing.vwinvoices   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwinvoices TO easygp;
GRANT SELECT ON TABLE billing.vwinvoices TO staff;

--view billing.vwitemsandinvoices depends on view billing.vwinvoices
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
    vwinvoices.claim_date
   FROM billing.vwitemsbilled,
    billing.vwinvoices
  WHERE vwinvoices.fk_invoice = vwitemsbilled.fk_invoice;

ALTER TABLE billing.vwitemsandinvoices   OWNER TO easygp;
GRANT ALL ON TABLE billing.vwitemsandinvoices TO easygp;
GRANT SELECT ON TABLE billing.vwitemsandinvoices TO staff;

update db.lu_version set lu_minor=400;
