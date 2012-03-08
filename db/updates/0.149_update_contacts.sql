-- Mmm........ well we all make mistakes
-- I forgot to add the retired field in the view, so a major cascade is needed.

drop view contacts.vworganisationsemployees CASCADE;

-- clin_history.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- clin_mentalhealth.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- clin_referrals.vwreferrals depends on view contacts.vworganisationsemployees
-- contacts.vwpersonsandemployeesaddresses depends on view contacts.vworganisationsemployees


CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, 
branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, 
NULL::unknown AS category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, 
addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, 
occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
persons.deceased, persons.date_deceased, persons.retired,
persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title
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
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, 
branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category,
 categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, 
addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, 
(organisations.organisation || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation, 0 AS fk_status, NULL::unknown AS employee_status, false AS employee_deleted, 
NULL::unknown AS occupation, 0 AS fk_person, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS salutation, NULL::unknown AS birthdate, 
false AS deceased, NULL::unknown AS date_deceased, false as retired,
0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::unknown AS sex, NULL::unknown AS title
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
  ORDER BY 1, 3, 4, 29, 28;

COMMENT ON VIEW contacts.vworganisationsemployees is
'a heirachical view of organisations and their employees e.g:
   John Hunter Hospital  HEAD OFFICE
   John Hunter Hopsital  Surgical Dept
   John Hunter Hospital  Dr The Best Surgeon
   John Hunter Hospital  Urology Dept
   John Hunter Hospital  Dr Ima Urologist etc
   This view **includes** persons who are dead, retired or left the organisation';

ALTER TABLE contacts.vworganisationsemployees OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;

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
vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee, vwpersonsincludingpatients.wholename, 
(((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
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
         SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, 
vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, 
(((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, 
referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, 
referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, 
vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, 
vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, 
vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, 
vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, 
vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, 
consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, 
vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
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


CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, 
vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, 
vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street1, vworganisationsemployees.street2, 
vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode
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


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 149);
