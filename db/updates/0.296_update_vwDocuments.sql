-- alter documents.vwSendingEntities to include provider_number field for employee's or persons
-- alter documents.vwDocuments to have this provider field

CREATE OR REPLACE VIEW documents.vwsendingentities AS ((
      -- the sole traders  
      SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, 
		    lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, 
		    sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, 
		    sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, 
		    lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, 
		    sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, 
		    sending_entities.deleted, NULL::text AS branch, NULL::text AS organisation, false AS organisation_deleted, 
		    NULL::integer AS fk_organisation, false AS branch_deleted, NULL::integer AS fk_address_organisation, 
		    NULL::integer AS fk_category_organisation, NULL::character varying AS organisation_category, 
		    NULL::text AS organisation_street1, NULL::text AS organisation_street2, NULL::integer AS fk_town_organisation, 
		    NULL::boolean AS organisation_postal_address, NULL::boolean AS organisation_head_office, 
		    NULL::character varying AS organisation_postcode, NULL::text AS organisation_town, NULL::character varying AS organisation_state, 
		    vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, 
		    vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, 
		    vwpersons.street1 AS person_street1, vwpersons.street2 AS person_street2, vwpersons.fk_town AS fk_town_person, 
		    vwpersons.town AS person_town, vwpersons.state AS person_state, 
		    data_numbers.provider_number
			FROM documents.sending_entities
			JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
			LEFT JOIN contacts.data_numbers ON sending_entities.fk_person = data_numbers.fk_person and data_numbers.fk_branch is null
			LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
			JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
			JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
			WHERE vwpersons.deleted = false AND sending_entities.fk_branch = 0 AND sending_entities.fk_employee = 0

        UNION 
         
        -- organisations (sending_entities.fk_employee = 0 AND sending_entities.fk_person = 0) 
		SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, 
			lu_request_type.type AS request_type, sending_entities.msh_sending_entity, 
			sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, 
			sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, 
			sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, 
			lu_message_standard.version AS message_version, lu_message_display_style.style, 
			sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
			sending_entities.abnormals_background_color, sending_entities.deleted, 
			vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, 
			vworganisations.fk_organisation, vworganisations.branch_deleted, 
			vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, 
			vworganisations.category AS organisation_category, vworganisations.street1 AS organisation_street1, 
			vworganisations.street2 AS organisation_street2, vworganisations.fk_town AS fk_town_organisation,
			vworganisations.postal_address AS organisation_postal_address, 
			vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, 
			vworganisations.town AS organisation_town, vworganisations.state AS organisation_state,
			NULL::text AS firstname, NULL::text AS surname, NULL::text AS title, NULL::text AS person_occupation, 
			NULL::text AS sex, NULL::integer AS fk_address_person, NULL::character varying AS person_postcode, 
			NULL::text AS person_street1, NULL::text AS person_street2, NULL::integer AS fk_town_person, 
			NULL::text AS person_town, NULL::character varying AS person_state, 
            Null::text as provider_number
			FROM documents.sending_entities
			JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
			LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
			JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
			JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
			WHERE vworganisations.branch_deleted = false AND sending_entities.fk_employee = 0 AND sending_entities.fk_person = 0)

        UNION 

		-- the employees
        SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, 
             lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, 
             sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, 
             sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, 
             lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, 
             sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, 
             sending_entities.deleted, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, 
             vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, 
             vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, 
             vworganisations.street1 AS organisation_street1, vworganisations.street2 AS organisation_street2, 
             vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, 
             vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, 
             vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, vwpersons.firstname, 
             vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, 
             vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, 
             vwpersons.street1 AS person_street1, vwpersons.street2 AS person_street2, vwpersons.fk_town AS fk_town_person, 
             vwpersons.town AS person_town, vwpersons.state AS person_state,  
             data_numbers.provider_number
			FROM documents.sending_entities
			JOIN contacts.vworganisations ON sending_entities.fk_branch = vworganisations.fk_branch
			LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
			JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
			JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
			JOIN contacts.data_employees ON sending_entities.fk_employee = data_employees.pk
			JOIN contacts.vwpersons ON data_employees.fk_person = vwpersons.fk_person
			LEFT JOIN contacts.data_numbers ON (sending_entities.fk_branch= data_numbers.fk_branch AND vwPersons.fk_person = data_numbers.fk_person)       
			WHERE vwpersons.deleted = false AND data_employees.deleted = false)

		UNION 

		-- sending entities received via hl7 but not yet allocated by the admin (sending_entities.fk_employee IS NULL AND sending_entities.fk_person IS NULL and sending_entities.fk_branch is null)
        SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, 
		     lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, 
		     sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, 
		     sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, 
		     lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, 
		     sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
		     sending_entities.abnormals_background_color, sending_entities.deleted, NULL::text AS branch, NULL::text AS organisation, 
		     NULL::boolean AS organisation_deleted, NULL::integer AS fk_organisation, NULL::boolean AS branch_deleted, 
		     NULL::integer AS fk_address_organisation, NULL::integer AS fk_category_organisation, 
		     NULL::character varying AS organisation_category, NULL::text AS organisation_street1, 
		     NULL::text AS organisation_street2, NULL::integer AS fk_town_organisation, false AS organisation_postal_address, 
		     false AS organisation_head_office, NULL::character varying AS organisation_postcode, 
		     NULL::text AS organisation_town, NULL::character varying AS organisation_state, 
		     NULL::text AS firstname, NULL::text AS surname, NULL::text AS title, 
		     NULL::text AS person_occupation, NULL::text AS sex, NULL::integer AS fk_address_person, 
		     NULL::character varying AS person_postcode, NULL::text AS person_street1, NULL::text AS person_street2, 
			NULL::integer AS fk_town_person, NULL::text AS person_town, NULL::character varying AS person_state, 
            Null::text as provider_number
			FROM documents.sending_entities
			LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
			JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
			JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
			WHERE sending_entities.fk_branch IS NULL AND sending_entities.fk_employee IS NULL AND sending_entities.fk_person IS NULL and fk_branch is null;

ALTER TABLE documents.vwsendingentities  OWNER TO easygp;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;




CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, 
 documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, 
 documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, 
 documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, 
 documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, 
 documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, 
 documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, 
 documents.incoming_referral, documents.fk_unmatched_patient, documents.fk_lu_display_as, 
 documents.fk_lu_request_type, lu_request_type.type AS request_type, 
 vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, 
 vwsendingentities.request_type AS sending_entity_request_type, 
 vwsendingentities.style, vwsendingentities.message_type, 
 vwsendingentities.message_version, vwsendingentities.msh_sending_entity, 
 vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, 
 vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, 
 vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, 
 vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, 
 vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, 
 vwsendingentities.person_occupation, vwsendingentities.organisation, 
 vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, 
 vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, 
 vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, 
 vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, 
 vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, 
 vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
 vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, 
 vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, 
 unmatched_patients.firstname AS unmatched_patient_firstname, 
 unmatched_patients.birthdate AS unmatched_patient_birthdate, 
 unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, 
 unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, 
 unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, 
 unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, 
 unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number, 
 vwpatients.fk_person,
 vwsendingentities.provider_number
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
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 296)

