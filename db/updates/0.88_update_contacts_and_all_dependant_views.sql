--------------------------------------------------------------------------------------------
-- Major changes to contacts and all dependant queries
-- Wish I'd paid more attention to ''a stitch in time saves nine''
-- dropped field contacts.data_persons.fk_category, ie person per-se no longer has a category
-- which I found to be useless complication in practice given they have an occupation
-- Also added street2 to the queries - long overdue which I'd been putting off
-- didn''t include this for historical reasons of stupidity (I was going to get around to it)
---------------------------------------------------------------------------------------------



alter table contacts.data_addresses rename column street to street1;
alter table contacts.data_addresses add column street2 text default null;

drop view contacts.vwPatients cascade;

-- this drop cascades to:
-- clerical.vwtaskscomponents depends on view contacts.vwpatients
-- clerical.vwtaskscomponentsandnotes depends on view contacts.vwpatients
-- clin_recalls.vwrecallsdue depends on view contacts.vwpatients
-- documents.vwdocuments depends on view contacts.vwpatients
-- clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- documents.vwhl7filesimported depends on view documents.vwdocuments
-- research.diabetes_patients_latest_hba1c depends on view contacts.vwpatients


Alter table contacts.data_persons drop column fk_category cascade;
-- Drop cascades to: (some of which have been diappeared by the last drop)
-- view contacts.vwpersons depends on table contacts.data_persons column fk_category
-- view clin_requests.vwrequestproviders depends on view contacts.vwpersons
-- view clin_requests.vwuserproviderdefaults depends on view clin_requests.vwrequestproviders
-- view documents.vwsendingentities depends on view contacts.vwpersons
-- view documents.vwdocuments depends on view documents.vwsendingentities
-- view clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- view documents.vwhl7filesimported depends on view documents.vwdocuments
-- view clin_workcover.vwworkcover depends on view contacts.vwpersons
-- view contacts.vwpersonsexcludingpatients depends on view contacts.vwpersons
-- view contacts.vwpersonsandemployeesaddresses depends on view contacts.vwpersonsexcludingpatients
-- view contacts.vwpersonsemployeesbyoccupation depends on view contacts.vwpersonsexcludingpatients

drop view clin_history.vwteamcaremembers;
-- no cascades, dropped to enable update of street1/2

drop view admin.vwstaffinclinics cascade ;
-- view clerical.vwtaskscomponents depends on view admin.vwstaffinclinics
---view clerical.vwtaskscomponentsandnotes depends on view admin.vwstaffinclinics
-- view clerical.vwtaskscomponentsnotes depends on view admin.vwstaffinclinics
--view clin_certificates.vwmedicalcertificates depends on view admin.vwstaffinclinics
--view documents.vwinboxstaff depends on view admin.vwstaffinclinics

--drop view admin.vwStaff cascade;
-- view cascades to, some of which may already have been dropped:
-- view admin.vwstafftoolbarbuttons depends on view admin.vwstaff
-- view clin_mentalhealth.vwmentalhealthplans depends on view admin.vwstaff
-- view clin_prescribing.vwmedications depends on view admin.vwstaff
-- view clin_prescribing.vwprescribeditems depends on view admin.vwstaff
-- view clin_procedures.vwskinprocedures depends on view admin.vwstaff
-- view clin_recalls.vwrecallsdue depends on view admin.vwstaff
-- view clin_requests.vwrequestforms depends on view admin.vwstaff
-- view documents.vwdocuments depends on view admin.vwstaff
-- view clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- view documents.vwhl7filesimported depends on view documents.vwdocuments
-- view clin_workcover.vwworkcover depends on view admin.vwstaff
-- view clin_referrals.vwreferrals depends on view admin.vwstaff
-- view clin_vaccination.vwvaccinesgiven depends on view admin.vwstaff
-- view chronic_disease_management.vwdiabetescycleofcare depends on view admin.vwstaff

drop view contacts.vwOrganisations;  -- no cascades;
drop view contacts.vwpersonsincludingpatients cascade; 
--view clin_history.vwteamcaremembers depends on view contacts.vwpersonsincludingpatients
--view clin_mentalhealth.vwteamcaremembers depends on view contacts.vwpersonsincludingpatients
--view clin_referrals.vwreferrals depends on view contacts.vwpersonsincludingpatients

drop  view contacts.vworganisationsemployees; 
--view clin_history.vwteamcaremembers depends on view contacts.vworganisationsemployees
--view clin_mentalhealth.vwteamcaremembers depends on view contacts.vworganisationsemployees
--view clin_referrals.vwreferrals depends on view contacts.vworganisationsemployees
--view contacts.vwpersonsandemployeesaddresses depends on view contacts.vworganisationsemployees
drop view contacts.vwemployees; 
--view contacts.vwpersonsemployeesbyoccupation depends on view contacts.vwemployees

drop view contacts.vwpersonsaddresses ;--no cascades
--drop view clin_mentalhealth.vwteamcaremembers; --no cascasdes
drop view admin.vwclinics cascade ;
-- Drop cascades to admin.vwclinicrooms
alter table contacts.data_employees drop column fk_category;
--Now, start re-building all the views
--Schema Admin:

CREATE OR REPLACE VIEW "admin".vwclinics AS 
 SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_address, 
data_branches.fk_organisation, data_organisations.organisation, data_addresses.street1, data_addresses.street2, 
data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, 
data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, 
data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, data_organisations.deleted AS organisation_deleted, lu_categories.category
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
 SELECT clinic_rooms.pk, clinic_rooms.room_name, clinic_rooms.script_printer, clinic_rooms.default_printer,
 clinic_rooms.fk_clinic, vwclinics.organisation, vwclinics.branch, vwclinics.street1, vwclinics.street2, vwclinics.town
   FROM admin.clinic_rooms, admin.vwclinics
  WHERE clinic_rooms.fk_clinic = vwclinics.fk_clinic
  ORDER BY clinic_rooms.fk_clinic, clinic_rooms.room_name;

ALTER TABLE "admin".vwclinicrooms OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwclinicrooms TO easygp;
GRANT ALL ON TABLE "admin".vwclinicrooms TO staff;




CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, addresses.pk AS fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate,
         date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
         persons.language_problems, marital.marital, sex.sex, title.title, countries.country, 
         languages.language, ethnicity.ethnicity, occupation.occupation, addresses.street1, addresses.street2, towns.town, towns.state, 
         towns.postcode, addresses.fk_town, lu_address_types.type AS address_type, addresses.fk_lu_address_type, addresses.preferred_address, 
         addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.deleted AS address_deleted, 
         persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital, persons.fk_title,
          persons.fk_sex, persons.fk_occupation, persons.retired, persons.deceased, persons.date_deceased, patients.fk_doctor, 
          patients.fk_next_of_kin, patients.fk_payer, patients.fk_family, patients.active_status, patients.medicare_number, 
          patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_card_type,
           patients.veteran_specific_condition, patients.concession_card_name, patients.concession_type, patients.concession_number, 
           patients.concession_expiry_date, patients.file_paper_number, patients.atsi, patients.file_racgp_format, 
           patients.file_chart_status, patients.private_billing_concession, patients.private_insurance, patients.memo AS patient_memo, 
           all_images.pk AS fk_image, all_images.image
   FROM contacts.data_persons persons
   LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
   LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN all_images ON persons.fk_image = all_images.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   JOIN clerical.data_patients patients ON persons.pk = patients.fk_person
   LEFT JOIN common.lu_occupations occupation ON persons.fk_occupation = occupation.pk
  ORDER BY patients.fk_person;

ALTER TABLE contacts.vwpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;

COMMENT ON VIEW contacts.vwpatients IS 'unique key for this view is pk_view. If the patient has an address then this is in the format 
patient.pk-addresspk (e.g 1-1) otherwise patient.pk-0 (e.g 1-0)';

CREATE OR REPLACE VIEW "admin".vwstaffinclinics AS 
 SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number, staff.prescriber_number, staff.logon_date_from, 
staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, 
data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, 
data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, 
data_employees.fk_occupation,  data_employees.memo AS employee_memo, 
data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, data_persons.salutation, 
data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, 
data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, 
data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, 
data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex,  
lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, all_images.image, 
all_images.deleted AS image_deleted, lu_staff_roles.role, lu_employee_status.status, 
data_organisations.organisation, data_organisations.deleted AS organisation_deleted, 
data_addresses.street1, data_addresses.street2, data_addresses.fk_town, 
lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, 
data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, 
data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, 
lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
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

CREATE OR REPLACE VIEW documents.vwinboxstaff AS 
         SELECT vwstaffinclinics.pk_view, vwstaffinclinics.title, vwstaffinclinics.fk_staff, vwstaffinclinics.wholename, vwstaffinclinics.surname, NULL::unknown AS fk_unmatched_staff
           FROM admin.vwstaffinclinics
UNION 
         SELECT (unmatched_staff.pk || '-'::text) || 'unmatched'::text AS pk_view, unmatched_staff.title, 
unmatched_staff.fk_real_staff AS fk_staff, (unmatched_staff.firstname || ' '::text) || (unmatched_staff.surname || ' [Unkown]'::text) AS wholename, 
unmatched_staff.surname, unmatched_staff.pk AS fk_unmatched_staff
           FROM documents.unmatched_staff
          WHERE unmatched_staff.fk_real_staff IS NULL
  ORDER BY 5;

ALTER TABLE documents.vwinboxstaff OWNER TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO staff;
COMMENT ON VIEW documents.vwinboxstaff IS 'All staff with an inbox. If the staff member is unknown, they will still
 appear, once matched to a real staff member they are not pulled from
 the unmatched table ie fk_real_staff <> null then';



CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, 
tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, 
vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role, task_components.pk AS fk_component, 
task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, 
task_components.allocated_staff, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, 
task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, 
consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person,
 vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, 
vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task, 
tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, 
vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role, task_components.pk AS fk_component, 
task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, 
task_components.allocated_staff, task_components.fk_urgency, task_components.date_completed AS date_component_completed, 
task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, 
consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, 
vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, 
lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, 
task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename,
 vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;



CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult, 
medical_certificates.date AS certificate_date, medical_certificates.reason, medical_certificates.fk_coding_system, medical_certificates.fk_code, 
medical_certificates.fk_lu_illness_temporality, medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date, 
medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, 
vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, 
vwstaffinclinics.street1 AS staff_street1, vwstaffinclinics.street2 as staff_street2,
vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, 
vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code
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



CREATE OR REPLACE VIEW clin_recalls.vwrecalls AS 
 SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, lu_contact_type.type AS contact_by, 
lu_appointment_length.length, lu_title.title, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, 
recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls."interval", lu_units.abbrev_text, 
recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, recalls.fk_progressnote, 
data_persons.firstname, data_persons.surname, data_persons.fk_title, lu_contact_type.pk AS fk_contact_by, 
lu_recall_intervals."interval" AS default_interval, lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit
   FROM clin_recalls.recalls
   JOIN clin_recalls.lu_recall_intervals ON recalls.fk_reason = lu_recall_intervals.fk_reason
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   LEFT JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
  ORDER BY consult.fk_patient, recalls.due;

ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;


CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c AS 
 SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age, 
( SELECT vwobservations.observation_date
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

ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO staff;





CREATE OR REPLACE VIEW contacts.vwpersons AS 
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view, ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, 
data_persons.fk_language, data_persons.language_problems, 
data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, 
data_persons.fk_occupation, data_persons.retired, data_persons.deceased, 
data_persons.date_deceased, data_persons.deleted, lu_sex.sex, lu_sex.sex_text, 
lu_title.title, lu_marital.marital, lu_occupations.occupation, lu_languages.language, 
lu_countries.country, links_persons_addresses.pk AS fk_link_address, links_persons_addresses.fk_address, 
lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, 
"Addresses".street1, "Addresses".street2, "Addresses".fk_town, "Addresses".fk_lu_address_type, 
lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, 
"Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image
   FROM contacts.data_persons
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN common.lu_occupations ON data_persons.fk_occupation = lu_occupations.pk
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


CREATE OR REPLACE VIEW contacts.vwpersonsaddresses AS 
 SELECT links_persons_addresses.fk_address AS pk_view, links_persons_addresses.fk_person, 
links_persons_addresses.fk_address, data_addresses.street1,data_addresses.street2, data_addresses.fk_town, 
lu_address_types.type AS address_type, data_addresses.preferred_address, 
data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, 
data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state
   FROM contacts.links_persons_addresses
   JOIN contacts.data_addresses ON links_persons_addresses.fk_address = data_addresses.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
  WHERE data_addresses.head_office = false AND data_addresses.deleted = false
  ORDER BY links_persons_addresses.fk_person;

ALTER TABLE contacts.vwpersonsaddresses OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsaddresses TO staff;

CREATE OR REPLACE VIEW contacts.vworganisations AS 
 SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, 
organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, 
branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, 
addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, 
addresses.postal_address, addresses.head_office, addresses.country_code, 
addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state
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

CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
         SELECT request_providers.pk AS pk_request_provider, lu_request_type.type, request_providers.fk_headoffice_branch, request_providers.fk_default_branch, 
request_providers.fk_employee, request_providers.fk_person, request_providers.fk_lu_request_type, 
request_providers.deleted AS request_provider_deleted, data_organisations.organisation, lu_categories.category, 
data_branches.branch AS headoffice_branch, data_branches.fk_organisation, data_branches.deleted AS headoffice_branch_deleted, 
data_addresses.street1 AS headoffice_street1, data_addresses.street2 AS headoffice_street2, data_addresses.deleted AS headoffice_address_deleted, lu_towns.postcode AS headoffice_postcode, 
lu_towns.town AS headoffice_town, lu_towns.state AS headoffice_state, 
NULL::unknown AS wholename, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS salutation, 0 AS fk_title, 
NULL::unknown AS title, 0 AS fk_sex, NULL::unknown AS sex, 0 AS fk_occupation, NULL::unknown AS occupation, 
data_branches1.branch AS default_branch, data_addresses1.street1 AS default_branch_street1, data_addresses1.street2 AS default_branch_street2, 
lu_towns1.postcode AS default_branch_postcode, lu_towns1.town AS default_branch_town, lu_towns1.state AS default_branch_state
           FROM clin_requests.request_providers
      JOIN contacts.data_branches ON request_providers.fk_headoffice_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.data_branches data_branches1 ON request_providers.fk_default_branch = data_branches1.pk
   LEFT JOIN contacts.data_addresses data_addresses1 ON data_branches1.fk_address = data_addresses1.pk
   LEFT JOIN contacts.lu_towns lu_towns1 ON data_addresses1.fk_town = lu_towns1.pk
  WHERE request_providers.fk_employee = 0 AND request_providers.fk_person = 0
UNION 
         SELECT request_providers.pk AS pk_request_provider, lu_request_type.type, request_providers.fk_headoffice_branch, 
request_providers.fk_default_branch, request_providers.fk_employee, request_providers.fk_person, request_providers.fk_lu_request_type, 
request_providers.deleted AS request_provider_deleted, NULL::unknown AS organisation, NULL::unknown AS category, 
'HEAD OFFICE' AS headoffice_branch, 0 AS fk_organisation, NULL::unknown AS headoffice_branch_deleted, 
vwpersons.street1 AS headoffice_street1, vwpersons.street2 AS headoffice_street2,
NULL::unknown AS headoffice_address_deleted, vwpersons.postcode AS headoffice_postcode, 
vwpersons.town AS headoffice_town, vwpersons.state AS headoffice_state, vwpersons.wholename,
 vwpersons.firstname, vwpersons.surname, vwpersons.salutation, vwpersons.fk_title, vwpersons.title, 
vwpersons.fk_sex, vwpersons.sex, vwpersons.fk_occupation, vwpersons.occupation, 
NULL::unknown AS default_branch, vwpersons.street1 AS default_branch_street1, vwpersons.street2 AS default_branch_street2, 
vwpersons.postcode AS default_branch_postcode, 
vwpersons.town AS default_branch_town, vwpersons.state AS default_branch_state
           FROM clin_requests.request_providers
      JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.vwpersons ON request_providers.fk_person = vwpersons.fk_person
  WHERE request_providers.fk_person <> 0
  ORDER BY 7;

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;
COMMENT ON VIEW clin_requests.vwrequestproviders IS ' View of providers who we may send requests to
 Note: it is possible in contacts for user not to put in an addresss, hence the outer joins here
 ';

CREATE OR REPLACE VIEW clin_requests.vwrequestforms AS 
 SELECT COALESCE((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms_requests.pk AS fk_forms_requests, 
forms.fk_consult, forms.date, lu_requests.item, forms.requests_summary, forms.notes_summary, forms.fk_request_provider, 
forms.fk_lu_request_type, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, 
forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, 
forms.pk_image, forms.fk_progressnote, forms.fk_pasthistory, vwstaff.firstname AS staff_firstname, 
vwstaff.surname AS staff_surname, vwstaff.wholename AS staff_wholename, vwstaff.title AS staff_title, 
lu_request_type.type, vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_default_branch, 
vwrequestproviders.fk_employee, vwrequestproviders.fk_person, vwrequestproviders.request_provider_deleted, 
vwrequestproviders.organisation, vwrequestproviders.category, vwrequestproviders.headoffice_branch, 
vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, 
vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, 
vwrequestproviders.headoffice_address_deleted, 
vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, 
vwrequestproviders.headoffice_state, vwrequestproviders.wholename, vwrequestproviders.firstname, 
vwrequestproviders.surname, vwrequestproviders.salutation, vwrequestproviders.fk_title, vwrequestproviders.title, 
vwrequestproviders.fk_sex, vwrequestproviders.sex, vwrequestproviders.fk_occupation, 
vwrequestproviders.occupation, vwrequestproviders.default_branch, 
vwrequestproviders.default_branch_street1, vwrequestproviders.default_branch_street2, 
vwrequestproviders.default_branch_postcode, vwrequestproviders.default_branch_town, vwrequestproviders.default_branch_state, 
forms_requests.fk_form, forms_requests.fk_lu_request, forms_requests.deleted AS forms_request_deleted,
forms_requests.request_result_html, consult.consult_date, consult.fk_patient, 
consult.fk_staff, past_history.description AS past_history_description
   FROM clin_requests.forms
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_requests.lu_request_type ON forms.fk_lu_request_type = lu_request_type.pk
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.vwrequestproviders ON forms.fk_request_provider = vwrequestproviders.pk_request_provider
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;



CREATE OR REPLACE VIEW clin_requests.vwuserproviderdefaults AS 
 SELECT vwrequestproviders.type, vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_employee, vwrequestproviders.fk_person, 
vwrequestproviders.fk_lu_request_type, vwrequestproviders.request_provider_deleted, vwrequestproviders.organisation, vwrequestproviders.category,
 vwrequestproviders.headoffice_branch, vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, 
vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, 
vwrequestproviders.headoffice_address_deleted, vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, vwrequestproviders.headoffice_state, 
vwrequestproviders.wholename, vwrequestproviders.firstname, vwrequestproviders.surname, vwrequestproviders.salutation, vwrequestproviders.fk_title, vwrequestproviders.title, 
vwrequestproviders.fk_sex, vwrequestproviders.sex, vwrequestproviders.fk_occupation, vwrequestproviders.occupation, 
user_provider_defaults.fk_staff, user_provider_defaults.fk_request_provider, user_provider_defaults.pk AS pk_default,
 user_provider_defaults.send_electronically, user_provider_defaults.print_paper, user_provider_defaults.deleted, 
user_provider_defaults.fk_default_branch, data_branches.branch AS default_branch, 
data_addresses.street1 AS default_branch_street1, data_addresses.street2 AS default_branch_street2, 
lu_towns.postcode AS default_branch_postcode, lu_towns.town AS default_branch_town, lu_towns.state AS default_branch_state, lu_request_type.type AS request_type
   FROM clin_requests.user_provider_defaults
   JOIN clin_requests.vwrequestproviders ON user_provider_defaults.fk_request_provider = vwrequestproviders.pk_request_provider
   LEFT JOIN contacts.data_branches ON user_provider_defaults.fk_default_branch = data_branches.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN clin_requests.lu_request_type ON user_provider_defaults.fk_lu_request_type = lu_request_type.pk
  ORDER BY user_provider_defaults.fk_staff;

ALTER TABLE clin_requests.vwuserproviderdefaults OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO staff;




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



CREATE OR REPLACE VIEW documents.vwsendingentities AS 
        (        (         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, 
sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, 
sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, 
lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, 
sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
sending_entities.abnormals_background_color, sending_entities.deleted, 
NULL::unknown AS branch, NULL::unknown AS organisation, false AS organisation_deleted, NULL::unknown AS fk_organisation, false AS branch_deleted, 
NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, 
NULL::unknown AS organisation_street1, 
NULL::unknown AS organisation_street2, 
NULL::unknown AS fk_town_organisation, NULL::unknown AS organisation_postal_address, 
NULL::unknown AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, 
NULL::unknown AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, 
vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, 
vwpersons.postcode AS person_postcode, 
vwpersons.street1 AS person_street1,
vwpersons.street2 AS person_street2,
 vwpersons.fk_town AS fk_town_person, 
vwpersons.town AS person_town, vwpersons.state AS person_state
                           FROM documents.sending_entities
                      JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
                 LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
            JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
       JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
      WHERE vwpersons.deleted = false AND sending_entities.fk_branch = 0 AND sending_entities.fk_employee = 0
                UNION 
                         SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, 
				lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, 
				sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, 
				sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, 
			        lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
				sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, 
				vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, 
				vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, 
				vworganisations.category AS organisation_category, 
				vworganisations.street1 AS organisation_street1, 
				vworganisations.street2 AS organisation_street2, 
				vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, 
				vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, 
vworganisations.town AS organisation_town, vworganisations.state AS organisation_state,
 NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, 
 NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode,
 NULL::unknown AS person_street1, 
 NULL::unknown AS person_street2, 
NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state
 
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
sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, 
vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, 
vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, 
vworganisations.street1 AS organisation_street1, 
vworganisations.street2 AS organisation_street2, 
vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, 
vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, 
vworganisations.state AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, 
vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, 
vwpersons.street1 AS person_street1,
vwpersons.street2 AS person_street2,
 vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state
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
lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, 
sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, 
sending_entities.abnormals_background_color, sending_entities.deleted, NULL::unknown AS branch, NULL::unknown AS organisation, 
NULL::unknown AS organisation_deleted, NULL::unknown AS fk_organisation, NULL::unknown AS branch_deleted, 
NULL::unknown AS fk_address_organisation, NULL::unknown AS fk_category_organisation, NULL::unknown AS organisation_category, 
NULL::unknown AS organisation_street1, 
NULL::unknown AS organisation_street2, 
NULL::unknown AS fk_town_organisation, false AS organisation_postal_address, 
false AS organisation_head_office, NULL::unknown AS organisation_postcode, NULL::unknown AS organisation_town, NULL::unknown AS organisation_state, 
NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS title, NULL::unknown AS person_occupation, 
NULL::unknown AS sex, NULL::unknown AS fk_address_person, NULL::unknown AS person_postcode,
NULL::unknown AS person_street1, 
NULL::unknown AS person_street2, 
NULL::unknown AS fk_town_person, NULL::unknown AS person_town, NULL::unknown AS person_state
           FROM documents.sending_entities
      LEFT JOIN clin_requests.lu_request_type ON sending_entities.fk_lu_request_type = lu_request_type.pk
   JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
  WHERE sending_entities.fk_branch IS NULL AND sending_entities.fk_employee IS NULL AND sending_entities.fk_person IS NULL;

ALTER TABLE documents.vwsendingentities OWNER TO easygp;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, 
documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, 
documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, 
documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, 
documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, 
documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, 
documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, 
lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, 
vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, 
vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, 
vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, 
vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, 
vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, 
vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, 
vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, 
vwsendingentities.organisation, vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, 
vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, 
vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, 
vwpatients.title AS patient_title, 
vwpatients.street1 AS patient_street1,
vwpatients.street2 AS patient_street2,
vwpatients.town AS patient_town, 
vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, 
vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, 
unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, 
unmatched_patients.street AS unmatched_patient_street, 
unmatched_patients.town AS unmatched_patient_town,
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

ALTER TABLE documents.vwdocuments OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, 
forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, 
data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, 
forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, forms_requests.request_result_html, 
forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, 
lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, 
forms.fk_request_provider AS fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, 
forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, 
forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, 
lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, 
data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, 
data_organisations.organisation, vwdocuments.html
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

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, 
consult.consult_date AS visit_date, consult.fk_patient, claims.claim_number, claims.fk_occupation, 
claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury,
 claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, consult.fk_staff, 
consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, 
vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, vwstaff.provider_number, 
lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, 
vworganisations.street1 AS branch_street1, 
vworganisations.street2 AS branch_street2,
vworganisations.town AS branch_town, vworganisations.branch_deleted, 
vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, 
vwpersons.title AS soletrader_title, vwpersons.town AS soletrader_town,
vwpersons.street1 AS soletrader_street1, 
vwpersons.street2 AS soletrader_street2, 
vwpersons.postcode AS soletrader_postcode, vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, 
visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.certificate_date, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, lu_caused_by_employment.caused_by_employment
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
GRANT SELECT ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age,
 marital.marital, sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, 
addresses.street1,addresses.street2,
towns.town, towns.state, towns.postcode, addresses.fk_town, addresses.preferred_address, addresses.postal_address,
 addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, addresses.deleted AS address_deleted, 
persons.fk_ethnicity, persons.fk_language, persons.language_problems, persons.memo, persons.fk_marital, persons.fk_title, persons.deceased, 
persons.date_deceased, persons.fk_sex, all_images.pk AS fk_image, all_images.image
   FROM contacts.data_persons persons
   LEFT JOIN clerical.data_patients ON persons.pk = data_patients.pk
   LEFT JOIN contacts.links_persons_addresses ON persons.pk = links_persons_addresses.fk_person
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN all_images ON persons.fk_image = all_images.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   JOIN contacts.data_addresses addresses ON links_persons_addresses.fk_address = addresses.pk
   JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk;

ALTER TABLE contacts.vwpersonsincludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';



CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, 
vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, 
vwpersons.language_problems, vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, 
vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.retired, 
vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, 
vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.language, 
vwpersons.country, vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, 
vwpersons.state, vwpersons.country_code, 
vwpersons.street1,
vwpersons.street2,
vwpersons.fk_town, 
vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, 
vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, vwpersons.deleted
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN all_images ON vwpersons.fk_image = all_images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, 
organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, 
branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, NULL::unknown AS category,
addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, 
addresses.postal_address, addresses.head_office, addresses.country_code,
addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation,              
employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, 
occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, 
persons.birthdate, persons.deceased, persons.date_deceased, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title
           FROM contacts.data_employees employees
      JOIN contacts.data_branches branches ON employees.fk_branch = branches.pk
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
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, 
organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation,
 branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, 
categories.category, 
addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, 
towns.postcode, towns.town, towns.state, 0 AS fk_employee, 
(organisations.organisation || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation,  0 AS fk_status,
 NULL::unknown AS employee_status, false AS employee_deleted, NULL::unknown AS occupation, 0 AS fk_person, NULL::unknown AS firstname, 
NULL::unknown AS surname, NULL::unknown AS salutation, NULL::unknown AS birthdate, false AS deceased, NULL::unknown AS date_deceased, 
0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::unknown AS sex, NULL::unknown AS title
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



CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation,
vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, 
vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town,
vworganisationsemployees.state, vworganisationsemployees.postcode
           FROM contacts.vworganisationsemployees
          WHERE vworganisationsemployees.fk_person <> 0
UNION 
         SELECT vwpersonsexcludingpatients.fk_address, 
                CASE
                    WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
                    ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
                END AS pk_view, NULL::unknown AS fk_branch, NULL::unknown AS branch, NULL::unknown AS organisation, NULL::unknown AS fk_organisation,
 vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, 
vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, 
vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.fk_person <> 0 AND vwpersonsexcludingpatients.fk_address IS NOT NULL
  ORDER BY 6, 12;

ALTER TABLE contacts.vwpersonsandemployeesaddresses OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO staff;
COMMENT ON VIEW contacts.vwpersonsandemployeesaddresses IS 'A view of all addresses for a person whether they have a private address or their address as an employee of an organisation';


CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, 
data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation,  
data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status,
 data_employees.fk_branch, data_branches.branch, data_organisations.organisation, 
data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS fk_address_organisation, 
data_branches.fk_category AS fk_category_organisation, lu_categories.category AS category_organisation, 
data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo,
 data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, 
data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, 
data_persons.date_deceased, lu_sex.sex, data_addresses.street1, data_addresses.street2, data_addresses.fk_town,
 data_addresses.preferred_address, data_addresses.postal_address, 
data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted
   FROM contacts.data_employees
   JOIN contacts.data_branches ON data_employees.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
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



CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, 
vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.salutation, NULL::text AS organisation, 
NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, 
vwpersonsexcludingpatients.street1,vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, 
vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.retired IS FALSE 
AND vwpersonsexcludingpatients.deceased IS FALSE 
AND vwpersonsexcludingpatients.fk_address IS NOT NULL 
AND vwpersonsexcludingpatients.address_deleted IS FALSE 
AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, vwemployees.fk_person, 
vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, vwemployees.sex, 
vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, 
vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street1, vwemployees.street2,vwemployees.town, 
vwemployees.state, vwemployees.postcode, (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename
           FROM contacts.vwemployees
          WHERE vwemployees.employee_deleted = false 
AND vwemployees.person_deleted = false 
AND vwemployees.deceased = false 
AND vwemployees.retired = false 
AND vwemployees.organisation_address_deleted = false 
AND vwemployees.fk_status <> 2
  ORDER BY 6, 4, 5;

ALTER TABLE contacts.vwpersonsemployeesbyoccupation OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;
COMMENT ON VIEW contacts.vwpersonsemployeesbyoccupation IS 'A view of all people in the database and their occupations, listed by their addresses, whether in organisations or sole traders
 Persons who are retired, deceased or left the organisation (if an employee) are excluded.';




CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, 
vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, 
vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee,
 vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary,

 team_care_members.responsibility
           FROM clin_history.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_history.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO staff;


-- dropped just to fix the street - only done partially at the moment
-- need to see how this affects the mental health plan printout before putting in street2

CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, 
vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;



CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, 
lu_type.type, referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.fk_pasthistory, referrals.fk_progressnote, 
referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, 
vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, 
vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, 
vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, 
vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex,
 vworganisationsemployees.title, consult.consult_date, consult.fk_patient, 
consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, 
vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
        UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, 
referrals.fk_type, lu_type.type, referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, 
referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, 
referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2,
vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, 
vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, 
vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, 
consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, 
vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, 
referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.fk_pasthistory, referrals.fk_progressnote, 
referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, 
vworganisationsemployees.street1, vworganisationsemployees.street2, 
vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, 
vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, 
NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, 
vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL
  ORDER BY 32, 2;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;
COMMENT ON VIEW clin_referrals.vwreferrals IS 'A view of referral letters written, includes also for example recall letters sent to patient, letters to non-medical providers e.g insurance companies
 FIXME: need to fix contacts.vwPersonsIncludingPatients to include occupation 
 Not that the the view uses contacts.vwpersonsincludingpatient.
 The view also **DOES NOT** exclude retired or left organisation employees, as once written the letter is written.
';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 88);

