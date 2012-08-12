-- mistake in last update of this view meaning some patients records 'disappeared' due too the address_deleted flag coming from wrong table.
alter table clerical.data_patients rename column pk_legacy  to fk_legacy;

Drop view contacts.vwPatients cascade;

-- view clerical.vwtaskscomponents depends on view contacts.vwpatients
-- view clerical.vwtaskscomponentsandnotes depends on view contacts.vwpatients
-- view clin_consult.vwpatientconsults depends on view contacts.vwpatients
-- view clin_recalls.vwrecallsdue depends on view contacts.vwpatients
-- view documents.vwdocuments depends on view contacts.vwpatients
-- view clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- view documents.vwhl7filesimported depends on view documents.vwdocuments
-- view research.vwmostrecenteyerelateddocuments depends on view documents.vwdocuments
-- view research.diabetes_patients_latest_hba1c depends on view contacts.vwpatients
-- view research.diabetes_patients_with_hba1c depends on view contacts.vwpatients
-- view research.patientsnameshba1cover75 depends on view contacts.vwpatients
-- view research.vwdiabetes_patients_with_hba1c depends on view contacts.vwpatients
-- view research.vwdiabetics_with_ldlcholesterol depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwdiabetics_with_microalbumins depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwdiabeticsegfr depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwldh depends on view contacts.vwpatients

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, link_person_address.fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer, patients.fk_family, patients.medicare_number, 
        patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_specific_condition, 
        patients.concession_card_number, patients.concession_card_expiry_date, patients.memo AS patient_memo, 
        patients.fk_legacy, patients.fk_lu_aboriginality, patients.fk_lu_veteran_card_type, 
        patients.fk_lu_active_status, patients.fk_lu_centrelink_card_type, patients.fk_lu_billing_type, 
        patients.fk_lu_private_health_fund, patients.private_insurance, lu_active_status.status AS active_status, 
        lu_veteran_card_type.type AS veteran_card_type, lu_centrelink_card_type.type AS concession_card_type, 
        lu_private_health_funds.fund, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
              age_display(age(persons.birthdate::timestamp with time zone)) AS age_display, 
              date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric, 
              persons.fk_ethnicity, persons.fk_language, persons.memo AS person_memo, 
              persons.fk_marital, persons.fk_title, persons.fk_sex, persons.country_code AS country_birth_country_code, 
              persons.fk_image, persons.retired, persons.fk_occupation, persons.deleted AS person_deleted, 
              persons.deceased, persons.date_deceased, persons.language_problems, persons.surname_normalised, 
              lu_aboriginality.aboriginality, country_birth.country AS country_birth, lu_ethnicity.ethnicity, 
              lu_languages.language, lu_occupations.occupation, lu_marital.marital, title.title, 
              lu_sex.sex, lu_sex.sex_text, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image,
               link_person_address.pk AS fk_link_persons_address, addresses.street1, 
               addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
               addresses.head_office, addresses.geolocation, addresses.country_code, 
               addresses.fk_lu_address_type, addresses.deleted as address_deleted, addresses.street2, address_country.country, 
               link_person_address.deleted AS link_address_deleted, lu_address_types.type AS address_type, lu_towns.postcode, 
               lu_towns.town, lu_towns.state,lu_billing_type.name as billing_type
   FROM clerical.data_patients patients
   JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
   LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
   LEFT JOIN common.lu_aboriginality ON patients.fk_lu_aboriginality = lu_aboriginality.pk
   LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
   LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
   LEFT JOIN clerical.lu_billing_type ON patients.fk_lu_billing_type = lu_billing_type.pk
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


ALTER TABLE contacts.vwpatients  OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, 
 tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, 
 vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
 vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
 vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
 task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
 task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
 task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, 
 task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, 
 vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, 
 vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, 
 vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename,
 vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;



CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task,
        tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, tasks.deleted AS task_deleted, 
        tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
        vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
        vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
        task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
        task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
        task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
        vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, 
        vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, 
        vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, 
        vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, 
        lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;



CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view, vwprogressnotes.fk_patient, 
 vwprogressnotes.consult_date, vwprogressnotes.consult_type, vwprogressnotes.fk_staff, 
 vwprogressnotes.title AS staff_title, vwprogressnotes.surname AS staff_surname, vwprogressnotes.firstname AS staff_firstname, 
 vwprogressnotes.linked_table, vwprogressnotes.fk_type, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, 
 vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, 
 vwpatients.deceased, vwpatients.sex, vwpatients.title, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.age_display
   FROM clin_consult.vwprogressnotes, contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;


CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, 
 recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, 
 recalls.active, recalls.additional_text, recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_progressnote, 
 recalls.fk_pasthistory, recalls.fk_sent, recalls.num_reminders, sent.latex, sent.date AS date_reminder_sent, 
 lu_units.abbrev_text, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, 
 vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.sex, vwpatients.title, vwpatients.street1, 
 vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, vwpatients.language_problems, 
 vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, 
 vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, 
 lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, 
 consult.consult_date, recalls.fk_template, lu_appointment_length1.length, lu_templates.name, lu_templates.template
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
   LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue   OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, 
 documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, 
 documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, 
 documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, 
 documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user,
 documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, 
 documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type,
 vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, 
 vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, 
 vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, 
 vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, 
 vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, 
 vwsendingentities.exclude_pit, vwsendingentities.person_occupation, vwsendingentities.organisation, vwsendingentities.organisation_category, 
 vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, 
 vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, 
 vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
 vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, 
 unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate,
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

ALTER TABLE documents.vwdocuments   OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, 
 forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, 
 data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, 
 lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, 
 forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, 
 forms.fk_request_provider AS fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, 
 forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, 
 forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, 
 data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
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
   LEFT JOIN contacts.data_branches ON forms.fk_request_provider = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsordered   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsordered TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported   OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT SELECT ON TABLE documents.vwhl7filesimported TO staff;


CREATE OR REPLACE VIEW research.vwmostrecenteyerelateddocuments AS 
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, vwdocuments.fk_patient, 
 vwdocuments.pk_document AS fk_document, vwdocuments.date_created, vwdocuments.deleted
   FROM documents.vwdocuments
  WHERE (vwdocuments.organisation_category::text ~~* '%ophthal%'::text OR vwdocuments.organisation_category::text ~~* '%optom%'::text 
  OR vwdocuments.person_occupation ~~* '%ophthal%'::text OR vwdocuments.person_occupation ~~* '%optom%'::text) AND vwdocuments.deleted = false
  ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;

ALTER TABLE research.vwmostrecenteyerelateddocuments   OWNER TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO staff;
COMMENT ON VIEW research.vwmostrecenteyerelateddocuments
  IS '
This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient
';

CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c AS 
 SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age_numeric, ( SELECT vwobservations.observation_date
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

ALTER TABLE research.diabetes_patients_latest_hba1c  OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;

CREATE OR REPLACE VIEW research.diabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.observation_date, vwgraphableobservations.loinc, 
 vwgraphableobservations.value_numeric, vwpatients.firstname, vwpatients.wholename, vwpatients.age_display, 
 vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, 
 vwpatients.occupation, vwpatients.postcode, vwpatients.surname, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.marital
   FROM contacts.vwpatients, documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.diabetes_patients_with_hba1c   OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;

CREATE OR REPLACE VIEW research.patientsnameshba1cover75 AS 
 SELECT DISTINCT vwpatients.wholename, vwpatients.age_display, vwpatients.sex
   FROM contacts.vwpatients, documents.patientshba1cover75
  WHERE patientshba1cover75.fk_patient = vwpatients.fk_patient;

ALTER TABLE research.patientsnameshba1cover75   OWNER TO easygp;
GRANT ALL ON TABLE research.patientsnameshba1cover75 TO easygp;
GRANT SELECT ON TABLE research.patientsnameshba1cover75 TO staff;

CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations, vwgraphableobservations.observation_date, vwgraphableobservations.loinc, 
 vwgraphableobservations.value_numeric, vwpatients.fk_patient, vwpatients.firstname, vwpatients.surname, vwpatients.wholename, 
 vwpatients.age_display, vwpatients.sex, vwpatients.title, vwpatients.occupation, vwpatients.fk_image, vwpatients.birthdate, 
 vwpatients.age_numeric, vwpatients.marital, vwpatients.fk_person, vwpatients.deceased, vwpatients.active_status, vwpatients.street1,
 vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode
   FROM contacts.vwpatients, documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;
COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c
  IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


 CREATE OR REPLACE VIEW research.vwdiabetics_with_ldlcholesterol AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, 
 vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, 
 vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, 
 vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '22748-8'::text;

ALTER TABLE research.vwdiabetics_with_ldlcholesterol  OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_ldlcholesterol TO easygp;
GRANT SELECT ON TABLE research.vwdiabetics_with_ldlcholesterol TO staff;

COMMENT ON VIEW research.vwdiabetics_with_ldlcholesterol
  IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwdiabetics_with_microalbumins AS 
 SELECT vwmicroalbuminuria.identifier, vwmicroalbuminuria.observation_date, vwmicroalbuminuria.value_numeric, vwmicroalbuminuria.value_numeric_qualifier, vwmicroalbuminuria.units, vwmicroalbuminuria.reference_range, vwmicroalbuminuria.abnormal, vwmicroalbuminuria.loinc, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status
   FROM research.vwmicroalbuminuria, research.vwdiabetes_patients_with_hba1c
  WHERE vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient
  ORDER BY vwdiabetes_patients_with_hba1c.fk_patient, vwmicroalbuminuria.observation_date;

ALTER TABLE research.vwdiabetics_with_microalbumins   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO staff;
COMMENT ON VIEW research.vwdiabetics_with_microalbumins
  IS 'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';


CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '33914-3'::text;

ALTER TABLE research.vwdiabeticsegfr   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabeticsegfr TO easygp;
GRANT SELECT ON TABLE research.vwdiabeticsegfr TO staff;
COMMENT ON VIEW research.vwdiabeticsegfr
  IS 'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwldh AS 
 SELECT vwpatients.wholename, vwpatients.fk_patient, vwobservations.value_numeric, vwobservations.abnormal
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.identifier ~~* '%LDH%'::text AND vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.abnormal IS NOT NULL
  ORDER BY vwobservations.value_numeric;

ALTER TABLE research.vwldh   OWNER TO easygp;
GRANT ALL ON TABLE research.vwldh TO easygp;
GRANT ALL ON TABLE research.vwldh TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 210);

