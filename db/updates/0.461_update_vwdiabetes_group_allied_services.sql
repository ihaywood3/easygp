DROP VIEW contacts.vworganisationsemployees cascade;
-- view clin_mentalhealth.vwteamcaremembers depends on view contacts.vworganisationsemployees (done)
-- view contacts.vwpersonsandemployeesaddresses depends on view contacts.vworganisationsemployees (done)
-- view clin_referrals.vwreferrals depends on view contacts.vworganisationsemployees
-- view chronic_disease_management.vwdiabetesgroupalliedhealth depends on view contacts.vworganisationsemployees

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
 SELECT ((organisations.pk || '-'::text) || branches.pk) || '-0'::text AS pk_view,
    clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
        CASE
            WHEN lower(branches.branch) = 'head office'::text THEN ''::text
            ELSE branches.branch
        END AS branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo AS branch_memo,
    NULL::text AS employee_memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    null::integer AS fk_employee,
    (organisations.organisation || ' '::text) || branches.branch AS wholename,
    null::integer AS fk_occupation,
    0 AS fk_status,
    NULL::text AS employee_status,
    false AS employee_deleted,
    NULL::text AS occupation,
    null::integer AS fk_person,
    NULL::text AS firstname,
    'aaaa'::text AS surname,
    NULL::text AS salutation,
    NULL::date AS birthdate,
    false AS deceased,
    NULL::date AS date_deceased,
    false AS retired,
    null::integer AS fk_ethnicity,
    null::integer AS fk_language,
    null::integer AS fk_marital,
    null::integer AS fk_title,
    null::integer AS fk_sex,
    NULL::text AS sex,
    NULL::text AS title,
    NULL::text AS surname_normalised,
    NULL::text AS provider_number,
    null::integer AS employees_fk_data_numbers,
    NULL::text AS prescriber_number,
    NULL::text AS hpii,
    null::integer AS fk_data_numbers_persons,
    organisations_numbers.australian_business_number,
    organisations_numbers.hpio,
    organisations_numbers.pk AS organisations_fk_data_numbers,
    NULL::text AS person_qualifications
   FROM contacts.data_branches branches
     JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
     JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
     LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
     LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
     LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
     LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
     LEFT JOIN contacts.data_numbers organisations_numbers ON branches.pk = organisations_numbers.fk_branch AND organisations_numbers.fk_person IS NULL
UNION
 SELECT (((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk AS pk_view,
    clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
        CASE
            WHEN lower(branches.branch) = 'head office'::text THEN ''::text
            ELSE branches.branch
        END AS branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo AS branch_memo,
    employees.memo AS employee_memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    employees.pk AS fk_employee,
        CASE
            WHEN employees.pk IS NOT NULL THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
            ELSE 'Nothing'::text
        END AS wholename,
    employees.fk_occupation,
    employees.fk_status,
    employee_status.status AS employee_status,
    employees.deleted AS employee_deleted,
    occupations.occupation,
    persons.pk AS fk_person,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    persons.deceased,
    persons.date_deceased,
    persons.retired,
    persons.fk_ethnicity,
    persons.fk_language,
    persons.fk_marital,
    persons.fk_title,
    persons.fk_sex,
    sex.sex,
    title.title,
    persons.surname_normalised,
    employee_numbers.provider_number,
    employee_numbers.pk AS employees_fk_data_numbers,
    data_numbers_persons.prescriber_number,
    data_numbers_persons.hpii,
    data_numbers_persons.pk AS fk_data_numbers_persons,
    organisations_numbers.australian_business_number,
    organisations_numbers.hpio,
    organisations_numbers.pk AS organisations_fk_data_numbers,
    persons.qualifications AS person_qualifications
   FROM contacts.data_employees employees
     JOIN contacts.data_branches branches ON employees.fk_branch = branches.pk
     JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
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
     LEFT JOIN contacts.data_numbers employee_numbers ON employees.fk_person = employee_numbers.fk_person AND branches.pk = employee_numbers.fk_branch
     LEFT JOIN contacts.data_numbers_persons ON employees.fk_person = data_numbers_persons.fk_person
     LEFT JOIN contacts.data_numbers organisations_numbers ON branches.pk = organisations_numbers.fk_branch AND organisations_numbers.fk_person IS NULL
  WHERE employees.fk_person IS NOT NULL;

ALTER TABLE contacts.vworganisationsemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;
COMMENT ON VIEW contacts.vworganisationsemployees
  IS 'A view of all organisations and their employees including deleted data_addresses
 In the union query the emloyee data includes the organisations hpio, abn stuff as in the gui 
 the organisation/employee are shown side by side and both can be edited at the same time 
 an organisation has due to my stupid brain not being able to figure out a better way
 to filter head office to the top above employees in the union view
 been given a firstname of ''aaaa''';

CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.fk_branch,
    vworganisationsemployees.fk_person,
        CASE
            WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
            ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
        END AS wholename,
    ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
            ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
        END AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
  WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    NULL::integer AS fk_organisation,
    NULL::integer AS fk_branch,
    vwpersonsincludingpatients.fk_person,
    vwpersonsincludingpatients.wholename,
    (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL;

ALTER TABLE clin_mentalhealth.vwteamcaremembers   OWNER TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
 SELECT vworganisationsemployees.fk_address,
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
            ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
        END AS pk_view,
    vworganisationsemployees.fk_branch,
    vworganisationsemployees.branch,
    vworganisationsemployees.organisation,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.fk_person,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.title,
    vworganisationsemployees.occupation,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode
   FROM contacts.vworganisationsemployees
  WHERE vworganisationsemployees.fk_person is not null
UNION
 SELECT vwpersonsexcludingpatients.fk_address,
        CASE
            WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
            ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
        END AS pk_view,
    NULL::integer AS fk_branch,
    NULL::text AS branch,
    NULL::text AS organisation,
    NULL::integer AS fk_organisation,
    vwpersonsexcludingpatients.fk_person,
    vwpersonsexcludingpatients.firstname,
    vwpersonsexcludingpatients.surname,
    vwpersonsexcludingpatients.title,
    vwpersonsexcludingpatients.occupation,
    vwpersonsexcludingpatients.street1,
    vwpersonsexcludingpatients.street2,
    vwpersonsexcludingpatients.town,
    vwpersonsexcludingpatients.state,
    vwpersonsexcludingpatients.postcode
   FROM contacts.vwpersonsexcludingpatients
  WHERE vwpersonsexcludingpatients.fk_person is not null AND vwpersonsexcludingpatients.fk_address IS NOT NULL;

ALTER TABLE contacts.vwpersonsandemployeesaddresses   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO staff;


CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    vworganisationsemployees.wholename,
    vworganisationsemployees.occupation,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.salutation,
    vworganisationsemployees.sex,
    vworganisationsemployees.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    vworganisationsemployees.provider_number AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vwpersonsincludingpatients.street1,
    vwpersonsincludingpatients.street2,
    vwpersonsincludingpatients.town,
    vwpersonsincludingpatients.state,
    vwpersonsincludingpatients.postcode,
    NULL::text AS organisation,
    NULL::text AS branch,
    vwpersonsincludingpatients.wholename,
    NULL::text AS occupation,
    vwpersonsincludingpatients.firstname,
    vwpersonsincludingpatients.surname,
    vwpersonsincludingpatients.salutation,
    vwpersonsincludingpatients.sex,
    vwpersonsincludingpatients.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    NULL::text AS wholename,
    NULL::text AS occupation,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS salutation,
    NULL::text AS sex,
    NULL::text AS title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;



CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetesgroupalliedhealth AS 
SELECT 
    diabetes_group_allied_health_services.pk AS pk_diabetes_group_allied_health_services,
    diabetes_group_allied_health_services.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    diabetes_group_allied_health_services.confirm_diabetic,
    diabetes_group_allied_health_services.gpmp_new,
    diabetes_group_allied_health_services.gpmp_review,
    diabetes_group_allied_health_services.age_care_plan_review,
    diabetes_group_allied_health_services.latex_form,
    diabetes_group_allied_health_services.latex_history_items,
    diabetes_group_allied_health_services.fk_document_history_items,
    diabetes_group_allied_health_services.fk_document_form,
    diabetes_group_allied_health_services.health_issue_keys,
    diabetes_group_allied_health_services.fk_branch,
    diabetes_group_allied_health_services.fk_employee,
    diabetes_group_allied_health_services.fk_person,
    diabetes_group_allied_health_services.sessions_dietitian,
    diabetes_group_allied_health_services.sessions_exercise,
    diabetes_group_allied_health_services.sessions_education,
    diabetes_group_allied_health_services.include_allergies,
    diabetes_group_allied_health_services.include_medications,
    diabetes_group_allied_health_services.special_notes,
    diabetes_group_allied_health_services.fk_progressnote,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.title,
    vworganisationsemployees.occupation,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.postcode,
    ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname as wholename,
   ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
            ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
        END AS organisation_summary,
    diabetes_group_allied_health_services.deleted
   FROM chronic_disease_management.diabetes_group_allied_health_services
     JOIN clin_consult.consult ON diabetes_group_allied_health_services.fk_consult = consult.pk
     LEFT JOIN contacts.vworganisationsemployees ON diabetes_group_allied_health_services.fk_branch = vworganisationsemployees.fk_branch AND diabetes_group_allied_health_services.fk_employee = vworganisationsemployees.fk_employee
  WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch > 0 and diabetes_group_allied_health_services.fk_employee > 0

UNION
SELECT 
    diabetes_group_allied_health_services.pk AS pk_diabetes_group_allied_health_services,
    diabetes_group_allied_health_services.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    diabetes_group_allied_health_services.confirm_diabetic,
    diabetes_group_allied_health_services.gpmp_new,
    diabetes_group_allied_health_services.gpmp_review,
    diabetes_group_allied_health_services.age_care_plan_review,
    diabetes_group_allied_health_services.latex_form,
    diabetes_group_allied_health_services.latex_history_items,
    diabetes_group_allied_health_services.fk_document_history_items,
    diabetes_group_allied_health_services.fk_document_form,
    diabetes_group_allied_health_services.health_issue_keys,
    diabetes_group_allied_health_services.fk_branch,
    diabetes_group_allied_health_services.fk_employee,
    diabetes_group_allied_health_services.fk_person,
    diabetes_group_allied_health_services.sessions_dietitian,
    diabetes_group_allied_health_services.sessions_exercise,
    diabetes_group_allied_health_services.sessions_education,
    diabetes_group_allied_health_services.include_allergies,
    diabetes_group_allied_health_services.include_medications,
    diabetes_group_allied_health_services.special_notes,
    diabetes_group_allied_health_services.fk_progressnote,
    vworganisations.fk_organisation,
    Null:: text as firstname,
    Null:: text as surname,
    Null:: text as title,
    Null:: text as occupation,
    vworganisations.organisation,
    vworganisations.branch,
    vworganisations.street1,
    vworganisations.street2,
    vworganisations.town,
    vworganisations.postcode,
    null::text as  wholename,
    ((vwOrganisations.organisation || ' '::text) || (vwOrganisations.branch || ' '::text)) ||
    (((vwOrganisations.street1 || ' '::text) || vwOrganisations.town) || ' '::text) || vwOrganisations.postcode::text AS organisation_summary,
     diabetes_group_allied_health_services.deleted
   FROM chronic_disease_management.diabetes_group_allied_health_services
     JOIN clin_consult.consult ON diabetes_group_allied_health_services.fk_consult = consult.pk
     LEFT JOIN contacts.vwOrganisations ON diabetes_group_allied_health_services.fk_branch = vwOrganisations.fk_branch  
  WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch > 0 and diabetes_group_allied_health_services.fk_employee is null;
  
ALTER TABLE chronic_disease_management.vwdiabetesgroupalliedhealth   OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetesgroupalliedhealth TO staff;

update db.lu_version set lu_minor = 461;
