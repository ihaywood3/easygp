-- added patienets deceased field to enable excluding decesased patients scanned records in inbox

-- DROP VIEW documents.vwdocuments;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document,
    documents.source_file,
    documents.fk_sending_entity,
    documents.imported_time,
    documents.date_requested,
    documents.date_created,
    documents.fk_patient,
    documents.fk_staff_filed_document,
    documents.originator,
    documents.originator_reference,
    documents.copy_to,
    documents.provider_of_service_reference,
    documents.internal_reference,
    documents.copies_to,
    documents.fk_staff_destination,
    documents.comment_on_document,
    documents.patient_access,
    documents.concluded,
    documents.deleted,
    documents.fk_lu_urgency,
    documents.tag,
    documents.tag_user,
    documents.md5sum,
    documents.data,
    documents.fk_lu_data_content_type,
    documents.fk_unmatched_staff,
    documents.fk_referral,
    documents.fk_request,
    documents.incoming_referral,
    documents.fk_unmatched_patient,
    documents.fk_lu_display_as,
    documents.fk_lu_request_type,
    documents.protected,
    lu_data_content_type.data_content_type,
    lu_request_type.type AS request_type,
    vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type,
    vwsendingentities.request_type AS sending_entity_request_type,
    vwsendingentities.style,
    vwsendingentities.message_type,
    vwsendingentities.message_version,
    vwsendingentities.msh_sending_entity,
    vwsendingentities.msh_transmitting_entity,
    vwsendingentities.fk_lu_message_display_style,
    vwsendingentities.fk_branch AS fk_sender_branch,
    vwsendingentities.fk_employee AS fk_employee_branch,
    vwsendingentities.fk_person AS fk_sender_person,
    vwsendingentities.fk_lu_message_standard,
    vwsendingentities.exclude_ft_report,
    vwsendingentities.abnormals_foreground_color,
    vwsendingentities.abnormals_background_color,
    vwsendingentities.exclude_pit,
    vwsendingentities.person_occupation,
    vwsendingentities.organisation,
    vwsendingentities.organisation_category,
    vwpatients.fk_person AS patient_fk_person,
    vwpatients.firstname AS patient_firstname,
    vwpatients.surname AS patient_surname,
    vwpatients.birthdate AS patient_birthdate,
    vwpatients.sex AS patient_sex,
    vwpatients.age_numeric AS patient_age,
    vwpatients.title AS patient_title,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.fk_person,
    vwstaff.wholename AS staff_destination_wholename,
    vwstaff.title AS staff_destination_title,
    unmatched_patients.surname AS unmatched_patient_surname,
    unmatched_patients.firstname AS unmatched_patient_firstname,
    unmatched_patients.birthdate AS unmatched_patient_birthdate,
    unmatched_patients.sex AS unmatched_patient_sex,
    unmatched_patients.title AS unmatched_patient_title,
    unmatched_patients.street AS unmatched_patient_street,
    unmatched_patients.town AS unmatched_patient_town,
    unmatched_patients.postcode AS unmatched_patient_postcode,
    unmatched_patients.state AS unmatched_patient_state,
    unmatched_staff.surname AS unmatched_staff_surname,
    unmatched_staff.firstname AS unmatched_staff_firstname,
    unmatched_staff.title AS unmatched_staff_title,
    unmatched_staff.provider_number AS unmatched_staff_provider_number,
    vwsendingentities.provider_number,
    vwpatients.deceased as patient_deceased,
    vwPatients.fk_lu_active_status as patient_fk_lu_active_status
   FROM documents.documents
     JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
     LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
     LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
     LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
     LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk
     LEFT JOIN documents.lu_data_content_type ON documents.fk_lu_data_content_type = lu_data_content_type.pk
  ORDER BY documents.fk_patient, documents.date_created;

ALTER TABLE documents.vwdocuments   OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

update db.lu_version set lu_minor=516;
