-- -- some changes prior to applying constraints
insert into common.lu_ethnicity (pk,ethnicity) values (1, 'Not specified');
update clin_requests.lu_requests set fk_laterality = null where fk_laterality=0;
update contacts.data_persons set fk_ethnicity = null where fk_ethnicity= 0;
update contacts.data_persons set fk_image = null where fk_image =0; -- errors introduced when no constraints
update contacts.data_persons set fk_language = null where fk_language = 0;

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
            WHEN (Addresses.pk is not null) THEN COALESCE(((data_persons.pk || '-'::text) || Addresses.pk))
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
    Addresses.street1,
    Addresses.street2,
    Addresses.fk_town,
    Addresses.fk_lu_address_type,
    lu_address_types.type AS address_type,
    Addresses.preferred_address,
    Addresses.postal_address,
    Addresses.head_office,
    Addresses.geolocation,
    Addresses.deleted AS address_deleted,
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
     LEFT JOIN contacts.data_addresses Addresses ON ((links_persons_addresses.fk_address = Addresses.pk)))
     LEFT JOIN contacts.lu_address_types ON ((Addresses.fk_lu_address_type = lu_address_types.pk)))
     LEFT JOIN contacts.lu_towns ON ((Addresses.fk_town = lu_towns.pk)))
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
  
--drop view contacts.vwpersonsemployeesbyoccupation;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
 SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view,
    vwpersonsexcludingpatients.fk_person,
    vwpersonsexcludingpatients.title,
    vwpersonsexcludingpatients.fk_title,
    vwpersonsexcludingpatients.surname,
    vwpersonsexcludingpatients.firstname,
    vwpersonsexcludingpatients.occupation,
    vwpersonsexcludingpatients.fk_occupation,
    vwpersonsexcludingpatients.sex,
    vwpersonsexcludingpatients.fk_sex,
    vwpersonsexcludingpatients.retired,
    vwpersonsexcludingpatients.deceased,
    vwpersonsexcludingpatients.salutation,
    NULL::text AS organisation,
    NULL::text AS branch,
    NULL::integer as fk_organisation,
    NULL::integer as fk_branch,
    vwpersonsexcludingpatients.fk_address,
    NULL::integer AS fk_employee,
    vwpersonsexcludingpatients.street1,
    vwpersonsexcludingpatients.street2,
    vwpersonsexcludingpatients.town,
    vwpersonsexcludingpatients.state,
    vwpersonsexcludingpatients.postcode,
    vwpersonsexcludingpatients.wholename,
    vwpersonsexcludingpatients.surname_normalised,
    persons_numbers.provider_number,
    data_numbers_persons.prescriber_number,
    data_numbers_persons.hpii,
    persons_numbers.hpio,
    persons_numbers.australian_business_number,
    vwpersonscomms.value AS fax,
    vwpersonsexcludingpatients.memo,
    vwpersonsexcludingpatients.fk_image,
    vwpersonsexcludingpatients.image,
    0 AS fk_status,
    vwpersonsexcludingpatients.person_qualifications
   FROM contacts.vwpersonsexcludingpatients
     LEFT JOIN contacts.data_numbers persons_numbers ON persons_numbers.fk_person = vwpersonsexcludingpatients.fk_person AND persons_numbers.fk_branch IS NULL
     LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = vwpersonsexcludingpatients.fk_person
     LEFT JOIN contacts.vwpersonscomms ON vwpersonscomms.fk_person = vwpersonsexcludingpatients.fk_person AND vwpersonscomms.fk_type = 2
  WHERE vwpersonsexcludingpatients.fk_address IS NOT NULL AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION
 SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view,
    vwemployees.fk_person,
    vwemployees.title,
    vwemployees.fk_title,
    vwemployees.surname,
    vwemployees.firstname,
    vwemployees.occupation,
    vwemployees.fk_occupation,
    vwemployees.sex,
    vwemployees.fk_sex,
    vwemployees.retired,
    vwemployees.deceased,
    vwemployees.salutation,
    vwemployees.organisation,
        CASE
            WHEN lower(vwemployees.branch) = 'head office'::text THEN ''::text
            ELSE vwemployees.branch
        END AS branch,
    vwemployees.fk_organisation,
    vwemployees.fk_branch,
    vwemployees.fk_address,
    vwemployees.fk_employee,
    vwemployees.street1,
    vwemployees.street2,
    vwemployees.town,
    vwemployees.state,
    vwemployees.postcode,
    (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename,
    vwemployees.surname_normalised,
    vwemployees.provider_number,
    vwemployees.prescriber_number,
    vwemployees.hpii,
    vwemployees.hpio,
    vwemployees.australian_business_number,
    vwbranchescomms.value AS fax,
    vwemployees.memo,
    vwemployees.fk_image,
    vwemployees.image,
    vwemployees.fk_status,
    vwemployees.person_qualifications
   FROM contacts.vwemployees
     LEFT JOIN contacts.vwbranchescomms ON vwbranchescomms.fk_branch = vwemployees.fk_branch AND vwbranchescomms.fk_type = 2
  WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL);

ALTER TABLE contacts.vwpersonsemployeesbyoccupation   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

  
  COMMENT ON COLUMN contacts.data_employees.fk_status IS 'employement status, foreign key to contacts.lu_employement_status 0-Active 1-Inactive 2-Left organisation 3-On Leave';

  

  update db.lu_version set lu_minor = 440;

  
