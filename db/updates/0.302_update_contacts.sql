CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, 
 data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, 
 data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, 
 data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation,
 data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, 
 lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, 
 data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, 
 data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, 
 data_persons.date_deceased, lu_sex.sex, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, 
 data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, lu_towns.postcode, 
 lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted, data_persons.surname_normalised, 
 employee_numbers.provider_number, employee_numbers.pk AS employees_pk_data_numbers, 
 data_numbers_persons.prescriber_number, data_numbers_persons.hpii, data_numbers_persons.pk AS pk_data_numbers_persons, 
 organisations_numbers.australian_business_number, organisations_numbers.hpio, 
 organisations_numbers.pk AS organisations_pk_data_numbers, images.image
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
   LEFT JOIN contacts.data_numbers employee_numbers ON employee_numbers.fk_person = data_employees.fk_person AND employee_numbers.fk_branch = data_employees.fk_branch
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = data_employees.fk_person
   LEFT JOIN contacts.data_numbers organisations_numbers ON organisations_numbers.fk_person IS NULL AND organisations_numbers.fk_branch = data_employees.fk_branch
   LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
  
  WHERE NOT data_employees.deleted;

ALTER TABLE contacts.vwemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO staff;

drop view contacts.vworganisationsemployees cascade;

-- view clin_history.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- view clin_mentalhealth.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- view clin_referrals.vwreferrals depends on view contacts.vworganisationsemployees
-- view contacts.vwpersonsandemployeesaddresses depends 


CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
-- get the branches
 SELECT ((organisations.pk || '-'::text) || branches.pk) || '-0'::text AS pk_view, 
 clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, 
 branches.pk AS fk_branch, 
 case when lower(branches.branch) = 'head office' then ''::text
      else branches.branch
 end
 as branch,
 branches.fk_organisation, branches.deleted AS branch_deleted, 
 branches.fk_address, branches.memo as branch_memo, Null::text as employee_memo, branches.fk_category, categories.category, 
 addresses.street1, addresses.street2, 
 addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code,
  addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 
  0 AS fk_employee, (organisations.organisation || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation, 
  0 AS fk_status, NULL::text AS employee_status, false AS employee_deleted, NULL::text AS occupation, 0 AS fk_person, 
  NULL::text AS firstname, 'aaaa'::text AS surname, NULL::text AS salutation, NULL::date AS birthdate, false AS deceased, 
  NULL::date AS date_deceased, false AS retired, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 
  0 AS fk_sex, NULL::text AS sex, NULL::text AS title, NULL::text AS surname_normalised, NULL::text AS provider_number, 
  0 AS employees_fk_data_numbers, NULL::text AS prescriber_number, NULL::text AS hpii, 0 AS fk_data_numbers_persons, 
  organisations_numbers.australian_business_number, organisations_numbers.hpio, organisations_numbers.pk AS organisations_fk_data_numbers
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers organisations_numbers ON branches.pk = organisations_numbers.fk_branch AND organisations_numbers.fk_person IS NULL

   union

   -- get the employees

     SELECT  (((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk AS pk_view, 
         clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, 
         branches.pk AS fk_branch, 
         case 
           when lower(branches.branch) = 'head office' then ''::text
           else branches.branch
	end
        as branch,
         branches.fk_organisation, branches.deleted AS branch_deleted, 
         branches.fk_address, branches.memo as branch_memo, employees.memo as employee_memo, branches.fk_category, categories.category, addresses.street1, 
         addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
         addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, 
         towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, 
                employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, 
                persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, 
                persons.date_deceased, persons.retired, persons.fk_ethnicity, persons.fk_language, 
                persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title, persons.surname_normalised, 
                employee_numbers.provider_number, employee_numbers.pk AS employees_fk_data_numbers, 
                data_numbers_persons.prescriber_number, data_numbers_persons.hpii, 
                data_numbers_persons.pk AS fk_data_numbers_persons, organisations_numbers.australian_business_number, 
                organisations_numbers.hpio, organisations_numbers.pk AS organisations_fk_data_numbers
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
  WHERE employees.fk_person IS NOT NULL 
  order by fk_organisation, fk_branch;
   
ALTER TABLE contacts.vworganisationsemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;


cOMMENT ON VIEW contacts.vworganisationsemployees IS
'A view of all organisations and their employees including deleted data_addresses
 In the union query the emloyee data includes the organisations hpio, abn stuff as in the gui 
 the organisation/employee are shown side by side and both can be edited at the same time 
 an organisation has due to my stupid brain not being able to figure out a better way
 to filter head office to the top above employees in the union view
 been given a firstname of ''aaaa''';

CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, 
         vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
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
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::integer AS fk_organisation, NULL::integer AS fk_branch, 
         vwpersonsincludingpatients.fk_person, NULL::integer AS fk_employee, vwpersonsincludingpatients.wholename, 
         (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee = 0;

ALTER TABLE clin_history.vwteamcaremembers   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT SELECT ON TABLE clin_history.vwteamcaremembers TO staff;


CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_plan, team_care_members.fk_employee, 
         vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, 
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
         SELECT team_care_members.pk, team_care_members.fk_plan, team_care_members.fk_employee, NULL::integer AS fk_organisation, NULL::integer AS fk_branch,
         vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, 
         (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL;

ALTER TABLE clin_mentalhealth.vwteamcaremembers   OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

-- View: clin_referrals.vwreferrals

-- DROP VIEW clin_referrals.vwreferrals;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type,
        lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, 
        referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, 
        referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, 
        vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, 
        vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch,
        vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, 
        vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date,
        consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, 
        vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, vworganisationsemployees.provider_number AS contact_provider_number
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
        UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type,
                 lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, 
                 referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch,
                 referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, 
                 lu_urgency.urgency, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town,
                 vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, 
                 vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname,
                 vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, 
                 consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, 
                 vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type,
         lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, 
         referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, 
         referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, 
         referrals.finalised, lu_urgency.urgency, vworganisationsemployees.street1, vworganisationsemployees.street2, 
         vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation,
         vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname,
         NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, 
         vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, 
         vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, 
                vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname,
                vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation, 
                vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, 
                vworganisationsemployees.state, vworganisationsemployees.postcode
           FROM contacts.vworganisationsemployees
          WHERE vworganisationsemployees.fk_person <> 0
UNION 
         SELECT vwpersonsexcludingpatients.fk_address, 
                CASE
                    WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
                    ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
                END AS pk_view, NULL::integer AS fk_branch, NULL::text AS branch, NULL::text AS organisation, NULL::integer AS fk_organisation,
                vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, 
                vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2,
                vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.fk_person <> 0 AND vwpersonsexcludingpatients.fk_address IS NOT NULL;


ALTER TABLE contacts.vwpersonsandemployeesaddresses   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT          -- persons who are not in an organisation
         (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
         vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.fk_title,
         vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, 
         vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.fk_occupation,
         vwpersonsexcludingpatients.sex,  vwpersonsexcludingpatients.fk_sex,vwpersonsexcludingpatients.retired,vwpersonsexcludingpatients.deceased,
         vwpersonsexcludingpatients.salutation, 
         NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, 
         vwpersonsexcludingpatients.fk_address, 
         0 AS fk_employee, 
         vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode,
         vwpersonsexcludingpatients.wholename, vwpersonsexcludingpatients.surname_normalised, 
         persons_numbers.provider_number,   -- sole traders can have these
         data_numbers_persons.prescriber_number, 
         data_numbers_persons.hpii, 
         persons_numbers.hpio, 
         persons_numbers.australian_business_number,
         vwpersonscomms.value AS fax,vwpersonsexcludingpatients.memo, vwpersonsexcludingpatients.fk_image, vwpersonsexcludingpatients.image
         FROM contacts.vwpersonsexcludingpatients
      -- get the employees provider number
      LEFT JOIN contacts.data_numbers persons_numbers ON persons_numbers.fk_person = vwpersonsexcludingpatients.fk_person AND persons_numbers.fk_branch IS NULL
      -- get the 'fixed' numbers unique to the employee wherever they roam
      LEFT JOIN contacts.data_numbers_persons  ON data_numbers_persons.fk_person = vwpersonsexcludingpatients.fk_person 
      LEFT JOIN contacts.vwpersonscomms ON vwpersonscomms.fk_person = vwpersonsexcludingpatients.fk_person AND vwpersonscomms.fk_type = 2
      WHERE  vwpersonsexcludingpatients.fk_address IS NOT NULL AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view,
         vwemployees.fk_person, vwemployees.title, vwemployees.fk_title,
         vwemployees.surname, vwemployees.firstname, 
         vwemployees.occupation, vwemployees.fk_occupation, 
         vwemployees.sex, vwemployees.fk_sex,vwemployees.retired, vwemployees.deceased,
         vwemployees.salutation, 
         vwemployees.organisation, 
         case when lower(vwemployees.branch) = 'head office' then ''::text
      else vwemployees.branch
 end
 as branch,
         vwemployees.fk_organisation, vwemployees.fk_branch, 
         vwemployees.fk_address, vwemployees.fk_employee,
         vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode, 
        (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, vwemployees.surname_normalised, 
         vwemployees.provider_number, 
         vwemployees.prescriber_number, 
         vwemployees.hpii,
         vwemployees.hpio,
         vwemployees.australian_business_number,
         vwbranchescomms.value AS fax,vwemployees.memo,vwemployees.fk_image, vwEmployees.image
         FROM contacts.vwemployees
        LEFT JOIN contacts.vwbranchescomms ON vwbranchescomms.fk_branch = vwemployees.fk_branch AND vwbranchescomms.fk_type = 2
       WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false 
       AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL) ;


ALTER TABLE contacts.vwpersonsemployeesbyoccupation   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 302)
