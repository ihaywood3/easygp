-- More document mods
-- Not having added a new hl7 sender for a long time it became evident the views no longer worked 
-- and hl7 from this vender didn't appear in the inbox - albeit grayed out to indicate it was inaccessable
-- with a message on how to rectify this. so................
-- needed the addition of a new union query where fk_branch, fk_person or fk_employee was null
-- otherwise, neither would the sending entity show up in vwSendingEntities, so admin couldn't access to allocate them a real company
-- also added a deleted field to sending_entities

Alter table documents.sending_entities add column deleted boolean default false;

Drop view documents.vwsendingentities cascade ;

--view documents.vwdocuments depends on view documents.vwsendingentities
--view clin_requests.vwrequestforms depends on view documents.vwdocuments
--view clin_requests.vwrequestsordered depends on view documents.vwdocuments
--view documents.vwhl7filesimported depends on view documents.vwdocuments

CREATE OR REPLACE VIEW documents.vwsendingentities AS 
        (        (         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type,
         sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, 
         sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, 
         lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style,
          sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
          sending_entities.abnormals_background_color, sending_entities.deleted, 
          NULL::unknown AS branch, NULL::unknown AS organisation, false AS organisation_deleted, NULL::unknown AS fk_organisation, false AS branch_deleted, NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, NULL::unknown AS organisation_street, NULL::unknown AS fk_town_organisation, NULL::unknown AS organisation_postal_address, NULL::unknown AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
                           FROM documents.sending_entities
                      JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
                 LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
            JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
       JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
      WHERE vwpersons.deleted = false AND sending_entities.fk_branch = 0 AND sending_entities.fk_employee = 0
                UNION 
                         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, 
                         sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, 
                         sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard,
                          lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, 
                          sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
                          sending_entities.abnormals_background_color,  sending_entities.deleted,
                          vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode, NULL::unknown AS person_street, NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state, NULL::unknown AS person_category
                           FROM documents.sending_entities
                      JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
                 LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
            JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
       JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
      WHERE vworganisations.branch_deleted = false AND sending_entities.fk_employee = 0 AND sending_entities.fk_person = 0)
        UNION 
                 SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type,
                  sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, 
                  sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, 
                  lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, 
                  sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color,
                  sending_entities.abnormals_background_color, sending_entities.deleted,
                   vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street AS organisation_street, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.category AS person_category
                   FROM documents.sending_entities
              JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
         LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
    JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
   JOIN contacts.data_employees ON sending_entities.fk_employee = data_employees.pk
   JOIN contacts.vwpersons ON data_employees.fk_person = vwpersons.fk_person
  WHERE vwpersons.deleted = false AND data_employees.deleted = false)
UNION 
         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type,
          sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style,
           sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, 
           lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, 
           lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, 
           sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color,sending_entities.deleted,
            NULL::unknown AS branch, NULL::unknown AS organisation, NULL::unknown AS organisation_deleted, NULL::unknown AS fk_organisation, NULL::unknown AS branch_deleted, NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, NULL::unknown AS organisation_street, NULL::unknown AS fk_town_organisation, false AS organisation_postal_address, false AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode, NULL::unknown AS person_street, NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state, NULL::unknown AS person_category
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
  documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, 
  documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference,
   documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded,
    documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html,
     documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient,
      documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type,
       vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type,
        vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style,
         vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, 
         vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style,
          vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch,
           vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, 
           vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color,
            vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit,
            vwsendingentities.organisation,
             vwsendingentities.organisation_category, vwsendingentities.person_category, 
             vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname,
              vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, 
              vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title,
               vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
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

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 39);
