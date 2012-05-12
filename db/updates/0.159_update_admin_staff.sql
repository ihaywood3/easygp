drop view admin.vwstaffinclinics cascade;

-- drop cascades to:
-- view clerical.vwtaskscomponents depends on view admin.vwstaffinclinics
-- view clerical.vwtaskscomponentsandnotes depends on view admin.vwstaffinclinics
-- view clin_certificates.vwmedicalcertificates depends on view admin.vwstaffinclinics
-- view documents.vwinboxstaff depends on view admin.vwstaffinclinics

alter table admin.staff add column fk_lu_staff_type integer not null default 12 ;
comment on column admin.staff.fk_lu_staff_type is
 'type of staff e.g 12 - clerical. As I added this later it couldn''t be null due to join 
in the vwStaffInclinics so users will have to go back fix their staff table (ie me), 
I will change this back to not null after I do this';


CREATE OR REPLACE VIEW "admin".vwstaffinclinics AS 
 SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number, staff.prescriber_number, staff.fk_lu_staff_type,
staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, 
data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, 
data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, 
data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, 
data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, 
data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, 
data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, 
data_persons.deceased, data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, 
lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, images.image, images.md5sum, 
images.tag, images.fk_consult AS fk_consult_image, images.deleted AS image_deleted, lu_staff_roles.role, lu_staff_type.type as staff_type,
lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted, 
data_addresses.street1, data_addresses.street2, data_addresses.fk_town, lu_address_types.type AS address_type, 
data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, 
data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, 
lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   JOIN admin.lu_staff_type on  staff.fk_lu_staff_type = lu_staff_type.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN common.lu_ethnicity ON data_persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
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
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
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

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
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


ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;


CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult, medical_certificates.certificate_date, medical_certificates.reason, medical_certificates.fk_coding_system, medical_certificates.fk_code, medical_certificates.fk_lu_illness_temporality, medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date, medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, medical_certificates.print_notes, medical_certificates.fk_progressnote, medical_certificates.latex, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street1 AS staff_street1, vwstaffinclinics.street2 AS staff_street2, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code
   FROM clin_certificates.medical_certificates medical_certificates
   JOIN clin_consult.consult ON medical_certificates.fk_consult = consult.pk
   JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
   JOIN clin_certificates.lu_illness_temporality ON medical_certificates.fk_lu_illness_temporality = lu_illness_temporality.pk
   JOIN clin_certificates.lu_fitness ON medical_certificates.fk_lu_fitness = lu_fitness.pk
   LEFT JOIN coding.lu_systems ON medical_certificates.fk_coding_system = lu_systems.pk
   LEFT JOIN coding.generic_terms ON medical_certificates.fk_code = generic_terms.code
  ORDER BY consult.fk_patient, consult.consult_date;

ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO staff;
COMMENT ON VIEW clin_certificates.vwmedicalcertificates IS 'A view of patients medical certificate history';



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 159);

