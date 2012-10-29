drop view documents.vwdocuments cascade;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, 
 documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, 
 documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, 
 documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, 
 documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user,
 documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.incoming_referral,
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
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view,
 vwdocuments.fk_patient, 
 vwdocuments.pk_document AS fk_document, vwdocuments.date_created, 
vwdocuments.deleted
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
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 240);

