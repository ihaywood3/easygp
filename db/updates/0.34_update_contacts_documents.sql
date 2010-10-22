drop view contacts.vwPersons cascade; 

--cascades to:
-- documents.vwsendingentities
-- documents.vwdocuments depends
-- clin_requests.vwforms 
-- documents.vwhl7filesimported
-- clin_workcover.vwworkcover
-- contacts.vwpersonsexcludingpatients


CREATE OR REPLACE VIEW contacts.vwpersons AS 
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view, ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
         data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity,
         data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, 
         data_persons.fk_image, data_persons.fk_occupation, data_persons.fk_category, data_persons.retired, data_persons.deceased, 
         data_persons.date_deceased, 
         data_persons.deleted,
         lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, 
         lu_occupations.occupation, lu_languages.language, lu_countries.country, 
         links_persons_addresses.pk AS fk_link_address, links_persons_addresses.fk_address, lu_towns.postcode, 
         lu_towns.town, lu_towns.state, data_persons.country_code, lu_categories.category, "Addresses".street, "Addresses".fk_town, 
         "Addresses".fk_lu_address_type, lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, 
         "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image
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

--insert missing field data_persons.deleted into employee view

DROP VIEW contacts.vwemployees;


CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, data_employees.fk_category AS fk_category_employee, lu_categories1.category AS employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted, data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted
   FROM contacts.data_employees
   JOIN contacts.data_branches ON data_employees.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.lu_categories lu_categories1 ON data_employees.fk_category = lu_categories1.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
  WHERE data_employees.deleted = false
  ORDER BY data_persons.surname, data_persons.firstname;

ALTER TABLE contacts.vwemployees OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO staff;


CREATE OR REPLACE VIEW documents.vwsendingentities AS 
        (         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, NULL::unknown AS branch, NULL::unknown AS organisation, false AS organisation_deleted, NULL::unknown AS fk_organisation, false AS branch_deleted, NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, NULL::unknown AS organisation_street, NULL::unknown AS fk_town_organisation, NULL::unknown AS organisation_postal_address, NULL::unknown AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
                   FROM documents.sending_entities
              JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
         LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
    JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
  WHERE vwpersons.deleted = false AND sending_entities.fk_branch = 0 AND sending_entities.fk_employee = 0
        UNION 
                 SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode, NULL::unknown AS person_street, NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state, NULL::unknown AS person_category
                   FROM documents.sending_entities
              JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
         LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
    JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
  WHERE vworganisations.branch_deleted = false AND sending_entities.fk_employee = 0 AND sending_entities.fk_person = 0)
UNION 
         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
           FROM documents.sending_entities
      JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
   LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
   JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
   JOIN contacts.data_employees ON sending_entities.fk_employee = data_employees.pk
   JOIN contacts.vwpersons ON data_employees.fk_person = vwpersons.fk_person
  WHERE vwpersons.deleted = false AND data_employees.deleted = false;

ALTER TABLE documents.vwsendingentities OWNER TO easygp;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;







CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.organisation_category, vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
   FROM documents.documents
   JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
   LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
   LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
   LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
   LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk
  ORDER BY documents.fk_patient, documents.date_created;

ALTER TABLE documents.vwdocuments OWNER TO richard;
GRANT ALL ON TABLE documents.vwdocuments TO richard;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported OWNER TO richard;
GRANT ALL ON TABLE documents.vwhl7filesimported TO richard;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.fk_category, vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.category, vwpersons.language, vwpersons.country, vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street, vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN all_images ON vwpersons.fk_image = all_images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients OWNER TO richard;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO richard;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, consult.consult_date AS visit_date, consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, consult.fk_staff, consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, vwstaff.provider_number, lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, vworganisations.street AS branch_street, vworganisations.town AS branch_town, vworganisations.branch_deleted, vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, vwpersons.town AS soletrader_town, vwpersons.street AS soletrader_street, vwpersons.postcode AS soletrader_postcode, vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, lu_caused_by_employment.caused_by_employment
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

ALTER TABLE clin_workcover.vwworkcover OWNER TO richard;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO richard;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';


CREATE OR REPLACE VIEW clin_requests.vwforms AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type AS fk_lu_type, lu_type.type,
  forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate,
   data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item,
    forms.date AS request_date, forms_requests.request_result_html, forms.forms_results_html, forms.fk_progressnote, forms_requests.fk_lu_request, 
    forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, 
    forms.notes_summary, forms.medications_summary, forms.copyto, forms.form_html, forms.deleted, forms.copyto_patient, forms.urgent,
     forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, 
     lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname,
      data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
   FROM clin_requests.forms
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.lu_type ON lu_requests.fk_type = lu_type.pk
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
   JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwforms OWNER TO richard;
GRANT ALL ON TABLE clin_requests.vwforms TO richard;
GRANT ALL ON TABLE clin_requests.vwforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwforms TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 34);


