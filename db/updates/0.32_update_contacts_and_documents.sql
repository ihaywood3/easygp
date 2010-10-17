Alter table documents.documents add column fk_lu_request_type integer default null;

comment on column documents.documents.fk_lu_request_type is
' - key to clin_requests.lu_request_type table which contains the types
    of requests e.g Pathology Radiology Vascular. 
  - note this field over-rides the 
   fk_lu_request_type of a given documents.sending_entities.fk_lu_request_type
   which is there to aid FDocumentMetadata guess the likely type of request for
   a given sender of messages, but may not be correct all the time';

-- major change for a minor lapse - accidently added many moons ago an ascii blank to wholename field in vwOrganisations Employees

ALTER TABLE documents.sending_entities
  RENAME COLUMN fk_lu_provider_type TO fk_lu_request_type;

DROP VIEW contacts.vworganisationsemployees cascade;

-- This cascades to
-- view documents.vwsendingentities
-- documents.vwdocuments
-- clin_requests.vwforms
-- documents.vwhl7filesimported
-- clin_history.vwteamcaremembers
-- clin_mentalhealth.vwteamcaremembers
-- clin_requests.vwrequestproviders

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname)
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

-- replaces the concept of having the contacts category probably = the type of request
-- with a specific link to the clin_requests.lu_request_type table.

CREATE OR REPLACE VIEW documents.vwsendingentities AS 
 SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type,
 lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, 
 sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, 
 sending_entities.fk_person, sending_entities.fk_lu_message_standard, sending_entities.exclude_ft_report, 
 sending_entities.exclude_pit, lu_message_display_style.style, sending_entities.abnormals_foreground_color,
  sending_entities.abnormals_background_color, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, 
  vworganisationsemployees.organisation, vworganisationsemployees.branch, 
  vworganisationsemployees.fk_address AS fk_address_organisation, vworganisationsemployees.fk_category AS fk_category_organisation, 
  vworganisationsemployees.category AS organisation_category, vworganisationsemployees.street AS organisation_street, 
  vworganisationsemployees.fk_town AS fk_town_organisation, vworganisationsemployees.postal_address AS organisation_postal_address, 
  vworganisationsemployees.head_office AS organisation_head_office, vworganisationsemployees.postcode AS organisation_postcode, 
  vworganisationsemployees.town AS organisation_town, vworganisationsemployees.state AS organisation_state, 
  vworganisationsemployees.fk_organisation, vwpersons.firstname, vwpersons.surname, vwpersons.fk_title, 
  vwpersons.fk_sex, vwpersons.fk_occupation, vwpersons.fk_category AS fk_category_person, 
  vwpersons.category AS person_category, vwpersons.occupation AS person_occupation, 
  vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person
   FROM documents.sending_entities
   LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
   JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
   LEFT JOIN contacts.vworganisationsemployees ON sending_entities.fk_branch = vworganisationsemployees.fk_branch
   LEFT JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
  ORDER BY sending_entities.msh_sending_entity;

ALTER TABLE documents.vwsendingentities OWNER TO richard;
GRANT ALL ON TABLE documents.vwsendingentities TO richard;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;
COMMENT ON VIEW documents.vwsendingentities IS 'View of the sending entities note:
  -  LEFT JOIN contacts.lu_categories as when a file is parsed fk_lu_provider type cannot exist
  -  ditto for the sending organisation, employee or person
  -  not employee not implemented';





CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity,
  documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient,
   documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, 
   documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, 
   documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, 
   documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, 
   documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, 
   documents.fk_lu_display_as, 
   documents.fk_lu_request_type, lu_request_type.type as request_type,
   vwsendingentities.fk_lu_request_type as sending_entity_fk_lu_request_type, vwsendingentities.request_type as sending_entity_request_type,
    vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, 
    vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, 
    vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, 
    vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, 
    vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, 
    vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color,
     vwsendingentities.exclude_pit, vwsendingentities.organisation_category, 
     vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, 
     vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate,
      vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title, 
      vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
      vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, 
      vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, 
      unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, 
      unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, 
      unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, 
      unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state,
       unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname,
       unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
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





CREATE OR REPLACE VIEW clin_requests.vwforms AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type AS fk_lu_type, lu_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date AS request_date, forms_requests.request_result_html, forms.forms_results_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.form_html, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
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

ALTER TABLE clin_requests.vwforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwforms TO staff;


CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;


ALTER TABLE documents.vwhl7filesimported  OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported  TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported  TO staff;


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


CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
 SELECT lu_request_type.type, request_providers.fk_lu_request_type, request_providers.fk_person, request_providers.fk_employee, request_providers.fk_branch, request_providers.pk AS pk_request_provider, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.postcode, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.fk_organisation, vworganisationsemployees.category, vworganisationsemployees.street, vworganisationsemployees.head_office
   FROM clin_requests.request_providers
   JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.vworganisationsemployees ON request_providers.fk_branch = vworganisationsemployees.fk_branch
  ORDER BY request_providers.fk_lu_request_type, vworganisationsemployees.organisation;

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;


CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, 
         vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, 
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
-- for my now screwed database:

update documents.documents  set fk_lu_request_type = 1 where source_file ILIKE 'dhm%'; --douglas
update documents.documents  set fk_lu_request_type = 1 where source_file ILIKE 'hl7_%'; --symbion
update documents.documents  set fk_lu_request_type = 1 where source_file ILIKE 'whiteb1_%'; -- healthscope
update documents.documents  set fk_lu_request_type = 1 where source_file ILIKE '%_HL7_%_X%_.rlt'; --haps
update documents.documents  set fk_lu_request_type = 2 where source_file ILIKE 'HIG%'; --hunter imaging
update documents.documents  set fk_lu_request_type = 2 where source_file ILIKE 'HRY%'; --hunter radiology
update documents.documents  set fk_lu_request_type = 11 where source_file ILIKE 'NNM%'; --newcastle nuclear medicine
update documents.documents  set fk_lu_request_type = 2 where html ILIKE '%cscan%'; -- cscann radiology - no consistant file names
update documents.documents  set fk_lu_request_type = 5 where fk_sending_entity = 21; -- vascular fix others later!!!!!


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 32);