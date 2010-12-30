-- At the request of someone who shall remain un-named, added a column to record
-- if the person/patient can't speak, in this case, english, left it generic

alter table contacts.data_persons add column language_problems boolean default false;

comment on column contacts.data_persons.language_problems is
'so named in case EasyGP used outside of english speaking country, ie this field could have
 been called difficult_with_english, but the intent is that the person/patient cannot speak 
 or has difficulty understanding the predominant language in your country';



drop view contacts.vwPatients cascade ;
drop view contacts.vwPersons cascade ;
drop view contacts.vwpersonsincludingpatients cascade;

-- this wipes out these views:

--contacts.vwPatients  - done and checked replacement
--contacts.vwPersons  - done and checked replacement
--contacts.vwpersonsexcludingpatients  - done and checked replacement
--contacts.vwpersonsoremployees_by_occupation  - done and checked replacement
--contacts.vwpersonsandemployeesaddresses  - done and checked replacement
--contacts.vwpersonsincludingpatients  - done and checked replacement
--clin_history.vwteamcaremembers   - done and checked replacement
--clin_mentalhealth.vwteamcaremembers  - done and checked replacement
--documents.vwsendingentities  - done and checked replacement
--documents.vwdocuments  - done and checked replacement
--clin_requests.vwrequestsordered  - done and checked replacement
--clin_requests.vwrequestforms  - done and checked replacement
--documents.vwhl7filesimported   - done and checked replacement
--clin_recalls.vwrecallsdue  - done and checked replacement
--clerical.vwtaskscomponents  - done and checked replacement
--clerical.vwtaskscomponents_new - drop this
--clerical.vwtaskscomponentsandnotes - done and checked replacement
--research.diabetes_temp  - done and checked replacement
--research.diabetes_patients_latest_hba1c - done and checked replacement
--clin_workcover.vwworkcover - done and checked replacement


CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, addresses.pk AS fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
        persons.language_problems, 
        marital.marital, sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, occupation.occupation, addresses.street, towns.town, towns.state, towns.postcode, addresses.fk_town, lu_address_types.type AS address_type, addresses.fk_lu_address_type, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital, persons.fk_title, persons.fk_sex, persons.fk_occupation, persons.retired, persons.deceased, persons.date_deceased, patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer, patients.fk_family, patients.active_status, patients.medicare_number, patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_card_type, patients.veteran_specific_condition, patients.concession_card_name, patients.concession_type, patients.concession_number, patients.concession_expiry_date, patients.file_paper_number, patients.atsi, patients.file_racgp_format, patients.file_chart_status, patients.private_billing_concession, patients.private_insurance, patients.memo AS patient_memo, all_images.pk AS fk_image, all_images.image
   FROM contacts.data_persons persons
   LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
   LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN all_images ON persons.fk_image = all_images.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   JOIN clerical.data_patients patients ON persons.pk = patients.fk_person
   LEFT JOIN common.lu_occupations occupation ON persons.fk_occupation = occupation.pk
  ORDER BY patients.fk_person;

ALTER TABLE contacts.vwpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;
COMMENT ON VIEW contacts.vwpatients IS 'unique key for this view is pk_view. If the patient has an address then this is in the format 
patient.pk-addresspk (e.g 1-1) otherwise patient.pk-0 (e.g 1-0)';



CREATE OR REPLACE VIEW contacts.vwpersons AS 
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view, ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
        data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, fk_language, 
        data_persons.language_problems,
        data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, data_persons.fk_occupation, data_persons.fk_category, data_persons.retired, data_persons.deceased, data_persons.date_deceased, data_persons.deleted, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, lu_occupations.occupation, lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, lu_categories.category, "Addresses".street, "Addresses".fk_town, "Addresses".fk_lu_address_type, lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image
   FROM contacts.data_persons
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN common.lu_occupations ON data_persons.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_categories ON data_persons.fk_category = lu_categories.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN contacts.images ON data_persons.fk_image = images.pk
   LEFT JOIN contacts.links_persons_addresses ON data_persons.pk = links_persons_addresses.fk_person
   LEFT JOIN common.lu_countries ON data_persons.country_code = lu_countries.country_code::text
   LEFT JOIN contacts.data_addresses "Addresses" ON links_persons_addresses.fk_address = "Addresses".pk
   LEFT JOIN contacts.lu_address_types ON "Addresses".fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns ON "Addresses".fk_town = lu_towns.pk
  ORDER BY data_persons.pk, links_persons_addresses.fk_address;

ALTER TABLE contacts.vwpersons OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, vwpersons.salutation, 
 vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.language_problems,
 vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, 
 vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.fk_category, vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, 
 vwpersons.sex, vwpersons.sex_text, vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.category, vwpersons.language, vwpersons.country, 
 vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street,
  vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, vwpersons.postal_address, 
  vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, vwpersons.deleted
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN all_images ON vwpersons.fk_image = all_images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;


CREATE OR REPLACE VIEW contacts.vwpersonsoremployees_by_occupation AS 
         SELECT DISTINCT vwemployees.fk_person AS pk_view, vwemployees.fk_person, vwemployees.surname, 
         vwemployees.firstname, (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, vwemployees.occupation
           FROM contacts.vwemployees
          WHERE vwemployees.person_deleted = false
UNION 
         SELECT DISTINCT vwpersonsexcludingpatients.fk_person AS pk_view, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, (((vwpersonsexcludingpatients.title || ' '::text) || vwpersonsexcludingpatients.firstname) || ' '::text) || vwpersonsexcludingpatients.surname AS wholename, vwpersonsexcludingpatients.occupation
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.retired = false AND vwpersonsexcludingpatients.deceased = false AND vwpersonsexcludingpatients.deleted = false AND vwpersonsexcludingpatients.occupation IS NOT NULL
  ORDER BY 3, 4;

ALTER TABLE contacts.vwpersonsoremployees_by_occupation OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsoremployees_by_occupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsoremployees_by_occupation TO staff;
COMMENT ON VIEW contacts.vwpersonsoremployees_by_occupation IS 'a view of all people in the database, either employees in companies or sole traders';

CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode
           FROM contacts.vworganisationsemployees
          WHERE vworganisationsemployees.fk_person <> 0
UNION 
         SELECT vwpersonsexcludingpatients.fk_address, 
                CASE
                    WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
                    ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
                END AS pk_view, NULL::unknown AS fk_branch, NULL::unknown AS branch, NULL::unknown AS organisation, NULL::unknown AS fk_organisation, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.fk_person <> 0 AND vwpersonsexcludingpatients.fk_address IS NOT NULL
  ORDER BY 6, 12;

ALTER TABLE contacts.vwpersonsandemployeesaddresses OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO staff;
COMMENT ON VIEW contacts.vwpersonsandemployeesaddresses IS 'A view of all addresses for a person whether they have a private address or their address as an employee of an organisation';

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
        marital.marital, sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, 
        addresses.street, towns.town, towns.state, towns.postcode, addresses.fk_town, lu_address_types.type AS address_type, 
        addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, 
        addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, addresses.deleted AS address_deleted, 
        persons.fk_ethnicity, persons.fk_language, persons.language_problems, 
         persons.memo, persons.fk_marital, persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, all_images.pk AS fk_image, all_images.image
   FROM contacts.data_persons persons
   LEFT JOIN clerical.data_patients ON persons.pk = data_patients.pk
   LEFT JOIN contacts.links_persons_addresses ON persons.pk = links_persons_addresses.fk_person
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN all_images ON persons.fk_image = all_images.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   JOIN contacts.data_addresses addresses ON links_persons_addresses.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = addresses.fk_lu_address_type
   JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk;

ALTER TABLE contacts.vwpersonsincludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';

CREATE OR REPLACE VIEW documents.vwsendingentities AS 
        (        (         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, NULL::unknown AS branch, NULL::unknown AS organisation, false AS organisation_deleted, NULL::unknown AS fk_organisation, false AS branch_deleted, NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, NULL::unknown AS organisation_street, NULL::unknown AS fk_town_organisation, NULL::unknown AS organisation_postal_address, NULL::unknown AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
                           FROM documents.sending_entities
                      JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
                 LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
            JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
       JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
      WHERE vwpersons.deleted = false AND sending_entities.fk_branch = 0 AND sending_entities.fk_employee = 0
                UNION 
                         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode, NULL::unknown AS person_street, NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state, NULL::unknown AS person_category
                           FROM documents.sending_entities
                      JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
                 LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
            JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
       JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
      WHERE vworganisations.branch_deleted = false AND sending_entities.fk_employee = 0 AND sending_entities.fk_person = 0)
        UNION 
                 SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
                   FROM documents.sending_entities
              JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
         LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
    JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
   JOIN contacts.data_employees ON sending_entities.fk_employee = data_employees.pk
   JOIN contacts.vwpersons ON data_employees.fk_person = vwpersons.fk_person
  WHERE vwpersons.deleted = false AND data_employees.deleted = false)
UNION 
         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, NULL::unknown AS branch, NULL::unknown AS organisation, NULL::unknown AS organisation_deleted, NULL::unknown AS fk_organisation, NULL::unknown AS branch_deleted, NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, NULL::unknown AS organisation_street, NULL::unknown AS fk_town_organisation, false AS organisation_postal_address, false AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode, NULL::unknown AS person_street, NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state, NULL::unknown AS person_category
           FROM documents.sending_entities
      LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
   JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
  WHERE sending_entities.fk_branch IS NULL AND sending_entities.fk_employee IS NULL AND sending_entities.fk_person IS NULL;

ALTER TABLE documents.vwsendingentities OWNER TO easygp;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, 
 documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, 
documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, 
documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, 
documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, 
documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, 
vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version,
 vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style,
 vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person,
 vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color,
 vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.organisation, vwsendingentities.organisation_category, 
vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, 
vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title,
 vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, 
vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, 
unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, 
unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town,
 unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, 
unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
   FROM documents.documents
   JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
   LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
   LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
   LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
   LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk
  ORDER BY documents.fk_patient, documents.date_created;

ALTER TABLE documents.vwdocuments OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO staff;


CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
   FROM clin_requests.forms
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.lu_request_type ON lu_requests.fk_lu_request_type = lu_request_type.pk
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
   JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsordered OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsordered TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsordered TO staff;
COMMENT ON VIEW clin_requests.vwrequestsordered IS 'a view of all requests ordered along with form detail, i.e
 for a form with say fbc, uec, lfts on it
 row1 = form data + fbc
 row2 = form data + uec etc ';

CREATE OR REPLACE VIEW clin_requests.vwrequestforms AS 
 SELECT forms.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
   FROM clin_requests.forms
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.lu_request_type ON lu_requests.fk_lu_request_type = lu_request_type.pk
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
   JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;
COMMENT ON VIEW clin_requests.vwrequestforms IS 'A view of just the unique forms, where the forms requests are represented only by for example fbc;uec;lfts
 Note that clin_requests.vwRequestFormsAndRequests has multiple rows for each form, one per request on that form';


CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO staff;

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, 
 recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.fk_status, recalls.additional_text, 
 recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_audit, recalls.fk_progressnote, recalls.fk_pasthistory,
  vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, 
  vwpatients.age, vwpatients.sex, vwpatients.title, vwpatients.street, vwpatients.town, vwpatients.state, vwpatients.postcode, 
  vwPatients.language_problems, vwpatients.language,
  consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, 
  vwstaff.title AS staff_to_see_title, lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, 
  lu_appointment_length.length AS appointment_length, lu_status.status, consult.consult_date
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   JOIN clin_recalls.lu_status ON recalls.fk_status = lu_status.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO staff;

CREATE OR REPLACE VIEW research.diabetes_temp AS 
 SELECT DISTINCT ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS hba1c
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
  ORDER BY ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1);

CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c AS 
 SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age, ( SELECT vwobservations.observation_date
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS observation_date, ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1) AS hba1c
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
  ORDER BY ( SELECT vwobservations.value_numeric
           FROM documents.vwobservations
          WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
          ORDER BY vwobservations.observation_date DESC
         LIMIT 1);

ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO staff;

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, consult.consult_date AS visit_date, 
 consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, 
 claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, consult.fk_staff, consult.fk_type, consult.summary, 
 vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, 
 vwstaff.provider_number, lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, 
 vworganisations.street AS branch_street, vworganisations.town AS branch_town, vworganisations.branch_deleted, 
 vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, 
 vwpersons.town AS soletrader_town, vwpersons.street AS soletrader_street, vwpersons.postcode AS soletrader_postcode, 
 vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, visits.fk_lu_visit_type, visits.diagnosis, 
 lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.certificate_date, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, lu_caused_by_employment.caused_by_employment
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_workcover.visits ON visits.fk_consult = consult.pk
   JOIN clin_workcover.claims ON claims.pk = visits.fk_claim
   JOIN common.lu_occupations ON claims.fk_occupation = lu_occupations.pk
   LEFT JOIN coding.lu_systems ON visits.fk_coding_system = lu_systems.pk
   LEFT JOIN contacts.vworganisations ON claims.fk_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersons ON claims.fk_person = vwpersons.fk_person
   JOIN clin_workcover.lu_visit_type ON visits.fk_lu_visit_type = lu_visit_type.pk
   JOIN clin_workcover.lu_caused_by_employment ON visits.fk_caused_by_employment = lu_caused_by_employment.pk
   JOIN clin_consult.consult consult1 ON claims.fk_consult = consult1.pk
  ORDER BY visits.fk_claim, visits.pk;

ALTER TABLE clin_workcover.vwworkcover OWNER TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT SELECT ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';


CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_history.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO staff;

CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 59)
 