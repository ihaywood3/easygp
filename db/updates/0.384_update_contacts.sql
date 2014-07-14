	-- fixed inexplicable early developement errors where the calculated wholename field ends in ascii 32 (my stupidity)

 DROP VIEW contacts.vwemployees CASCADE ;

CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee,
 data_employees.fk_person, lu_title.title, 
 data_persons.firstname,  data_persons.surname, 
 data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, 
 data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, 
 data_employees.fk_branch, data_branches.branch, data_organisations.organisation, 
 data_branches.fk_organisation, data_branches.fk_address, 
 data_branches.memo AS branch_memo, data_branches.fk_category AS fk_category_organisation, 
 lu_categories.category  AS category_organisation, 
 data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo,
 data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, 
 data_persons.country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, 
 data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street1, 
 data_addresses.street2, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address,
 data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, 
 data_addresses.deleted AS organisation_address_deleted, data_persons.surname_normalised,
 employee_numbers.provider_number, employee_numbers.pk AS employees_pk_data_numbers,
 data_numbers_persons.prescriber_number, data_numbers_persons.hpii,
 data_numbers_persons.pk AS pk_data_numbers_persons, organisations_numbers.australian_business_number,
 organisations_numbers.hpio, organisations_numbers.pk AS organisations_pk_data_numbers, images.
image,
  ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname  ::text) AS wholename
   FROM contacts.data_employees
   JOIN contacts.data_branches ON data_employees.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.data_numbers employee_numbers ON employee_numbers.fk_person = data_employees.fk_person AND employee_numbers.fk_branch = data_employees.fk_branch
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = data_employees.fk_person
   LEFT JOIN contacts.data_numbers organisations_numbers ON organisations_numbers.fk_person IS NULL AND organisations_numbers.fk_branch = data_employees.fk_branch
   LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
  WHERE NOT data_employees.deleted;

ALTER TABLE contacts.vwemployees   OWNER TO easygp;
GRANT SELECT ON TABLE contacts.vwemployees TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
         vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.fk_title, vwpersonsexcludingpatients.surname, 
         vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.fk_occupation, 
         vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.fk_sex, vwpersonsexcludingpatients.retired, vwpersonsexcludingpatients.deceased,
         vwpersonsexcludingpatients.salutation, NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, 
         vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, 
         vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename, 
         vwpersonsexcludingpatients.surname_normalised, persons_numbers.provider_number, data_numbers_persons.prescriber_number, data_numbers_persons.hpii,
         persons_numbers.hpio, persons_numbers.australian_business_number, vwpersonscomms.value AS fax, vwpersonsexcludingpatients.memo, 
         vwpersonsexcludingpatients.fk_image, vwpersonsexcludingpatients.image, 0 AS fk_status
           FROM contacts.vwpersonsexcludingpatients
      LEFT JOIN contacts.data_numbers persons_numbers ON persons_numbers.fk_person = vwpersonsexcludingpatients.fk_person AND persons_numbers.fk_branch IS NULL
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = vwpersonsexcludingpatients.fk_person
   LEFT JOIN contacts.vwpersonscomms ON vwpersonscomms.fk_person = vwpersonsexcludingpatients.fk_person AND vwpersonscomms.fk_type = 2
  WHERE vwpersonsexcludingpatients.fk_address IS NOT NULL AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, 
         vwemployees.fk_person, vwemployees.title, vwemployees.fk_title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation,
         vwemployees.fk_occupation, vwemployees.sex, vwemployees.fk_sex, vwemployees.retired, vwemployees.deceased, vwemployees.salutation, vwemployees.organisation, 
                CASE
                    WHEN lower(vwemployees.branch) = 'head office'::text THEN ''::text
                    ELSE vwemployees.branch
                END AS branch, vwemployees.fk_organisation, vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, 
                vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode, 
                (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, 
                vwemployees.surname_normalised, vwemployees.provider_number, vwemployees.prescriber_number, vwemployees.hpii, vwemployees.hpio, 
                vwemployees.australian_business_number, vwbranchescomms.value AS fax, vwemployees.memo, vwemployees.fk_image, vwemployees.image,
                vwemployees.fk_status
           FROM contacts.vwemployees
      LEFT JOIN contacts.vwbranchescomms ON vwbranchescomms.fk_branch = vwemployees.fk_branch AND vwbranchescomms.fk_type = 2
     WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL);

ALTER TABLE contacts.vwpersonsemployeesbyoccupation
  OWNER TO richard;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO richard;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

CREATE OR REPLACE VIEW clin_history.vwprovidersofcare AS 
         SELECT vwemployees.wholename, vwemployees.firstname, vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state,
         vwemployees.postcode, vwemployees.occupation, vwemployees.organisation, vwemployees.branch, link_pasthistory_providers.pk,
         link_pasthistory_providers.pk AS fk_provider_of_care, link_pasthistory_providers.fk_pasthistory, link_pasthistory_providers.fk_branch,
         link_pasthistory_providers.fk_employee, link_pasthistory_providers.fk_person, link_pasthistory_providers.contribution_to_plan,
         link_pasthistory_providers.deleted AS provider_deleted, consult.fk_patient
           FROM clin_history.link_pasthistory_providers, contacts.vwemployees, clin_history.past_history, clin_consult.consult
          WHERE link_pasthistory_providers.fk_person = vwemployees.fk_person 
          AND vwemployees.fk_employee = link_pasthistory_providers.fk_employee 
          AND vwemployees.fk_branch = link_pasthistory_providers.fk_branch 
          AND past_history.pk = link_pasthistory_providers.fk_pasthistory 
          AND past_history.fk_consult = consult.pk AND link_pasthistory_providers.deleted IS FALSE
UNION 
         SELECT vwpersonsexcludingpatients.wholename, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, 
         vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.occupation,
         NULL::text AS organisation, NULL::text AS branch,
         link_pasthistory_providers.pk, link_pasthistory_providers.pk AS fk_provider_of_care, link_pasthistory_providers.fk_pasthistory, 
         link_pasthistory_providers.fk_branch, link_pasthistory_providers.fk_employee, link_pasthistory_providers.fk_person,
         link_pasthistory_providers.contribution_to_plan, link_pasthistory_providers.deleted AS provider_deleted, consult.fk_patient
           FROM clin_history.link_pasthistory_providers, contacts.vwpersonsexcludingpatients, clin_history.past_history, clin_consult.consult
          WHERE link_pasthistory_providers.fk_person = vwpersonsexcludingpatients.fk_person 
          AND past_history.pk = link_pasthistory_providers.fk_pasthistory 
          AND past_history.fk_consult = consult.pk 
          AND link_pasthistory_providers.deleted IS FALSE 
          AND vwpersonsexcludingpatients.occupation <> 'unknown'::text;

ALTER TABLE clin_history.vwprovidersofcare   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwprovidersofcare TO staff;

COMMENT ON VIEW clin_history.vwprovidersofcare
  IS 'A view of all persons or organisations involved in patient care (sans=/minus the GP)';

-- View: contacts.vwpatients

-- DROP VIEW contacts.vwpatients;

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, link_person_address.fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname ::text) AS wholename, patients.fk_doctor,
        patients.fk_next_of_kin, patients.fk_payer_person, patients.fk_payer_branch, patients.fk_family, patients.medicare_number,
        patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_specific_condition,
        patients.concession_card_number, patients.concession_card_expiry_date, patients.memo AS patient_memo, patients.fk_legacy,
        patients.fk_lu_aboriginality, patients.fk_lu_veteran_card_type, patients.fk_lu_active_status, patients.fk_lu_centrelink_card_type,
        patients.fk_lu_private_health_fund, patients.private_insurance, lu_active_status.status AS active_status, lu_veteran_card_type.type AS veteran_card_type, 
        lu_centrelink_card_type.type AS concession_card_type, lu_private_health_funds.fund, persons.firstname, persons.surname, persons.salutation,
        persons.birthdate, age_display(age(persons.birthdate::timestamp with time zone)) AS age_display,
 date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric, persons.fk_ethnicity, persons.fk_language,
 persons.memo AS person_memo, persons.fk_marital, persons.fk_title, persons.fk_sex, persons.country_code AS country_birth_country_code, 
 persons.fk_image, persons.retired, persons.fk_occupation, persons.deleted AS person_deleted, persons.deceased, persons.date_deceased, 
 persons.language_problems, persons.surname_normalised, lu_aboriginality.aboriginality, country_birth.country AS country_birth, 
 lu_ethnicity.ethnicity, lu_languages.language, lu_occupations.occupation, lu_marital.marital, title.title, lu_sex.sex, lu_sex.sex_text, 
 images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, link_person_address.pk AS fk_link_persons_address,
 addresses.street1, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, 
 addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, addresses.street2, address_country.country, link_person_address.deleted AS link_address_deleted, 
lu_address_types.type AS address_type, lu_towns.postcode, lu_towns.town, lu_towns.state, patients.fk_lu_default_billing_level, 
lu_default_billing_level.level AS billing_level, patients.nursing_home_resident, patients.ihi, patients.pcehr_consent, patients.ihi_updated
   FROM clerical.data_patients patients
   JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
   LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
   LEFT JOIN common.lu_aboriginality ON patients.fk_lu_aboriginality = lu_aboriginality.pk
   LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
   LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
   LEFT JOIN billing.lu_default_billing_level ON patients.fk_lu_default_billing_level = lu_default_billing_level.pk
   JOIN contacts.data_persons persons ON patients.fk_person = persons.pk
   LEFT JOIN common.lu_ethnicity ON persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON persons.fk_language = lu_languages.pk
   LEFT JOIN common.lu_occupations ON persons.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_marital ON persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN contacts.lu_sex ON persons.fk_sex = lu_sex.pk
   LEFT JOIN blobs.images images ON persons.fk_image = images.pk
   LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
   LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns ON addresses.fk_town = lu_towns.pk
   LEFT JOIN common.lu_countries country_birth ON persons.country_code = country_birth.country_code::text
   LEFT JOIN common.lu_countries address_country ON addresses.country_code = address_country.country_code;

ALTER TABLE contacts.vwpatients   OWNER TO easygp;
GRANT SELECT ON TABLE contacts.vwpatients TO staff;

CREATE OR REPLACE VIEW contacts.vwpersons AS 
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view, ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname ::text) AS wholename, 
        data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity,
        data_persons.fk_language, data_persons.language_problems, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, 
        data_persons.fk_sex, data_persons.fk_image, data_persons.fk_occupation, data_persons.retired, data_persons.deceased, 
        data_persons.date_deceased, data_persons.deleted, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, 
        lu_occupations.occupation, lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, 
        links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, 
        "Addresses".street1, "Addresses".street2, "Addresses".fk_town, "Addresses".fk_lu_address_type, 
        lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, 
        "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, 
        images.image, data_persons.surname_normalised, data_numbers.provider_number, data_numbers_persons.hpii,
        data_numbers.hpio, data_numbers.pk AS pk_data_numbers, data_numbers_persons.pk AS pk_data_numbers_persons
   FROM contacts.data_persons
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN common.lu_occupations ON data_persons.fk_occupation = lu_occupations.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN contacts.images ON data_persons.fk_image = images.pk
   LEFT JOIN contacts.links_persons_addresses ON data_persons.pk = links_persons_addresses.fk_person
   LEFT JOIN common.lu_countries ON data_persons.country_code = lu_countries.country_code::text
   LEFT JOIN contacts.data_addresses "Addresses" ON links_persons_addresses.fk_address = "Addresses".pk
   LEFT JOIN contacts.lu_address_types ON "Addresses".fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns ON "Addresses".fk_town = lu_towns.pk
   LEFT JOIN contacts.data_numbers ON data_persons.pk = data_numbers.fk_person AND data_numbers.fk_branch IS NULL
   LEFT JOIN contacts.data_numbers_persons ON data_persons.pk = data_numbers_persons.fk_person
  ORDER BY data_persons.pk, links_persons_addresses.fk_address;

ALTER TABLE contacts.vwpersons   OWNER TO EASYGP;
GRANT select ON TABLE contacts.vwpersons TO staff;

-- View: contacts.vwpersonsincludingpatients

-- DROP VIEW contacts.vwpersonsincludingpatients;

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname ::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age,
        marital.marital, sex.sex, title.title, countries.country, languages.language, countries1.country AS country_birth, ethnicity.ethnicity, 
        addresses.street1, addresses.street2, towns.town, towns.state, towns.postcode, addresses.fk_town, addresses.preferred_address,
        addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, 
        addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.language_problems, 
        persons.memo, persons.fk_marital, persons.country_code AS country_birth_country_code, persons.fk_title, persons.deceased, 
        persons.date_deceased, persons.fk_sex, images.pk AS fk_image, images.image, images.md5sum,
        images.tag, images.fk_consult AS fk_consult_image, persons.surname_normalised, data_patients.pk AS fk_patient
   FROM contacts.data_persons persons
   LEFT JOIN clerical.data_patients ON persons.pk = data_patients.pk
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

ALTER TABLE contacts.vwpersonsincludingpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT select ON TABLE contacts.vwpersonsincludingpatients TO staff;

COMMENT ON VIEW contacts.vwpersonsincludingpatients
  IS 'a view of all persons including those who are patients';


update db.lu_version set lu_minor=384;