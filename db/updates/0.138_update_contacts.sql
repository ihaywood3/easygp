-- an extensive update to contacts
-- I found a logic error in the joining of tables
-- contacts.data_addressses.country_code should link to country of address (which it did)
-- however contacts.persons.country_code really is country_of_origin/birth, which had no link to common.lu_countries
-- hence have to rebuild much of the countacts views and all dependant views.... bumma...
-- this cacades to   view clin_history.vwteamcaremembers
-- drop cascades to view clin_history.vwsocialhistory
-- view clin_mentalhealth.vwteamcaremembers
-- clin_referrals.vwreferrals depends on view contacts.vwpersonsincludingpatients

COMMENT ON COLUMN contacts.data_persons.country_code is
'This code if not null refers to common.lu_countries and is the country of origin or the patient, normally country of birth';

drop view contacts.vwpersonsincludingpatients cascade ;

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
        date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
        marital.marital, sex.sex, title.title, countries.country, languages.language, countries1.country as country_birth,
        ethnicity.ethnicity, addresses.street1, addresses.street2, towns.town, towns.state, towns.postcode, addresses.fk_town, 
        addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, 
        addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, addresses.deleted AS address_deleted, 
        persons.fk_ethnicity, persons.fk_language, persons.language_problems, persons.memo, persons.fk_marital,  persons.country_code as country_birth_country_code,
        persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, images.pk AS fk_image, images.image, 
        images.md5sum, images.tag, images.fk_consult AS fk_consult_image
   FROM contacts.data_persons persons
   LEFT JOIN clerical.data_patients ON persons.pk = data_patients.pk
   LEFT JOIN contacts.links_persons_addresses ON persons.pk = links_persons_addresses.fk_person
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN blobs.images ON persons.fk_image = images.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   JOIN contacts.data_addresses addresses ON links_persons_addresses.fk_address = addresses.pk
   JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT OUTER JOIN common.lu_countries countries1 ON (addresses.country_code = countries1.country_code);
   
ALTER TABLE contacts.vwpersonsincludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';

CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
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
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee = 0
  ORDER BY 2;

ALTER TABLE clin_history.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO staff;

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
         SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
        UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
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

-- Now extensive drops to fix same in patients view
-- view clerical.vwtaskscomponents depends on view contacts.vwpatients .. done
-- view clerical.vwtaskscomponentsandnotes depends on view contacts.vwpatients ..done
-- view clin_consult.vwpatientconsults depends on view contacts.vwpatients ..done
-- view clin_recalls.vwrecallsdue depends on view contacts.vwpatients ..done
-- view documents.vwdocuments depends on view contacts.vwpatients ..done
-- view clin_requests.vwrequestsordered depends on view documents.vwdocuments ..done
-- view documents.vwhl7filesimported depends on view documents.vwdocuments ..done
-- view research.diabetes_patients_latest_hba1c depends on view contacts.vwpatients

Drop view contacts.vwpatients CASCADE;

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, addresses.pk AS fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
        age_display(age(persons.birthdate::timestamp with time zone)) AS age_display, 
        date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric, persons.language_problems, marital.marital, 
        sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, occupation.occupation, 
        addresses.street1, addresses.street2, towns.town, towns.state, towns.postcode, addresses.fk_town, 
        lu_address_types.type AS address_type, addresses.fk_lu_address_type, addresses.preferred_address,
         addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, 
         addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.memo, 
         persons.fk_marital, persons.fk_title, persons.fk_sex, persons.fk_occupation, persons.retired, persons.country_code as country_code_birth,
         countries1.country as country_birth,
         persons.deceased, persons.date_deceased, patients.fk_doctor, patients.fk_next_of_kin, 
         patients.fk_payer, patients.fk_family, patients.active_status, patients.medicare_number, 
         patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, 
         patients.veteran_card_type, patients.veteran_specific_condition, patients.concession_card_name, 
         patients.concession_type, patients.concession_number, patients.concession_expiry_date, patients.file_paper_number, patients.atsi, patients.file_racgp_format, patients.file_chart_status, patients.private_billing_concession, patients.private_insurance, patients.memo AS patient_memo, images.pk AS fk_image, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image
   FROM contacts.data_persons persons
   LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
   LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN blobs.images ON persons.fk_image = images.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN common.lu_countries countries1 ON persons.country_code = countries1.country_code::text
   LEFT JOIN common.lu_countries countries ON addresses.country_code = countries.country_code
   JOIN clerical.data_patients patients ON persons.pk = patients.fk_person
   LEFT JOIN common.lu_occupations occupation ON persons.fk_occupation = occupation.pk;

ALTER TABLE contacts.vwpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, 
tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, 
vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
 task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency,
task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted,
 vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title,
 consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, 
vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, 
vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
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
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task, 
tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, 
vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
vwstaffinclinics2.wholename AS staff_finalised_task_wholename, vwstaffinclinics3.title AS staff_must_finalise_task_title, 
vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, 
task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, 
vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, 
vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename,
vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note,
 task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
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

ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;

CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view, vwprogressnotes.fk_patient, vwprogressnotes.consult_date, 
vwprogressnotes.consult_type, vwprogressnotes.fk_staff, vwprogressnotes.title AS staff_title, vwprogressnotes.surname AS staff_surname, 
vwprogressnotes.firstname AS staff_firstname, vwprogressnotes.linked_table, vwprogressnotes.fk_type, vwpatients.wholename, 
vwpatients.firstname, vwpatients.surname, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, 
vwpatients.postcode, vwpatients.deceased, vwpatients.sex, vwpatients.title, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.age_display
   FROM clin_consult.vwprogressnotes, contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, 
recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls.additional_text, 
recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_progressnote, recalls.fk_pasthistory, vwpatients.fk_person, 
vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric,
vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, 
vwpatients.language_problems, vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, 
vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, 
lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, consult.consult_date
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested,
 documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, 
documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, 
documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, 
documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, 
documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient,
documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, 
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
unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, 
unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, 
unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street,
 unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, 
unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, 
unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
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

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, 
consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, 
forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, 
forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted,
 lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_request_provider AS fk_branch, 
forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, 
forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, 
past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname,
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

ALTER TABLE clin_requests.vwrequestsordered OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsordered TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT SELECT ON TABLE documents.vwhl7filesimported TO staff;

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

ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 138);

