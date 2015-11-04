
-- IAN WE REMOVED THESE FIELDS DURING AN UPDATEALTER TABLE clin_prescribing.prescribed_for_habits add constraint "prescribed_for_habits_fk_brand_fkey" foreign key (fk_brand) references  drugs.brand(pk);
-- IAN WE DELETED THIS DURING THE UPDATES ALTER TABLE chronic_disease_management.team_care_arrangements add constraint "team_care_arrangements_fk_organisation_fkey" foreign key (fk_organisation) references contacts.data_organisations (pk);
-- IAN WE DELETED THIS DURING UPDATES RECENTLY ALTER TABLE defaults.script_coordinates add constraint "script_coordinates_fk_lu_printer_host_fkey" foreign key (fk_lu_printer_host) references  defaults.lu_printer_host (pk);
-- IAN THIS TABLE WAS DELETED IN OUR RECENT UPDATES : ALTER TABLE chronic_disease_management.team_care_arrangements add constraint "team_care_arrangements_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
-- IAN THIS TABLE WAS DELETED IN OUR RECENT UPDATES : ALTER TABLE chronic_disease_management.team_care_arrangements add constraint "team_care_arrangements_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
-- IAN THIS TABLE WAS DELETED IN OUR RECENT UPDATES : ALTER TABLE defaults.lu_printer_host add constraint "lu_printer_host_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
-- IAN THIS FIELD WAS DROPPED DURING OUR CONSTRAINT WORKS ALTER TABLE clin_consult.lu_shortcut add constraint "lu_shortcut_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
-- IAN ?MUST BE FIXED drugs.company has no primary key ALTER TABLE drugs.brand add constraint "brand_fk_company_fkey" foreign key (fk_company) references drugs.company (pk);
-- IAN WE HAVE DELETED THIS TABLE ALTER TABLE defaults.lu_link_printer_task add constraint "lu_link_printer_task_fk_lu_printer_host_fkey" foreign key (fk_lu_printer_host) references  defaults.lu_printer_host(pk);
-- IAN WE HAVE DELETED THIS TABLE ALTER TABLE defaults.lu_link_printer_task add constraint "lu_link_printer_task_fk_task_fkey" foreign key (fk_task) references defaults.lu_printer_task(pk);
-- IAN WE HAVE DELETED THIS FELD FROM THE BACKEND ALTER TABLE clin_requests.lu_requests add constraint "lu_requests_fk_instruction_fkey" foreign key (fk_instruction) references clin_requests.lu_instructions (pk);
-- AN WE HAVE DELETED THIS FIELD  ALTER TABLE clin_prescribing.instruction_habits add constraint "instruction_habits_fk_generic_product_fkey" foreign key (fk_generic_product) references drugs.product (pk);
-------------------------------------------------------------------------------
--- ** Special case to consider THE CODING.GENERIC_TERMS NEEDS A PRIMARY KEY\
---
-- ALTER TABLE clin_history.health_issue_templates add constraint "health_issue_templates_fk_code_fkey" foreign key (fk_code) references  coding.generic_terms(code);
-- coding.generic_terms does not have a primary key. While it is possible to create a composite primary key constraint (code, coding system),
-- the table referring to the foreign key would then also need TWO columns for the constraint. Much better to create a primary key!!
-- ALTER TABLE clin_workcover.visits add constraint "visits_fk_code_fkey" foreign key (fk_code) references   coding.generic_terms(pk);
---------------------------------------------------------------------------------------------------------------------------------------
insert into common.lu_ethnicity (pk,ethnicity) values (1, 'Not specified');
update clin_requests.lu_requests set fk_laterality = null where fk_laterality=0;


drop view admin.vwpreferences;
CREATE  VIEW admin.vwpreferences AS
 SELECT COALESCE(g.pk, lpd.pk) AS pk_view,
    g.fk_clinic,
    g.fk_staff,
    COALESCE(g.name, lpd.name) AS name,
    COALESCE(g.value, lpd.value) AS value,
    (lpd.check_dir IS TRUE) AS check_dir,
        CASE
            WHEN (lpd.check_dir IS TRUE) THEN admin.check_dir(COALESCE(g.value, lpd.value))
            ELSE false
        END AS server_dir
   FROM (admin.global_preferences g
     FULL JOIN admin.lu_preferences_defaults lpd USING (name));


CREATE or replace VIEW contacts.vworganisations AS
 SELECT DISTINCT ON (branches.pk) (branches.pk)::bigint AS pk_view,
    clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
    branches.branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    data_numbers.australian_business_number,
    vbc.value AS fax,
    data_numbers.hpio
   FROM ((((((((contacts.data_branches branches
     JOIN contacts.data_organisations organisations ON ((branches.fk_organisation = organisations.pk)))
     JOIN contacts.lu_categories categories ON ((branches.fk_category = categories.pk)))
     LEFT JOIN contacts.data_addresses addresses ON ((branches.fk_address = addresses.pk)))
     LEFT JOIN contacts.lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk)))
     LEFT JOIN contacts.lu_towns towns ON ((addresses.fk_town = towns.pk)))
     LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch)))
     LEFT JOIN contacts.data_numbers ON (((branches.pk = data_numbers.fk_branch) AND (data_numbers.fk_person IS NULL))))
     LEFT JOIN contacts.vwbranchescomms vbc ON (((branches.pk = vbc.fk_branch) AND (vbc.fk_type = 2))));

CREATE or replace VIEW contacts.vwpersonsincludingpatients AS
 SELECT persons.pk AS fk_person,
        CASE
            WHEN (addresses.pk is not null) THEN COALESCE(((persons.pk || '-'::text) || addresses.pk))
            ELSE (persons.pk || '-0'::text)
        END AS pk_view,
    addresses.pk AS fk_address,
    (((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname) AS wholename,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    date_part('year'::text, age((persons.birthdate)::timestamp with time zone)) AS age,
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
    data_patients.pk AS fk_patient,
    persons.qualifications AS person_qualifications
   FROM ((((((((((((contacts.data_persons persons
     LEFT JOIN clerical.data_patients ON ((persons.pk = data_patients.fk_person)))
     LEFT JOIN contacts.links_persons_addresses ON ((persons.pk = links_persons_addresses.fk_person)))
     LEFT JOIN contacts.lu_marital marital ON ((persons.fk_marital = marital.pk)))
     LEFT JOIN contacts.lu_sex sex ON ((persons.fk_sex = sex.pk)))
     LEFT JOIN common.lu_languages languages ON ((persons.fk_language = languages.pk)))
     LEFT JOIN contacts.lu_title title ON ((persons.fk_title = title.pk)))
     LEFT JOIN common.lu_ethnicity ethnicity ON ((persons.fk_ethnicity = ethnicity.pk)))
     LEFT JOIN blobs.images ON ((persons.fk_image = images.pk)))
     LEFT JOIN common.lu_countries countries ON ((persons.country_code = (countries.country_code)::text)))
     LEFT JOIN contacts.data_addresses addresses ON ((links_persons_addresses.fk_address = addresses.pk)))
     LEFT JOIN contacts.lu_towns towns ON ((addresses.fk_town = towns.pk)))
     LEFT JOIN common.lu_countries countries1 ON ((addresses.country_code = countries1.country_code)));


CREATE or replace VIEW contacts.vworganisationsemployees AS
 SELECT (((organisations.pk || '-'::text) || branches.pk) || '-0'::text) AS pk_view,
    clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
        CASE
            WHEN (lower(branches.branch) = 'head office'::text) THEN ''::text
            ELSE branches.branch
        END AS branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo AS branch_memo,
    NULL::text AS employee_memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    0 AS fk_employee,
    ((organisations.organisation || ' '::text) || branches.branch) AS wholename,
    0 AS fk_occupation,
    0 AS fk_status,
    NULL::text AS employee_status,
    false AS employee_deleted,
    NULL::text AS occupation,
    0 AS fk_person,
    NULL::text AS firstname,
    'aaaa'::text AS surname,
    NULL::text AS salutation,
    NULL::date AS birthdate,
    false AS deceased,
    NULL::date AS date_deceased,
    false AS retired,
    0 AS fk_ethnicity,
    0 AS fk_language,
    0 AS fk_marital,
    0 AS fk_title,
    0 AS fk_sex,
    NULL::text AS sex,
    NULL::text AS title,
    NULL::text AS surname_normalised,
    NULL::text AS provider_number,
    0 AS employees_fk_data_numbers,
    NULL::text AS prescriber_number,
    NULL::text AS hpii,
    0 AS fk_data_numbers_persons,
    organisations_numbers.australian_business_number,
    organisations_numbers.hpio,
    organisations_numbers.pk AS organisations_fk_data_numbers,
    NULL::text AS person_qualifications
   FROM (((((((contacts.data_branches branches
     JOIN contacts.data_organisations organisations ON ((branches.fk_organisation = organisations.pk)))
     JOIN contacts.lu_categories categories ON ((branches.fk_category = categories.pk)))
     LEFT JOIN contacts.data_addresses addresses ON ((branches.fk_address = addresses.pk)))
     LEFT JOIN contacts.lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk)))
     LEFT JOIN contacts.lu_towns towns ON ((addresses.fk_town = towns.pk)))
     LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch)))
     LEFT JOIN contacts.data_numbers organisations_numbers ON (((branches.pk = organisations_numbers.fk_branch) AND (organisations_numbers.fk_person IS NULL))))
UNION
 SELECT ((((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk) AS pk_view,
    clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
        CASE
            WHEN (lower(branches.branch) = 'head office'::text) THEN ''::text
            ELSE branches.branch
        END AS branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo AS branch_memo,
    employees.memo AS employee_memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    employees.pk AS fk_employee,
        CASE
            WHEN (employees.pk is not null) THEN (((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname)
            ELSE 'Nothing'::text
        END AS wholename,
    employees.fk_occupation,
    employees.fk_status,
    employee_status.status AS employee_status,
    employees.deleted AS employee_deleted,
    occupations.occupation,
    persons.pk AS fk_person,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    persons.deceased,
    persons.date_deceased,
    persons.retired,
    persons.fk_ethnicity,
    persons.fk_language,
    persons.fk_marital,
    persons.fk_title,
    persons.fk_sex,
    sex.sex,
    title.title,
    persons.surname_normalised,
    employee_numbers.provider_number,
    employee_numbers.pk AS employees_fk_data_numbers,
    data_numbers_persons.prescriber_number,
    data_numbers_persons.hpii,
    data_numbers_persons.pk AS fk_data_numbers_persons,
    organisations_numbers.australian_business_number,
    organisations_numbers.hpio,
    organisations_numbers.pk AS organisations_fk_data_numbers,
    persons.qualifications AS person_qualifications
   FROM (((((((((((((((contacts.data_employees employees
     JOIN contacts.data_branches branches ON ((employees.fk_branch = branches.pk)))
     JOIN contacts.lu_categories categories ON ((branches.fk_category = categories.pk)))
     LEFT JOIN contacts.lu_employee_status employee_status ON ((employees.fk_status = employee_status.pk)))
     JOIN contacts.data_organisations organisations ON ((branches.fk_organisation = organisations.pk)))
     LEFT JOIN contacts.data_addresses addresses ON ((branches.fk_address = addresses.pk)))
     LEFT JOIN contacts.lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk)))
     LEFT JOIN contacts.lu_towns towns ON ((addresses.fk_town = towns.pk)))
     LEFT JOIN common.lu_occupations occupations ON ((employees.fk_occupation = occupations.pk)))
     LEFT JOIN contacts.data_persons persons ON ((employees.fk_person = persons.pk)))
     LEFT JOIN contacts.lu_title title ON ((persons.fk_title = title.pk)))
     LEFT JOIN contacts.lu_sex sex ON ((persons.fk_sex = sex.pk)))
     LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch)))
     LEFT JOIN contacts.data_numbers employee_numbers ON (((employees.fk_person = employee_numbers.fk_person) AND (branches.pk = employee_numbers.fk_branch))))
     LEFT JOIN contacts.data_numbers_persons ON ((employees.fk_person = data_numbers_persons.fk_person)))
     LEFT JOIN contacts.data_numbers organisations_numbers ON (((branches.pk = organisations_numbers.fk_branch) AND (organisations_numbers.fk_person IS NULL))))
  WHERE (employees.fk_person IS NOT NULL);


ALTER TABLE contacts.vworganisationsemployees OWNER TO easygp;



CREATE or replace VIEW contacts.vwpersons AS
 SELECT data_persons.pk AS fk_person,
        CASE
            WHEN ("Addresses".pk is not null) THEN COALESCE(((data_persons.pk || '-'::text) || "Addresses".pk))
            ELSE (data_persons.pk || '-0'::text)
        END AS pk_view,
    (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || data_persons.surname) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    data_persons.salutation,
    data_persons.birthdate,
    data_persons.fk_ethnicity,
    data_persons.fk_language,
    data_persons.language_problems,
    data_persons.memo,
    data_persons.fk_marital,
    data_persons.fk_title,
    data_persons.fk_sex,
    data_persons.fk_image,
    data_persons.fk_occupation,
    data_persons.retired,
    data_persons.deceased,
    data_persons.date_deceased,
    data_persons.deleted,
    lu_sex.sex,
    lu_sex.sex_text,
    lu_title.title,
    lu_marital.marital,
    lu_occupations.occupation,
    lu_languages.language,
    lu_countries.country,
    links_persons_addresses.pk AS fk_link_address,
    links_persons_addresses.fk_address,
    lu_towns.postcode,
    lu_towns.town,
    lu_towns.state,
    data_persons.country_code,
    "Addresses".street1,
    "Addresses".street2,
    "Addresses".fk_town,
    "Addresses".fk_lu_address_type,
    lu_address_types.type AS address_type,
    "Addresses".preferred_address,
    "Addresses".postal_address,
    "Addresses".head_office,
    "Addresses".geolocation,
    "Addresses".deleted AS address_deleted,
    images.image,
    data_persons.surname_normalised,
    data_numbers.provider_number,
    data_numbers_persons.hpii,
    data_numbers.hpio,
    data_numbers.pk AS pk_data_numbers,
    data_numbers_persons.pk AS pk_data_numbers_persons,
    data_persons.qualifications AS person_qualifications
   FROM (((((((((((((contacts.data_persons
     LEFT JOIN contacts.lu_sex ON ((data_persons.fk_sex = lu_sex.pk)))
     LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk)))
     LEFT JOIN contacts.lu_marital ON ((data_persons.fk_marital = lu_marital.pk)))
     LEFT JOIN common.lu_occupations ON ((data_persons.fk_occupation = lu_occupations.pk)))
     LEFT JOIN common.lu_languages ON ((data_persons.fk_language = lu_languages.pk)))
     LEFT JOIN blobs.images ON ((data_persons.fk_image = images.pk)))
     LEFT JOIN contacts.links_persons_addresses ON ((data_persons.pk = links_persons_addresses.fk_person)))
     LEFT JOIN common.lu_countries ON ((data_persons.country_code = (lu_countries.country_code)::text)))
     LEFT JOIN contacts.data_addresses "Addresses" ON ((links_persons_addresses.fk_address = "Addresses".pk)))
     LEFT JOIN contacts.lu_address_types ON (("Addresses".fk_lu_address_type = lu_address_types.pk)))
     LEFT JOIN contacts.lu_towns ON (("Addresses".fk_town = lu_towns.pk)))
     LEFT JOIN contacts.data_numbers ON (((data_persons.pk = data_numbers.fk_person) AND (data_numbers.fk_branch IS NULL))))
     LEFT JOIN contacts.data_numbers_persons ON ((data_persons.pk = data_numbers_persons.fk_person)));


ALTER TABLE contacts.vwpersons OWNER TO easygp;


CREATE or replace VIEW clin_requests.vwrequestproviders AS
 SELECT request_providers.pk AS pk_request_provider,
    lu_request_type.type,
    request_providers.fk_headoffice_branch,
    request_providers.fk_default_branch,
    request_providers.fk_employee,
    request_providers.fk_person,
    request_providers.fk_lu_request_type,
    request_providers.deleted AS request_provider_deleted,
    request_providers.staff_default,
    data_organisations.organisation,
    lu_categories.category,
    data_branches.branch AS headoffice_branch,
    data_branches.fk_organisation,
    data_branches.deleted AS headoffice_branch_deleted,
    data_addresses.street1 AS headoffice_street1,
    data_addresses.street2 AS headoffice_street2,
    data_addresses.deleted AS headoffice_address_deleted,
    lu_towns.postcode AS headoffice_postcode,
    lu_towns.town AS headoffice_town,
    lu_towns.state AS headoffice_state,
    NULL::text AS wholename,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS salutation,
    0 AS fk_title,
    NULL::text AS title,
    0 AS fk_sex,
    NULL::text AS sex,
    0 AS fk_occupation,
    NULL::text AS occupation,
    data_branches1.branch AS default_branch,
    data_addresses1.street1 AS default_branch_street1,
    data_addresses1.street2 AS default_branch_street2,
    lu_towns1.postcode AS default_branch_postcode,
    lu_towns1.town AS default_branch_town,
    lu_towns1.state AS default_branch_state
   FROM (((((((((clin_requests.request_providers
     JOIN contacts.data_branches ON ((request_providers.fk_headoffice_branch = data_branches.pk)))
     JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk)))
     JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk)))
     JOIN clin_requests.lu_request_type ON ((request_providers.fk_lu_request_type = lu_request_type.pk)))
     LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk)))
     LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk)))
     JOIN contacts.data_branches data_branches1 ON ((request_providers.fk_default_branch = data_branches1.pk)))
     LEFT JOIN contacts.data_addresses data_addresses1 ON ((data_branches1.fk_address = data_addresses1.pk)))
     LEFT JOIN contacts.lu_towns lu_towns1 ON ((data_addresses1.fk_town = lu_towns1.pk)))
  WHERE ((request_providers.fk_employee is null) AND (request_providers.fk_person is null))
UNION
 SELECT request_providers.pk AS pk_request_provider,
    lu_request_type.type,
    request_providers.fk_headoffice_branch,
    request_providers.fk_default_branch,
    request_providers.fk_employee,
    request_providers.fk_person,
    request_providers.fk_lu_request_type,
    request_providers.deleted AS request_provider_deleted,
    request_providers.staff_default,
    NULL::text AS organisation,
    NULL::character varying AS category,
    'HEAD OFFICE'::text AS headoffice_branch,
    null AS fk_organisation,
    NULL::boolean AS headoffice_branch_deleted,
    vwpersons.street1 AS headoffice_street1,
    vwpersons.street2 AS headoffice_street2,
    NULL::boolean AS headoffice_address_deleted,
    vwpersons.postcode AS headoffice_postcode,
    vwpersons.town AS headoffice_town,
    vwpersons.state AS headoffice_state,
    vwpersons.wholename,
    vwpersons.firstname,
    vwpersons.surname,
    vwpersons.salutation,
    vwpersons.fk_title,
    vwpersons.title,
    vwpersons.fk_sex,
    vwpersons.sex,
    vwpersons.fk_occupation,
    vwpersons.occupation,
    NULL::text AS default_branch,
    vwpersons.street1 AS default_branch_street1,
    vwpersons.street2 AS default_branch_street2,
    vwpersons.postcode AS default_branch_postcode,
    vwpersons.town AS default_branch_town,
    vwpersons.state AS default_branch_state
   FROM ((clin_requests.request_providers
     JOIN clin_requests.lu_request_type ON ((request_providers.fk_lu_request_type = lu_request_type.pk)))
     JOIN contacts.vwpersons ON ((request_providers.fk_person = vwpersons.fk_person)))
  WHERE (request_providers.fk_person is not null);

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
ALTER TABLE contacts.data_employees add constraint "fk_branch_fkey" FOREIGN KEY (fk_branch) REFERENCES contacts.data_branches(pk);
ALTER TABLE clin_workcover.claims add constraint "claims_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE clin_workcover.claims add constraint "claims_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_workcover.claims add constraint "claims_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_workcover.claims add constraint "claims_fk_occupation_fkey" foreign key (fk_occupation) references common.lu_occupations (pk);
ALTER TABLE blobs.images add constraint "images_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_consult.consult add constraint "consult_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_consult.consult add constraint "consult_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_pasthistory_fkey" foreign key (fk_pasthistory) references clin_history.past_history (pk);
ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_history.recreational_drugs add constraint "recreational_drugs_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE coding.generic_terms add constraint "generic_terms_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE clin_history.past_history add constraint "past_history_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_history.past_history add constraint "past_history_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE clin_history.past_history add constraint "past_history_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_procedures.surgical_packs add constraint "surgical_packs_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_procedures.surgical_packs add constraint "surgical_packs_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE clin_vaccination.vaccinations add constraint "vaccinations_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_measurements.patients_defaults add constraint "patients_defaults_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
ALTER TABLE clin_consult.lu_audit_reasons add constraint "lu_audit_reasons_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE chronic_disease_management.patients_with_hba1c_not_diabetic add constraint "patients_with_hba1c_not_diabetic_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
ALTER TABLE admin.link_staff_clinics add constraint "link_staff_clinics_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE admin.link_staff_clinics add constraint "link_staff_clinics_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services add constraint "diabetes_group_allied_health_services_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services add constraint "diabetes_group_allied_health_services_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services add constraint "diabetes_group_allied_health_services_fk_document_form_fkey" foreign key (fk_document_form) references documents.documents (pk);
ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services add constraint "diabetes_group_allied_health_services_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services add constraint "diabetes_group_allied_health_services_fk_document_history_items_fkey" foreign key (fk_document_history_items) references documents.documents (pk);
ALTER TABLE clin_certificates.medical_certificates add constraint "medical_certificates_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_certificates.medical_certificates add constraint "medical_certificates_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE clin_certificates.medical_certificates add constraint "medical_certificates_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE documents.documents add constraint "documents_fk_staff_destination_fkey" foreign key (fk_staff_destination) references admin.staff (pk);
ALTER TABLE documents.documents add constraint "documents_fk_staff_filed_document_fkey" foreign key (fk_staff_filed_document) references admin.staff (pk);
ALTER TABLE documents.documents add constraint "documents_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
ALTER TABLE clin_history.family_conditions add constraint "family_conditions_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_history.family_conditions add constraint "family_conditions_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_history.family_members add constraint "family_members_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE clin_history.family_members add constraint "family_members_fk_occupation_fkey" foreign key (fk_occupation) references common.lu_occupations (pk);
ALTER TABLE clin_history.family_members add constraint "family_members_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_measurements.inr_dose_management add constraint "inr_dose_management_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_prescribing.authority_script_number add constraint "authority_script_number_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE admin.clinics add constraint "clinics_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_history.occupational_history add constraint "occupational_history_fk_occupation_fkey" foreign key (fk_occupation) references common.lu_occupations (pk);
ALTER TABLE clin_history.occupational_history add constraint "occupational_history_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_history.occupational_history add constraint "occupational_history_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_allergies.allergies add constraint "allergies_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE admin.staff_clinical_toolbar add constraint "staff_clinical_toolbar_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_requests.lu_form_header add constraint "lu_form_header_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clerical.inventory add constraint "inventory_fk_person_purchased_from_fkey" foreign key (fk_person_purchased_from) references contacts.data_persons (pk);
ALTER TABLE clerical.inventory add constraint "inventory_fk_employee_purchased_from_fkey" foreign key (fk_employee_purchased_from) references contacts.data_employees (pk);
ALTER TABLE clerical.inventory add constraint "inventory_fk_branch_purchased_from_fkey" foreign key (fk_branch_purchased_from) references contacts.data_branches (pk);
ALTER TABLE clin_prescribing.prescribed add constraint "prescribed_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_history.occupations_exposures add constraint "occupations_exposures_fk_occupational_history_fkey" foreign key (fk_occupational_history) references common.lu_occupations (pk);
ALTER TABLE clin_procedures.lu_last_surgical_pack add constraint "lu_last_surgical_pack_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE clin_history.social_history add constraint "social_history_fk_progressnote_confidential_fkey" foreign key (fk_progressnote_confidential) references clin_consult.progressnotes (pk);
ALTER TABLE clin_history.social_history add constraint "social_history_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_prescribing.prescribed_for_habits add constraint "prescribed_for_habits_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_recalls.lu_recall_intervals add constraint "lu_recall_intervals_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_requests.user_default_type add constraint "user_default_type_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_pasthistory_fkey" foreign key (fk_pasthistory) references clin_history.past_history (pk);
ALTER TABLE admin.tips_seen add constraint "tips_seen_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE coding.usr_codes_weighting add constraint "usr_codes_weighting_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE coding.usr_codes_weighting add constraint "usr_codes_weighting_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_document_fkey" foreign key (fk_document) references documents.documents (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_pasthistory_fkey" foreign key (fk_pasthistory) references clin_history.past_history (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_progressnote_user_fkey" foreign key (fk_progressnote_user) references clin_consult.progressnotes (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clerical.task_component_notes add constraint "task_component_notes_fk_staff_made_note_fkey" foreign key (fk_staff_made_note) references admin.staff (pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE admin.clinic_rooms add constraint "clinic_rooms_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE billing.invoices add constraint "invoices_fk_staff_invoicing_fkey" foreign key (fk_staff_invoicing) references admin.staff (pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_staff_filed_fkey" foreign key (fk_staff_filed) references admin.staff (pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_staff_allocated_fkey" foreign key (fk_staff_allocated) references admin.staff (pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_staff_completed_fkey" foreign key (fk_staff_completed) references admin.staff (pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clerical.tasks add constraint "tasks_fk_staff_must_finalise_fkey" foreign key (fk_staff_must_finalise) references admin.staff (pk);
ALTER TABLE clerical.tasks add constraint "tasks_fk_staff_finalised_task_fkey" foreign key (fk_staff_finalised_task) references admin.staff (pk);
ALTER TABLE clerical.tasks add constraint "tasks_fk_staff_filed_task_fkey" foreign key (fk_staff_filed_task) references admin.staff (pk);
ALTER TABLE documents.observations add constraint "observations_fk_document_fkey" foreign key (fk_document) references documents.documents (pk);
ALTER TABLE clin_recalls.sent add constraint "sent_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_consult.lu_progressnote_templates add constraint "lu_progressnote_templates_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_mentalhealth.team_care_members add constraint "team_care_members_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_mentalhealth.team_care_members add constraint "team_care_members_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE clin_mentalhealth.team_care_members add constraint "team_care_members_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
ALTER TABLE clerical.bookings add constraint "bookings_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE clin_certificates.certificate_reasons add constraint "certificate_reasons_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE admin.global_preferences add constraint "global_preferences_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE admin.global_preferences add constraint "global_preferences_fk_clinic_fkey" foreign key (fk_clinic) references admin.clinics (pk);
ALTER TABLE clin_prescribing.instruction_habits add constraint "instruction_habits_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_history.family_links add constraint "family_links_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
ALTER TABLE clin_history.team_care_members add constraint "team_care_members_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_history.team_care_members add constraint "team_care_members_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE clin_history.team_care_members add constraint "team_care_members_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
ALTER TABLE clin_history.team_care_members add constraint "team_care_members_fk_document_allied_health_form_fkey" foreign key (fk_document_allied_health_form) references documents.documents (pk);
ALTER TABLE clin_referrals.inclusions add constraint "inclusions_fk_document_fkey" foreign key (fk_document) references documents.documents (pk);
ALTER TABLE admin.staff add constraint "staff_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE contacts.data_persons add constraint "data_persons_fk_occupation_fkey" foreign key (fk_occupation) references common.lu_occupations (pk);
ALTER TABLE documents.signed_off add constraint "signed_off_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE documents.signed_off add constraint "signed_off_fk_document_fkey" foreign key (fk_document) references documents.documents (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_address_fkey" foreign key (fk_address) references contacts.data_addresses (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_workcover.visits add constraint "visits_fk_coding_system_fkey" foreign key (fk_coding_system) references coding.lu_systems (pk);
ALTER TABLE clin_workcover.visits add constraint "visits_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_workcover.visits add constraint "visits_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE clin_measurements.inr_plan add constraint "inr_plan_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
ALTER TABLE clin_requests.forms add constraint "forms_fk_pasthistory_fkey" foreign key (fk_pasthistory) references clin_history.past_history (pk);
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care add constraint "diabetes_annual_cycle_of_care_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care add constraint "diabetes_annual_cycle_of_care_fk_progressnote_components_fkey" foreign key (fk_progressnote_components) references clin_consult.progressnotes (pk);
ALTER TABLE clin_requests.notes add constraint "notes_fk_staff_fkey" foreign key (fk_staff) references admin.staff (pk);
ALTER TABLE clin_procedures.lu_anaesthetic_agent add constraint "lu_anaesthetic_agent_fk_lu_route_administration_fkey" foreign key (fk_lu_route_administration) references common.lu_route_administration (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_lu_risk_to_others_fkey" foreign key (fk_lu_risk_to_others) references clin_mentalhealth.lu_risk_to_others (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_mentalhealth.mentalhealth_plan add constraint "mentalhealth_plan_fk_lu_plan_type_fkey" foreign key (fk_lu_plan_type) references clin_mentalhealth.lu_plan_type (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_history.recreational_drugs add constraint "recreational_drugs_fk_lu_route_administration_fkey" foreign key (fk_lu_route_administration) references common.lu_route_administration (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_history.recreational_drugs add constraint "recreational_drugs_fk_lu_substance_frequency_fkey" foreign key (fk_lu_substance_frequency) references common.lu_units (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_history.recreational_drugs add constraint "recreational_drugs_fk_lu_substance_amount_units_fkey" foreign key (fk_lu_substance_amount_units) references common.lu_units (pk);
-- UNCOMMENT THIS IT WORKS ALTER TABLE clin_history.team_care_members add constraint "team_care_members_fk_team_care_arrangement_fkey" foreign key (fk_team_care_arrangement) references clin_history.team_care_arrangements (pk);
ALTER TABLE clin_pregnancy.ante_natal_care_summary add constraint "ante_natal_care_summary_fk_subreligion_fkey" foreign key (fk_subreligion) references common.lu_sub_religions (pk);
ALTER TABLE clin_pregnancy.ante_natal_care_summary add constraint "ante_natal_care_summary_fk_religion_fkey" foreign key (fk_religion) references common.lu_religions (pk);
ALTER TABLE billing.payments_received add constraint "payments_received_fk_lu_payment_method_fkey" foreign key (fk_lu_payment_method) references billing.lu_payment_method (pk);
ALTER TABLE clin_pregnancy.pregnancies add constraint "pregnancies_fk_lu_placenta_position_fkey" foreign key (fk_lu_placenta_position) references clin_pregnancy.lu_placenta_position (pk);
ALTER TABLE clin_pregnancy.pregnancies add constraint "pregnancies_fk_lu_contraception_method_fkey" foreign key (fk_lu_contraception_method) references clin_pregnancy.lu_contraception_methods (pk);
ALTER TABLE clin_measurements.patients_defaults add constraint "patients_defaults_fk_lu_type_fkey" foreign key (fk_lu_type) references clin_measurements.lu_type (pk);
ALTER TABLE clin_requests.link_forms_requests_requests_results add constraint "link_forms_requests_requests_results_fk_forms_requests_fkey" foreign key (fk_forms_requests) references clin_requests.forms_requests (pk);
ALTER TABLE contacts.data_persons add constraint "data_persons_fk_sex_fkey" foreign key (fk_sex) references contacts.lu_sex (pk);
ALTER TABLE contacts.data_persons add constraint "data_persons_fk_marital_fkey" foreign key (fk_marital) references contacts.lu_marital (pk);
ALTER TABLE contacts.data_persons add constraint "data_persons_fk_title_fkey" foreign key (fk_title) references contacts.lu_title (pk);
ALTER TABLE clin_requests.lu_requests add constraint "lu_requests_fk_laterality_fkey" foreign key (fk_laterality) references common.lu_laterality (pk);
ALTER TABLE clin_mentalhealth.k10_results add constraint "k10_results_fk_lu_k10_component_fkey" foreign key (fk_lu_k10_component) references clin_mentalhealth.lu_k10_components (pk);
ALTER TABLE clin_recalls.lu_templates add constraint "lu_templates_fk_lu_appointment_length_fkey" foreign key (fk_lu_appointment_length) references common.lu_appointment_length (pk);
ALTER TABLE clin_certificates.medical_certificates add constraint "medical_certificates_fk_lu_fitness_fkey" foreign key (fk_lu_fitness) references clin_certificates.lu_fitness (pk);
ALTER TABLE clin_certificates.medical_certificates add constraint "medical_certificates_fk_lu_illness_temporality_fkey" foreign key (fk_lu_illness_temporality) references clin_certificates.lu_illness_temporality (pk);
ALTER TABLE documents.documents add constraint "documents_fk_unmatched_patient_fkey" foreign key (fk_unmatched_patient) references clerical.data_patients (pk);
ALTER TABLE documents.documents add constraint "documents_fk_sending_entity_fkey" foreign key (fk_sending_entity) references documents.sending_entities (pk);
ALTER TABLE documents.documents add constraint "documents_fk_lu_request_type_fkey" foreign key (fk_lu_request_type) references clin_requests.lu_request_type (pk);
ALTER TABLE documents.documents add constraint "documents_fk_lu_display_as_fkey" foreign key (fk_lu_display_as) references documents.lu_display_as (pk);
ALTER TABLE documents.documents add constraint "documents_fk_lu_urgency_fkey" foreign key (fk_lu_urgency) references common.lu_urgency (pk);
ALTER TABLE documents.documents add constraint "documents_fk_referral_fkey" foreign key (fk_referral) references clin_referrals.referrals (pk);
ALTER TABLE clin_history.family_conditions add constraint "family_conditions_fk_member_fkey" foreign key (fk_member) references clin_history.family_members (pk);
alter table common.lu_countries add constraint code_unique unique  (country_code);
ALTER TABLE clin_history.family_members add constraint "family_members_fk_country_birth_fkey" foreign key (fk_country_birth) references common.lu_countries (country_code);
ALTER TABLE clin_history.family_members add constraint "family_members_fk_relationship_fkey" foreign key (fk_relationship) references common.lu_family_relationships (pk);
ALTER TABLE clin_requests.request_providers add constraint "request_providers_fk_lu_request_type_fkey" foreign key (fk_lu_request_type) references clin_requests.lu_request_type (pk);
ALTER TABLE clin_measurements.inr_dose_management add constraint "inr_dose_management_fk_observation_fkey" foreign key (fk_observation) references documents.observations (pk);
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes add constraint "diabetes_annual_cycle_of_care_notes_fk_diabetes_annual_cycle_of_care_fkey" foreign key (fk_diabetes_annual_cycle_of_care) references chronic_disease_management.diabetes_annual_cycle_of_care (pk);
ALTER TABLE coding.lu_icpc2_plain_language_mapper add constraint "lu_icpc2_plain_language_mapper_fk_icpc2_term_fkey" foreign key (fk_icpc2_term) references   coding.icpc2_terms  (pk);
ALTER TABLE clerical.lu_inventory_items add constraint "lu_inventory_items_fk_lu_inventory_category_fkey" foreign key (fk_lu_inventory_category) references clerical.lu_inventory_categories (pk);
ALTER TABLE clin_requests.notes add constraint "notes_fk_lu_type_fkey" foreign key (fk_lu_type) references clin_requests.lu_request_type (pk);
ALTER TABLE clin_procedures.link_images_procedures add constraint "link_images_procedures_fk_image_fkey" foreign key (fk_image) references blobs.images (pk);
ALTER TABLE clin_procedures.link_images_procedures add constraint "link_images_procedures_fk_procedure_fkey" foreign key (fk_procedure) references  clin_procedures.skin_procedures (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_type_fkey" foreign key (fk_type) references clin_referrals.lu_type (pk);
ALTER TABLE clin_referrals.referrals add constraint "referrals_fk_lu_urgency_fkey" foreign key (fk_lu_urgency) references clin_referrals.lu_urgency (pk);
ALTER TABLE admin.staff add constraint "staff_fk_lu_staff_type_fkey" foreign key (fk_lu_staff_type) references   admin.lu_staff_type (pk);
ALTER TABLE admin.staff add constraint "staff_fk_role_fkey" foreign key (fk_role) references   admin.lu_staff_roles (pk);
ALTER TABLE admin.staff add constraint "staff_fk_status_fkey" foreign key (fk_status) references  admin.lu_staff_status (pk);
ALTER TABLE clin_procedures.lu_suture_type add constraint "lu_suture_type_fk_lu_site_fkey" foreign key (fk_lu_site) references  clin_procedures.lu_suture_site (pk);
ALTER TABLE clin_history.family_links add constraint "family_links_fk_member_fkey" foreign key (fk_member) references clin_history.family_members (pk);
ALTER TABLE clin_prescribing.instruction_habits add constraint "instruction_habits_fk_instruction_fkey" foreign key (fk_instruction) references  clin_prescribing.instructions (pk);
ALTER TABLE clin_history.lu_exposures add constraint "lu_exposures_fk_decision_support_fkey" foreign key (fk_decision_support) references  clin_history.lu_exposures (pk);
ALTER TABLE clin_mentalhealth.team_care_members add constraint "team_care_members_fk_organisation_fkey" foreign key (fk_organisation) references contacts.data_organisations (pk);
ALTER TABLE documents.sending_entities add constraint "sending_entities_fk_lu_message_display_style_fkey" foreign key (fk_lu_message_display_style) references documents.lu_message_display_style (pk);
ALTER TABLE documents.sending_entities add constraint "sending_entities_fk_lu_message_standard_fkey" foreign key (fk_lu_message_standard) references  documents.lu_message_standard (pk);
ALTER TABLE clin_vaccination.lu_schedules add constraint "lu_schedules_fk_season_fkey" foreign key (fk_season) references common.lu_seasons (pk);

ALTER TABLE clin_mentalhealth.team_care_members add constraint "team_care_members_fk_plan_fkey" foreign key (fk_plan) references clin_mentalhealth.mentalhealth_plan (pk);
ALTER TABLE clin_recalls.sent add constraint "sent_fk_recall_fkey" foreign key (fk_recall) references  clin_recalls.recalls(pk);
ALTER TABLE clin_recalls.sent add constraint "sent_fk_contact_method_fkey" foreign key (fk_contact_method) references  contacts.lu_contact_type(pk);
UPDATE  clin_recalls.recalls set fk_interval_unit=NULL where fk_interval_unit=0;
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_interval_unit_fkey" foreign key (fk_interval_unit) references  common.lu_units(pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_contact_method_fkey" foreign key (fk_contact_method) references  contacts.lu_contact_type(pk);
UPDATE clin_recalls.recalls SET fk_appointment_length=3 where fk_appointment_length>3;
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_appointment_length_fkey" foreign key (fk_appointment_length) references common.lu_appointment_length(pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_urgency_fkey" foreign key (fk_urgency) references common.lu_urgency(pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_sent_fkey" foreign key (fk_sent) references clin_recalls.sent(pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_template_fkey" foreign key (fk_template) references clin_recalls.lu_templates(pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_lu_procedure_type_fkey" foreign key (fk_lu_procedure_type) references clin_procedures.lu_procedure_type(pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_lu_anaesthetic_agent_fkey" foreign key (fk_lu_anaesthetic_agent) references clin_procedures.lu_anaesthetic_agent(pk);
ALTER TABLE clin_requests.user_default_type add constraint "user_default_type_fk_lu_type_fkey" foreign key (fk_lu_type) references  clin_requests.lu_request_type(pk);
ALTER TABLE admin.staff_clinical_toolbar add constraint "staff_clinical_toolbar_fk_module_fkey" foreign key (fk_module) references  admin.lu_clinical_modules(pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_lu_message_standard_fkey" foreign key (fk_lu_message_standard) references defaults.lu_message_standard(pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_lu_message_display_style_fkey" foreign key (fk_lu_message_display_style) references defaults.lu_message_display_style(pk);
ALTER TABLE clin_measurements.lu_type add constraint "lu_type_fk_unit_fkey" foreign key (fk_unit) references common.lu_units(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_repair_type_fkey" foreign key (fk_lu_repair_type) references  clin_procedures.lu_repair_type(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_anaesthetic_agent_fkey" foreign key (fk_lu_anaesthetic_agent) references clin_procedures.lu_anaesthetic_agent(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_form_fkey" foreign key (fk_form) references clin_requests.forms(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_procedure_type_fkey" foreign key (fk_lu_procedure_type) references clin_procedures.lu_procedure_type(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_skin_preparation_fkey" foreign key (fk_lu_skin_preparation) references clin_procedures.lu_skin_preparation(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_anterior_posterior_fkey" foreign key (fk_lu_anterior_posterior) references common.lu_anatomical_localisation(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_skin_suture_fkey" foreign key (fk_skin_suture) references  clin_procedures.lu_suture_type(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_lateralisation_fkey" foreign key (fk_lu_lateralisation) references  common.lu_laterality(pk);
ALTER TABLE clerical.task_component_notes add constraint "task_component_notes_fk_task_component_fkey" foreign key (fk_task_component) references  clerical.task_components(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_payer_person_fkey" foreign key (fk_payer_person) references  contacts.data_persons(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_lu_default_billing_level_fkey" foreign key (fk_lu_default_billing_level) references billing.lu_default_billing_level(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_doctor_fkey" foreign key (fk_doctor) references admin.staff(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_lu_private_health_fund_fkey" foreign key (fk_lu_private_health_fund) references clerical.lu_private_health_funds(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_next_of_kin_fkey" foreign key (fk_next_of_kin) references  contacts.data_persons(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_payer_fkey" foreign key (fk_payer_person) references  contacts.data_persons(pk);
ALTER TABLE clerical.data_patients add constraint "data_patients_fk_payer_branch_fkey" foreign key (fk_payer_branch) references  contacts.data_branches(pk);
ALTER TABLE clin_recalls.links_forms add constraint "links_forms_fk_recall_fkey" foreign key (fk_recall) references clin_recalls.recalls(pk);
ALTER TABLE clin_recalls.links_forms add constraint "links_forms_fk_form_fkey" foreign key (fk_form) references clin_recalls.forms(pk);
ALTER TABLE billing.invoices add constraint "invoices_fk_lu_bulk_billing_type_fkey" foreign key (fk_lu_bulk_billing_type) references billing.lu_bulk_billing_type(pk);
ALTER TABLE billing.invoices add constraint "invoices_fk_appointment_fkey" foreign key (fk_appointment) references  clerical.bookings(pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_role_fkey" foreign key (fk_role) references admin.lu_staff_roles(pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_urgency_fkey" foreign key (fk_urgency) references  common.lu_urgency(pk);
ALTER TABLE clerical.task_components add constraint "task_components_fk_task_fkey" foreign key (fk_task) references clerical.tasks(pk);
ALTER TABLE clerical.tasks add constraint "tasks_fk_role_can_finalise_fkey" foreign key (fk_role_can_finalise) references  admin.lu_staff_roles(pk);
ALTER TABLE clerical.tasks add constraint "tasks_fk_row_fkey" foreign key (fk_row) references  documents.documents(pk);
ALTER TABLE clin_vaccination.vaccinations add constraint "vaccinations_fk_site_fkey" foreign key (fk_site) references common.lu_site_administration (pk);
ALTER TABLE clin_prescribing.prescribed add constraint "prescribed_fk_progress_note_fkey" foreign key (fk_progress_note) references clin_consult.progressnotes (pk);
ALTER TABLE clin_prescribing.prescribed add constraint "prescribed_fk_prescribed_for_fkey" foreign key (fk_prescribed_for) references clin_prescribing.prescribed_for (pk);
ALTER TABLE clin_prescribing.prescribed add constraint "prescribed_fk_instruction_fkey" foreign key (fk_instruction) references clin_prescribing.instructions (pk);
ALTER TABLE contacts.data_persons add constraint "data_persons_fk_ethnicity_fkey" foreign key (fk_ethnicity) references common.lu_ethnicity  (pk);
ALTER TABLE clin_consult.progressnotes add constraint "progressnotes_fk_section_fkey" foreign key (fk_section) references clin_consult.lu_progressnotes_sections (pk);
ALTER TABLE clerical.data_family_members add constraint "data_family_members_fk_family_fkey" foreign key (fk_family) references clerical.data_families (pk);
ALTER TABLE clin_workcover.visits add constraint "visits_fk_lu_visit_type_fkey" foreign key (fk_lu_visit_type) references  clin_workcover.lu_visit_type(pk);
ALTER TABLE clin_workcover.visits add constraint "visits_fk_caused_by_employment_fkey" foreign key (fk_caused_by_employment) references  clin_workcover.lu_caused_by_employment(pk);
ALTER TABLE common.lu_sub_religions add constraint "lu_sub_religions_fk_religion_fkey" foreign key (fk_religion) references  common.lu_religions(pk);
ALTER TABLE clin_mentalhealth.clozapine_record add constraint "clozapine_record_fk_observation_neutrophil_count_fkey" foreign key (fk_observation_neutrophil_count) references  documents.observations (pk);
ALTER TABLE clin_mentalhealth.clozapine_record add constraint "clozapine_record_fk_observation_white_cell_count_fkey" foreign key (fk_observation_white_cell_count) references documents.observations  (pk);
ALTER TABLE clerical.inventory add constraint "inventory_fk_image_fkey" foreign key (fk_image) references blobs.images(pk);
ALTER TABLE clin_history.occupations_exposures add constraint "occupations_exposures_fk_exposure_fkey" foreign key (fk_exposure) references  clin_history.lu_exposures(pk);
ALTER TABLE clin_measurements.measurements add constraint "measurements_fk_type_fkey" foreign key (fk_type) references clin_measurements.lu_type(pk);
ALTER TABLE clin_vaccination.lu_vaccines add constraint "lu_vaccines_fk_route_fkey" foreign key (fk_route) references common.lu_route_administration(pk);
ALTER TABLE clin_vaccination.lu_vaccines add constraint "lu_vaccines_fk_form_fkey" foreign key (fk_form) references clin_vaccination.lu_formulation(pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_user_provider_defaults_fkey" foreign key (fk_user_provider_defaults) references clin_requests.user_provider_defaults (pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_lu_skin_preparation_fkey" foreign key (fk_lu_skin_preparation) references clin_procedures.lu_skin_preparation (pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_lu_repair_type_fkey" foreign key (fk_lu_repair_type) references clin_procedures.lu_repair_type (pk);
ALTER TABLE clin_vaccination.lu_vaccines add constraint "lu_vaccines_fk_description_fkey" foreign key (fk_description) references  clin_vaccination.lu_descriptions(pk); 
ALTER TABLE clin_history.social_history add constraint "social_history_fk_responsible_person_fkey" foreign key (fk_responsible_person) references  contacts.data_persons(pk);
ALTER TABLE clin_referrals.inclusions add constraint "inclusions_fk_referral_fkey" foreign key (fk_referral) references clin_referrals.referrals(pk);
ALTER TABLE import_export.lu_demographics_field_templates add constraint "lu_demographics_field_templates_fk_source_program_fkey" foreign key (fk_source_program) references import_export.lu_source_program(pk);
ALTER TABLE clin_prescribing.prescribed_for_habits add constraint "prescribed_for_habits_fk_prescribed_for_fkey" foreign key (fk_prescribed_for) references  clin_prescribing.prescribed_for(pk);
ALTER TABLE clin_recalls.lu_recall_intervals add constraint "lu_recall_intervals_fk_reason_fkey" foreign key (fk_reason) references  clin_recalls.lu_reasons (pk);
ALTER TABLE clerical.bookings add constraint "bookings_fk_lu_appointment_status_fkey" foreign key (fk_lu_appointment_status) references clerical.lu_appointment_status(pk); 
ALTER TABLE clerical.bookings add constraint "bookings_fk_lu_reason_not_billed_fkey" foreign key (fk_lu_reason_not_billed) references billing.lu_reasons_not_billed(pk);
ALTER TABLE clerical.bookings add constraint "bookings_fk_lu_appointment_icon_fkey" foreign key (fk_lu_appointment_icon) references clerical.lu_appointment_icons(pk);
ALTER TABLE defaults.incoming_message_handling add constraint "incoming_message_handling_fk_blob_fkey" foreign key (fk_blob) references  blobs.blobs(pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_site_fkey" foreign key (fk_lu_site) references   common.lu_anatomical_site (pk);
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_subcutaneous_suture_fkey" foreign key (fk_subcutaneous_suture) references  clin_procedures.lu_suture_type (pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_subcutaneous_suture_fkey" foreign key (fk_subcutaneous_suture) references clin_procedures.lu_suture_type (pk);
ALTER TABLE clin_procedures.staff_skin_procedure_defaults add constraint "staff_skin_procedure_defaults_fk_skin_suture_fkey" foreign key (fk_skin_suture) references clin_procedures.lu_suture_type (pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_reason_fkey" foreign key (fk_reason) references  clin_recalls.lu_reasons(pk);
ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_status_fkey" foreign key (fk_status) references clin_recalls.lu_status(pk);
ALTER TABLE clin_recalls.lu_recall_intervals add constraint "lu_recall_intervals_fk_interval_unit_fkey" foreign key (fk_interval_unit) references common.lu_units (pk);
-- SKIP FOR TIME BEING ALTER TABLE clin_requests.request_providers add constraint "request_providers_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
-- SKIP FOR THE TIME BEING ALTER TABLE clin_requests.request_providers add constraint "request_providers_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
-- SKIP FOR THE TIME BEING ALTER TABLE clin_consult.progressnotes add constraint "progressnotes_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
-- ALTER TABLE clerical.data_family_members add constraint "data_family_members_fk_patient_fkey" foreign key (fk_patient) references clerical.data_patients (pk);
-- ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes add constraint "diabetes_annual_cycle_of_care_notes_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
-- ALTER TABLE clin_measurements.measurements add constraint "measurements_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
-- ALTER TABLE clin_history.social_history add constraint "social_history_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
-- ALTER TABLE clin_prescribing.prescribed_for_habits add constraint "prescribed_for_habits_fk_generic_product_fkey" foreign key (fk_generic_product) references drugs.product (pk);
-- ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_consult_fkey" foreign key (fk_consult) references clin_consult.consult (pk);
-- ALTER TABLE clin_recalls.recalls add constraint "recalls_fk_progressnote_fkey" foreign key (fk_progressnote) references clin_consult.progressnotes (pk);
-- ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_progressnote_auto_fkey" foreign key (fk_progressnote_auto) references clin_consult.progressnotes (pk);
-- ALTER TABLE documents.sending_entities add constraint "sending_entities_fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
-- ALTER TABLE documents.sending_entities add constraint "sending_entities_fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
-- alter table drugs.brand add constraint "brand_fk_company_fkey" foreign key (fk_company) references drugs.company (code);
-- alter table clin_vaccination.vaccinations add constraint "vaccinations_fk_laterality_fkey" foreign key (fk_laterality) references common.lu_laterality (pk);
-- ALTER TABLE clin_consult.consult add constraint "consult_fk_type_fkey" foreign key (fk_type) references clin_consult.lu_consult_type (pk);
-- FIX THIS aLTER TABLE clin_history.past_history add constraint "past_history_fk_laterality_fkey" foreign key (fk_laterality) references common.lu_laterality (pk);
-- FIX THIS ALTER TABLE contacts.data_persons add constraint "data_persons_fk_language_fkey" foreign key (fk_language) references common.lu_languages (pk);
-- FIX THIS ALTER TABLE contacts.data_persons add constraint "data_persons_fk_ethnicity_fkey" foreign key (fk_ethnicity) references common.lu_ethnicity (pk);
-- ALTER TABLE clin_requests.request_providers add constraint "request_providers_fk_default_branch_fkey" foreign key (fk_default_branch) references contacts.data_branches (pk);
-- ALTER TABLE clin_requests.request_providers add constraint "request_providers_fk_headoffice_branch_fkey" foreign key (fk_headoffice_branch) references contacts.data_branches (pk);
-- ALTER TABLE documents.sending_entities add constraint "sending_entities_fk_lu_request_type_fkey" foreign key (fk_lu_request_type) references  clin_requests.lu_request_type (pk);
-- ALTER TABLE clin_requests.lu_link_provider_user_requests add constraint "lu_link_provider_user_requests_fk_lu_request_fkey" foreign key (fk_lu_request) references clin_requests.lu_requests(pk);
-- NEEDS UPDATE QUERY TO FIX MISSING PK=1507
-- ALTER TABLE documents.documents add constraint "documents_fk_unmatched_staff_fkey" foreign key (fk_unmatched_staff) references admin.staff (pk);
-- ALTER TABLE documents.documents add constraint "documents_fk_request_fkey" foreign key (fk_request) references clin_requests.forms (pk);
--ALTER TABLE clin_workcover.visits add constraint "visits_fk_claim_fkey" foreign key (fk_claim) references  clin_workcover.claims(pk);
-- ALTER TABLE clin_mentalhealth.k10_results add constraint "k10_results_fk_plan_fkey" foreign key (fk_plan) references clin_mentalhealth.mentalhealth_plan (pk);
-- FIX THIS ALTER TABLE contacts.data_persons add constraint "data_persons_fk_image_fkey" foreign key (fk_image) references blobs.images (pk);
-- alter table contacts.data_employees drop constraint "fk_branchLfkey";
ALTER TABLE clin_procedures.skin_procedures add constraint "skin_procedures_fk_lu_site_fkey" foreign key (fk_lu_site) references   common.lu_anatomical_site (pk); -- WILL CRASH HERE TO STOP THE COMMIT WHILST i WORK
update db.lu_version set lu_minor = 440;
