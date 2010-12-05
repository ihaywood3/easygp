drop view contacts.vworganisationsbycategory;
drop view contacts.vwemployeesnew ;
drop view contacts.vwpersonsoremployees_by_occupation;
drop view contacts.vwEmployees;
drop view clin_requests.vwuserproviderdefaults ;
drop view clin_requests.vwrequestsordered;
drop view clin_requests.vwrequestforms;

drop view contacts.vworganisations cascade; -- cascades to  documents.vwsendingentities, documents.vwdocuments,documents.vwhl7filesimported, clin_workcover.vwworkcover
--drop view documents.vwsendingentities;
--drop view documents.vwdocuments;
--drop view documents.vwhl7filesimported;
--drop view clin_workcover.vwworkcover;
drop view clin_referrals.vwreferralsinbox ;
drop view clin_referrals.vwreferrals;
drop view clin_procedures.vwskinprocedures;
drop view contacts.vworganisationsemployees cascade; 
-- cascades to the following views
--drop view clin_history.vwteamcaremembers;
--drop view clin_mentalhealth.vwteamcaremembers;
--drop view clin_requests.vwrequestproviders;
drop view "admin".vwstaffinclinics cascade;
-- cascades to the following views
-- drop view clerical.vwtaskscomponents;
-- drop view clerical.vwtaskscomponentsnotes ;
-- drop view clin_certificates.vwmedicalcertificates;
-- drop view documents.vwinboxstaff;
-- drop view clerical.vwtaskscomponents_new ;
drop view "admin".vwclinics cascade;
-- drop cascades to:
-- drop "admin".vwclinicrooms

ALTER TABLE "contacts"."data_organisations"
  ALTER COLUMN "organisation" TYPE TEXT;


  
CREATE OR REPLACE VIEW contacts.vworganisationsbycategory AS 
 SELECT DISTINCT data_organisations.organisation, data_branches.branch, data_branches.pk AS pk_branch, lu_categories.category, data_branches.fk_organisation
   FROM contacts.data_branches
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
  WHERE data_organisations.deleted = false AND data_branches.deleted = false
  ORDER BY lu_categories.category, data_organisations.organisation, data_branches.branch;

ALTER TABLE contacts.vworganisationsbycategory OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsbycategory TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsbycategory TO staff;


CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, data_employees.fk_category AS fk_category_employee, lu_categories1.category AS employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted
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


CREATE OR REPLACE VIEW contacts.vwpersonsoremployees_by_occupation AS 
         SELECT DISTINCT vwemployees.fk_person AS pk_view, vwemployees.fk_person, vwemployees.surname, vwemployees.firstname, (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, vwemployees.occupation
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


CREATE OR REPLACE VIEW clin_requests.vwuserproviderdefaults AS 
 SELECT user_provider_defaults.pk AS pk_default, user_provider_defaults.fk_staff, user_provider_defaults.fk_default_branch, user_provider_defaults.fk_head_office_branch, user_provider_defaults.send_electronically, user_provider_defaults.print_paper, user_provider_defaults.deleted, user_provider_defaults.fk_lu_request_type, data_branches.branch AS default_branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS default_branch_memo, data_branches.fk_category, data_branches.deleted AS default_branch_deleted, data_organisations.organisation, lu_request_type.type AS request_type, lu_categories.category AS category_organisation, data_addresses.street AS default_branch_street, lu_towns.town AS default_branch_town, lu_towns.postcode AS default_branch_postcode, data_branches1.branch AS headoffice_branch, data_addresses1.street AS headoffice_street, lu_towns1.postcode AS headoffice_postcode, lu_towns1.town AS headoffice_town
   FROM clin_requests.user_provider_defaults
   JOIN contacts.data_branches ON user_provider_defaults.fk_default_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN clin_requests.lu_request_type ON user_provider_defaults.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.data_branches data_branches1 ON user_provider_defaults.fk_head_office_branch = data_branches1.pk
   JOIN contacts.data_addresses data_addresses1 ON data_branches1.fk_address = data_addresses1.pk
   JOIN contacts.lu_towns lu_towns1 ON data_addresses1.fk_town = lu_towns1.pk
  ORDER BY user_provider_defaults.fk_staff;

ALTER TABLE clin_requests.vwuserproviderdefaults OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO staff;

CREATE OR REPLACE VIEW contacts.vworganisations AS 
 SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state
   FROM contacts.data_branches branches
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
  ORDER BY nextval('contacts.vworganisations_pk_seq'::regclass), organisations.organisation, organisations.deleted;

ALTER TABLE contacts.vworganisations OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisations TO easygp;
GRANT ALL ON TABLE contacts.vworganisations TO staff;


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
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.organisation, vwsendingentities.organisation_category, vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
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

ALTER TABLE clin_workcover.vwworkcover OWNER TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';

CREATE OR REPLACE VIEW clin_referrals.vwreferralsinbox AS 
 SELECT inbox.pk, inbox.fk_patient, inbox.fk_organisation, inbox.fk_employee, inbox.fk_person, inbox.date, inbox.fk_health_issue, inbox.tag, inbox.html, data_organisations.organisation, data_persons.firstname AS employee_firstname, data_persons.surname AS employee_surname, lu_title.title AS employee_title, lu_title1.title, data_persons1.firstname, data_persons1.surname
   FROM clin_referrals.inbox
   LEFT JOIN clin_history.past_history ON inbox.fk_health_issue = past_history.pk
   LEFT JOIN contacts.data_organisations ON inbox.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_employees ON inbox.fk_employee = data_employees.pk
   LEFT JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.data_persons data_persons1 ON inbox.fk_person = data_persons1.pk
   LEFT JOIN contacts.lu_title lu_title1 ON data_persons1.fk_title = lu_title1.pk
  ORDER BY inbox.fk_patient;

ALTER TABLE clin_referrals.vwreferralsinbox OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferralsinbox TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferralsinbox TO staff;


CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
 SELECT referrals.pk AS pk_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_branch, referrals.fk_type, referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.include_healthsummary, referrals.include_careplan, consult.consult_date AS date, consult.fk_patient, consult.fk_staff, data_persons.firstname AS provider_firstname, data_persons.surname AS provider_surname, lu_title.title AS provider_title, data_branches.branch, data_organisations.organisation, lu_type.type, lu_categories.category, data_addresses.street, lu_towns.postcode, lu_towns.town, data_branches.fk_organisation, referrals.fk_pasthistory, referrals.fk_progressnote
   FROM clin_referrals.referrals
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   LEFT JOIN contacts.data_persons ON referrals.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.data_branches ON referrals.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
  WHERE referrals.deleted = false
  ORDER BY consult.fk_patient DESC;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;


CREATE OR REPLACE VIEW clin_procedures.vwskinprocedures AS 
 SELECT skin_procedures.pk AS pk_view, skin_procedures.pk AS fk_skin_procedure, skin_procedures.fk_consult, skin_procedures.date, skin_procedures.explained_procedure, skin_procedures.obtained_consent, skin_procedures.detailed_complications, skin_procedures.fk_lu_site, skin_procedures.lesion_notes, skin_procedures.dermoscopy_notes, skin_procedures.fk_lu_lateralisation, skin_procedures.fk_lu_anterior_posterior, skin_procedures.localisation, skin_procedures.surgical_pack_identifier, skin_procedures.fk_lu_skin_preparation, skin_procedures.fk_lu_anaesthetic_agent, skin_procedures.fk_lu_procedure_type, skin_procedures.fk_lu_repair_type, skin_procedures.fk_subcutaneous_suture, skin_procedures.fk_skin_suture, skin_procedures.average_diameter_cm, skin_procedures.fk_provisional_diagnosis, generic_terms.term AS provisional_diagnosis, skin_procedures.fk_document, skin_procedures.fk_actual_diagnosis, generic_terms1.term AS actual_diagnosis, skin_procedures.fk_pasthistory, skin_procedures.referred, skin_procedures.review_months, skin_procedures.fk_branch, skin_procedures.fk_form, skin_procedures.complications, skin_procedures.fk_progressnote_auto, progressnotes.notes AS progressnote_auto, skin_procedures.fk_progressnote_user, progressnotes1.notes AS progressnote_user, consult.consult_date, consult.fk_staff, consult.fk_patient, lu_anatomical_site.site, lu_anterior_posterior.anterior_posterior, lu_laterality.laterality, lu_skin_preparation.preparation, lu_anaesthetic_agent.agent, lu_anaesthetic_agent.fk_lu_route_administration, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, data_organisations.organisation, vwstaff.wholename, vwstaff.title
   FROM clin_procedures.skin_procedures
   JOIN clin_consult.consult ON skin_procedures.fk_consult = consult.pk
   JOIN common.lu_anatomical_site ON skin_procedures.fk_lu_site = lu_anatomical_site.pk
   LEFT JOIN common.lu_anterior_posterior ON skin_procedures.fk_lu_anterior_posterior = lu_anterior_posterior.pk
   LEFT JOIN common.lu_laterality ON skin_procedures.fk_lu_lateralisation = lu_laterality.pk
   LEFT JOIN clin_procedures.lu_skin_preparation ON skin_procedures.fk_lu_skin_preparation = lu_skin_preparation.pk
   LEFT JOIN coding.generic_terms ON skin_procedures.fk_provisional_diagnosis = generic_terms.code
   JOIN clin_procedures.lu_anaesthetic_agent ON skin_procedures.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk
   JOIN clin_procedures.lu_procedure_type ON skin_procedures.fk_lu_procedure_type = lu_procedure_type.pk
   JOIN clin_procedures.lu_repair_type ON skin_procedures.fk_lu_repair_type = lu_repair_type.pk
   JOIN clin_procedures.lu_suture_type ON skin_procedures.fk_skin_suture = lu_suture_type.pk
   JOIN clin_procedures.lu_suture_type lu_suture_type1 ON skin_procedures.fk_subcutaneous_suture = lu_suture_type1.pk
   LEFT JOIN coding.generic_terms generic_terms1 ON skin_procedures.fk_actual_diagnosis = generic_terms1.code
   LEFT JOIN contacts.data_branches ON skin_procedures.fk_branch = data_branches.pk
   LEFT JOIN clin_requests.forms ON skin_procedures.fk_form = forms.pk
   LEFT JOIN clin_consult.progressnotes progressnotes1 ON skin_procedures.fk_progressnote_user = progressnotes1.pk
   JOIN clin_consult.progressnotes ON skin_procedures.fk_progressnote_auto = progressnotes.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
  ORDER BY consult.fk_patient;

ALTER TABLE clin_procedures.vwskinprocedures OWNER TO easygp;
GRANT ALL ON TABLE clin_procedures.vwskinprocedures TO easygp;
GRANT ALL ON TABLE clin_procedures.vwskinprocedures TO staff;

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_category AS fk_employee_category, employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title
           FROM contacts.data_employees employees
      JOIN contacts.data_branches branches ON employees.fk_branch = branches.pk
   LEFT JOIN contacts.lu_categories categories ON employees.fk_category = categories.pk
   LEFT JOIN contacts.lu_employee_status employee_status ON employees.fk_status = employee_status.pk
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN common.lu_occupations occupations ON employees.fk_occupation = occupations.pk
   LEFT JOIN contacts.data_persons persons ON employees.fk_person = persons.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
  WHERE employees.fk_person IS NOT NULL
UNION 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, (organisations.organisation::text || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation, 0 AS fk_employee_category, 0 AS fk_status, NULL::unknown AS employee_status, false AS employee_deleted, NULL::unknown AS occupation, 0 AS fk_person, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS salutation, NULL::unknown AS birthdate, false AS deceased, NULL::unknown AS date_deceased, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::unknown AS sex, NULL::unknown AS title
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
  ORDER BY 1, 3, 4, 29, 28;

ALTER TABLE contacts.vworganisationsemployees OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;
CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
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
                END AS wholename, ((vworganisationsemployees.organisation::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
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

CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
 SELECT lu_request_type.type, request_providers.fk_lu_request_type, request_providers.fk_person, request_providers.fk_employee, request_providers.fk_branch, request_providers.pk AS pk_request_provider, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.postcode, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.fk_organisation, vworganisationsemployees.category, vworganisationsemployees.street, vworganisationsemployees.head_office
   FROM clin_requests.request_providers
   JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.vworganisationsemployees ON request_providers.fk_branch = vworganisationsemployees.fk_branch
  ORDER BY request_providers.fk_lu_request_type, vworganisationsemployees.organisation;

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;


CREATE OR REPLACE VIEW "admin".vwstaffinclinics AS 
 SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number, staff.prescriber_number, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, data_employees.fk_category AS fk_employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_categories.category AS employee_category, lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, all_images.image, all_images.deleted AS image_deleted, lu_staff_roles.role, lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted, data_addresses.street, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_categories ON data_employees.fk_category = lu_categories.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN common.lu_ethnicity ON data_persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN all_images ON data_persons.fk_image = all_images.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   JOIN contacts.lu_employee_status ON staff.fk_status = lu_employee_status.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
  ORDER BY data_branches.branch, data_persons.surname;

ALTER TABLE "admin".vwstaffinclinics OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwstaffinclinics TO easygp;
GRANT ALL ON TABLE "admin".vwstaffinclinics TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_task_types.type AS task_type, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN clerical.lu_task_types ON task_components.fk_lu_task_type = lu_task_types.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;


CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult, medical_certificates.date AS certificate_date, medical_certificates.reason, medical_certificates.fk_coding_system, medical_certificates.fk_code, medical_certificates.fk_lu_illness_temporality, medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date, medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street AS staff_street, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code
   FROM clin_certificates.medical_certificates medical_certificates
   JOIN clin_consult.consult ON medical_certificates.fk_consult = consult.pk
   JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
   JOIN clin_certificates.lu_illness_temporality ON medical_certificates.fk_lu_illness_temporality = lu_illness_temporality.pk
   JOIN clin_certificates.lu_fitness ON medical_certificates.fk_lu_fitness = lu_fitness.pk
   LEFT JOIN coding.lu_systems ON medical_certificates.fk_coding_system = lu_systems.pk
   LEFT JOIN coding.generic_terms ON medical_certificates.fk_code = generic_terms.code
  WHERE medical_certificates.deleted = false
  ORDER BY consult.fk_patient, consult.consult_date;

ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO staff;
COMMENT ON VIEW clin_certificates.vwmedicalcertificates IS 'A view of patients medical certificate history, includes written by which staff member and where';


CREATE OR REPLACE VIEW documents.vwinboxstaff AS 
         SELECT vwstaffinclinics.pk_view, vwstaffinclinics.title, vwstaffinclinics.fk_staff, vwstaffinclinics.wholename, vwstaffinclinics.surname, NULL::unknown AS fk_unmatched_staff
           FROM admin.vwstaffinclinics
UNION 
         SELECT (unmatched_staff.pk || '-'::text) || 'unmatched'::text AS pk_view, unmatched_staff.title, unmatched_staff.fk_real_staff AS fk_staff, (unmatched_staff.firstname || ' '::text) || (unmatched_staff.surname || ' [Unkown]'::text) AS wholename, unmatched_staff.surname, unmatched_staff.pk AS fk_unmatched_staff
           FROM documents.unmatched_staff
          WHERE unmatched_staff.fk_real_staff IS NULL
  ORDER BY 5;

ALTER TABLE documents.vwinboxstaff OWNER TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO staff;
COMMENT ON VIEW documents.vwinboxstaff IS 'All staff with an inbox. If the staff member is unknown, they will still
 appear, once matched to a real staff member they are not pulled from
 the unmatched table ie fk_real_staff <> null then';
CREATE OR REPLACE VIEW clerical.vwtaskscomponents_new AS 
 SELECT tasks.task, tasks.fk_staff_filed_task, tasks.fk_staff_finalised_task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, tasks.date_finalised, tasks.deleted AS task_deleted, task_components.pk AS pk_view, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.date_logged, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics1.wholename AS staff_finalised_task_wholname, vwstaffinclinics1.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_allocated_wholename, vwstaffinclinics2.title AS staff_allocated_title, vwstaffinclinics3.wholename AS staff_completed_component_wholename, vwstaffinclinics3.title AS staff_completed_component_title, consult.consult_date AS date_component_logged, lu_urgency.urgency, vwstaff.fk_staff AS fk_staff_filed_component, vwstaff.wholename AS staff_filed_component_wholename, vwstaff.title AS staff_filed_component_title, vwpatients.wholename AS patient_wholename, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.fk_sex, vwpatients.fk_title AS patient_fk_title, vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.age AS patient_age, lu_task_types.type AS task_type
   FROM clerical.tasks
   JOIN clerical.task_components ON tasks.pk = task_components.fk_task
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON tasks.fk_staff_finalised_task = vwstaffinclinics1.fk_staff
   JOIN admin.vwstaffinclinics vwstaffinclinics2 ON task_components.fk_staff_allocated = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON task_components.fk_staff_completed = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN clerical.lu_task_types ON task_components.fk_lu_task_type = lu_task_types.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents_new OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO staff;


CREATE OR REPLACE VIEW "admin".vwclinics AS 
 SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, data_addresses.street, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, data_organisations.deleted AS organisation_deleted, lu_categories.category
   FROM admin.clinics
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
  ORDER BY data_organisations.organisation, data_branches.fk_address;

ALTER TABLE "admin".vwclinics OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwclinics TO easygp;
GRANT ALL ON TABLE "admin".vwclinics TO staff;

CREATE OR REPLACE VIEW "admin".vwclinicrooms AS 
 SELECT clinic_rooms.pk, clinic_rooms.room_name, clinic_rooms.script_printer, clinic_rooms.default_printer, clinic_rooms.fk_clinic, vwclinics.organisation, vwclinics.branch, vwclinics.street, vwclinics.town
   FROM admin.clinic_rooms, admin.vwclinics
  WHERE clinic_rooms.fk_clinic = vwclinics.fk_clinic
  ORDER BY clinic_rooms.fk_clinic, clinic_rooms.room_name;

ALTER TABLE "admin".vwclinicrooms OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwclinicrooms TO easygp;
GRANT ALL ON TABLE "admin".vwclinics TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 46);