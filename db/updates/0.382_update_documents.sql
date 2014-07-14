-- a series of queries to modify the documents table:
-- to allow documents to be protected from deletion in the gui
-- to allow different data types to be held in the old html field (we now put LaTex as well in there)
-- lookup table added for this purpose
-- view updated.
-- new document types for tca and gpmp to allow separation of display in the gui

insert into documents.lu_display_as (pk,display_as) values (5,'tca');
insert into documents.lu_display_as (pk,display_as) values (6,'gpmp');
insert into documents.lu_display_as (pk,display_as) values (7,'mhp');
comment on column documents.lu_display_as.display_as is 
'tca = australian general practice medicare activity team care arrangement
 gpmp = australian general practice medicare activity gp management plan
 mhp  = australian general practice mental health plan';
 
create table documents.lu_data_content_type
(pk serial primary key,
 data_content_type text not null);

 comment on table documents.lu_data_content_type is
 'A table to hold the type of data which may be found in the documents.documents.data field';

insert into documents.lu_data_content_type (data_content_type) values ('text/html');
insert into documents.lu_data_content_type (data_content_type) values ('text/latex');

alter table documents.documents add column fk_lu_data_content_type integer default null;

 -- add constraint for new field fk_lu_data_content_type
 alter table documents.documents 
 ADD CONSTRAINT documents_fk_lu_data_content_type_fkey FOREIGN KEY (fk_lu_data_content_type)
  REFERENCES documents.lu_data_content_type (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

comment on column documents.documents.fk_lu_data_content_type is 
 'key to documents.lu_data_content_type which contains the type of data in the data field e.g text/html, text/latex';
 
-- currently all data in the html table is html except on my system and anyone using POC INR testing
-- catch any html from pathology downloading
update documents.documents set fk_lu_data_content_type = 1 where html is not null and source_file is not null;    
-- any INR tests from POC testing (Horst will have heaps)                   
update documents.documents set fk_lu_data_content_type = 1 where html is not null and originator_reference = 'In Office INR Testing'; 
-- catch any latex (should be none on anyone's system except my test databases)
update documents.documents set fk_lu_data_content_type = 2 where html is not null and source_file is null and originator_reference <> 'In Office INR Testing';    

alter table documents.documents rename column html to data;

comment on column documents.documents.data is 
'where the document is not a reference to the filesystem, the document data
 could be html, latex etc, type is determined by the field fk_lu_data_content_type';
 
alter table documents.documents add column protected boolean default false;

comment on column documents.documents.protected is
'if True then this document may not be deleted in the GUI interface
 e.g documents placed there by EasyGP eg GP Mangement Plan needed for a medicare audit';


DROP VIEW documents.vwdocuments cascade;
-- cascades to clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- cascades to view documents.vwhl7filesimported depends on view documents.vwdocuments
-- cascades to view research.vwmostrecenteyerelateddocuments depends on view documents.vwdocuments

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, 
 documents.fk_sending_entity, documents.imported_time, documents.date_requested, 
 documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, 
 documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, 
 documents.internal_reference, documents.copies_to, documents.fk_staff_destination, 
 documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, 
 documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.data, documents.fk_lu_data_content_type,
 documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.incoming_referral, 
 documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, documents.protected,
 lu_data_content_type.data_content_type,
 lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, 
  vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, 
  vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity,
   vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, 
   vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, 
   vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, 
   vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.person_occupation,
    vwsendingentities.organisation, vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, 
    vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, 
    vwpatients.sex AS patient_sex, vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, 
    vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.town AS patient_town, 
    vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.fk_person, 
    vwstaff.wholename AS staff_destination_wholename, 
    vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, 
    unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate,
     unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, 
     unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, 
     unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, 
     unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, 
     unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number, 
    vwsendingentities.provider_number
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
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type,
  lu_request_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, 
  data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex,
  forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests,
   lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, 
   forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, 
   lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_request_provider AS fk_branch, 
   forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient,
    forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, 
    forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, 
    lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname,
     data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, 
     data_organisations.organisation, vwdocuments.data, vwDocuments.data_content_type, vwDocuments.fk_lu_data_content_type
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
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported   OWNER TO easygp;
GRANT SELECT ON TABLE documents.vwhl7filesimported TO staff;
CREATE OR REPLACE VIEW research.vwmostrecenteyerelateddocuments AS 
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, vwdocuments.fk_patient, vwdocuments.pk_document AS fk_document, vwdocuments.date_created, vwdocuments.deleted
   FROM documents.vwdocuments
  WHERE (vwdocuments.organisation_category::text ~~* '%ophthal%'::text 
  OR vwdocuments.organisation_category::text ~~* '%optom%'::text 
  OR vwdocuments.person_occupation ~~* '%ophthal%'::text 
  OR vwdocuments.person_occupation ~~* '%optom%'::text) AND vwdocuments.deleted = false
  ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;

ALTER TABLE research.vwmostrecenteyerelateddocuments   OWNER TO easygp;
GRANT SELECT ON TABLE research.vwmostrecenteyerelateddocuments TO staff;
COMMENT ON VIEW research.vwmostrecenteyerelateddocuments IS
 'This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient';

update db.lu_version set lu_minor=382;
