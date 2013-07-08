-- added support for the australian electronic health record to patients and contacts tables
-- moved persons/employees 'fixed' numbers like prescriber number and hpii to separate table contacts.data_numbers_persons
-- dropped prescriber_number from contacts.data_numbers
-- upgraded appropriate queries
-- upgrade queries to handle the new contacts gui front end

alter table clerical.data_patients add column pcehr_consent char  not null default 'n' check (pcehr_consent in ('n', 'c','e','r','x'));
comment on column clerical.data_patients.pcehr_consent is 'consent status. n=not asked yet, c=consented, x=not eligible (tourist, asylum-seeker, etc), r=refused, e=error';

alter table clerical.data_patients add column ihi text unique check (ihi ~ '^[0-9]+$');
comment on column clerical.data_patients.ihi is 'Individual Health Identifier';

alter table clerical.data_patients add column ihi_updated timestamp;
comment on column clerical.data_patients.ihi_updated is 'last time IHI was refreshed from Medicare''s database';

alter table contacts.data_numbers add hpio text check (hpio ~ '^[0-9]+$');
comment on column contacts.data_numbers.hpio is 'Health Provider Identifier - Organisation';

alter table contacts.data_numbers add constraint one_of_branch_person check (not (fk_branch is null and fk_person is null));
alter table contacts.data_numbers add constraint employees_no_hpio check (not (hpio is not null and fk_person is not null and fk_branch is not null));


-- create the new contacts.data_numbers_persons table

CREATE TABLE contacts.data_numbers_persons
( pk serial primary key,
  fk_person integer not null,
  prescriber_number text default null,
  hpii text default null,
  CONSTRAINT data_numbers_fk_person_fkey FOREIGN KEY (fk_person)
      REFERENCES contacts.data_persons (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
      CONSTRAINT data_numbers_prescriber_number_check CHECK (prescriber_number ~ '^[0-9]+$'::text),
  CONSTRAINT data_numbers_hpii_check CHECK (hpii ~ '^[0-9]+$'::text)
 );

ALTER TABLE contacts.data_numbers_persons   OWNER TO easygp;

GRANT ALL ON TABLE contacts.data_numbers TO easygp;
GRANT ALL ON TABLE contacts.data_numbers TO staff;
COMMENT ON TABLE contacts.data_numbers_persons  IS 
'table for various types of numbers for persons only, these are ''fixed numbers''
 i.e they person carries them everywhere unlike say a provider number or australian business number
 which is fixed to a location';

COMMENT ON COLUMN contacts.data_numbers_persons.prescriber_number IS 'the Medicare Australia numeric prescriber number. ';
COMMENT ON COLUMN contacts.data_numbers_persons.hpii IS 'Health Provider Identifier - Individual - numeric';

-- update data from existing tables

insert into contacts.data_numbers_persons(fk_person, prescriber_number) 
(select fk_person, prescriber_number from admin.staff where  prescriber_number is not null);

-- in particular this should not be necessary as they should already be in there.

insert into contacts.data_numbers (fk_person, fk_branch, provider_number)
(select distinct fk_person, fk_branch, provider_number from admin.vwStaffInclinics 
where 
provider_number is not null
and 
(fk_person <> admin.vwStaffInclinics.fk_person AND fk_branch <> admin.vwStaffInclinics.fk_branch)
);

-- now add the new epcehr columns to the patients views pcehr_consent,ihi,ihi_updated

create or replace view contacts.vwpatients as 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, 
        patients.pk AS fk_patient, link_person_address.fk_address, patients.fk_person, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer_person, patients.fk_payer_branch, 
        patients.fk_family, patients.medicare_number, patients.medicare_ref_number, patients.medicare_expiry_date, 
        patients.veteran_number, patients.veteran_specific_condition, patients.concession_card_number, 
        patients.concession_card_expiry_date, patients.memo AS patient_memo, patients.fk_legacy, 
        patients.fk_lu_aboriginality, patients.fk_lu_veteran_card_type, patients.fk_lu_active_status, 
        patients.fk_lu_centrelink_card_type, patients.fk_lu_private_health_fund, patients.private_insurance, 
        lu_active_status.status AS active_status, lu_veteran_card_type.type AS veteran_card_type, 
        lu_centrelink_card_type.type AS concession_card_type, lu_private_health_funds.fund, 
        persons.firstname, persons.surname, persons.
salutation, persons.birthdate, age_display(age(persons.birthdate::timestamp with time zone)) AS age_display, 
date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric, persons.fk_ethnicity, 
persons.fk_language, persons.memo AS person_memo, persons.fk_marital, persons.fk_title, persons.fk_sex, 
persons.country_code AS country_birth_country_code, persons.fk_image, persons.retired, persons.fk_occupation, 
persons.deleted AS person_deleted, persons.deceased, persons.date_deceased, persons.language_problems, 
persons.surname_normalised, lu_aboriginality.aboriginality, country_birth.country AS country_birth, 
lu_ethnicity.ethnicity, lu_languages.language, lu_occupations.occupation, lu_marital.marital, title.title, 
lu_sex.sex, lu_sex.sex_text, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, 
link_person_address.pk AS fk_link_persons_address, addresses.street1, addresses.fk_town, 
addresses.preferred_address, addresses.postal_address, addresses.head_office, 
addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type, 
addresses.deleted AS address_deleted, addresses.street2, address_country.country, 
link_person_address.deleted AS link_address_deleted, lu_address_types.type AS address_type, lu_towns.postcode, 
lu_towns.town, lu_towns.state, patients.fk_lu_default_billing_level, lu_default_billing_level."level" AS billing_level, 
patients.nursing_home_resident, patients.ihi, patients.pcehr_consent, patients.ihi_updated
   FROM clerical.data_patients patients
   JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
   LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
   LEFT JOIN common.lu_aboriginality ON patients.fk_lu_aboriginality = lu_aboriginality.pk
   LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
   LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
   LEFT JOIN billing.lu_default_billing_level ON patients.fk_lu_default_billing_level = lu_default_billing_level.pk
   JOIN contacts.data_persons persons ON patients.fk_person = persons.pk
   LEFT JOIN common.lu_ethnicity ON persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON persons.fk_language = lu_languages.pk
   LEFT JOIN common.lu_occupations ON persons.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_marital ON persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN contacts.lu_sex ON persons.fk_sex = lu_sex.pk
   LEFT JOIN blobs.images images ON persons.fk_image = images.pk
   LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
   LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns ON addresses.fk_town = lu_towns.pk
   LEFT JOIN common.lu_countries country_birth ON persons.country_code = country_birth.country_code::text
   LEFT JOIN common.lu_countries address_country ON addresses.country_code = address_country.country_code;


-- add the new organisations columns to the end of the organisations view data_numbers.hpio

create or replace view contacts.vworganisations as 
SELECT DISTINCT branches.pk * organisations.pk::bigint AS pk_view, clinics.pk AS fk_clinic, 
organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, 
branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, 
branches.memo, branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town,
 addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, 
 addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, 
 towns.state, data_numbers.australian_business_number, data_communications.value AS fax, data_numbers.hpio as hpio
   FROM contacts.data_branches branches
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers ON branches.pk = data_numbers.fk_branch and data_numbers.fk_person is null
   LEFT JOIN contacts.links_branches_comms ON branches.pk = links_branches_comms.fk_branch
   LEFT JOIN contacts.data_communications ON links_branches_comms.fk_comm = data_communications.pk AND data_communications.fk_type = 2;

-- now drop the unwanted columns
alter table admin.staff drop column provider_number;
alter table admin.staff drop column prescriber_number;

CREATE OR REPLACE VIEW admin.vwstaff AS 
 SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, 
 staff.pk, staff.pk AS fk_staff, persons.firstname, persons.surname, 
 (persons.firstname || ' '::text) || persons.surname AS wholename, 
 persons.salutation, persons.fk_title, lu_title.title, staff.qualifications,
 persons.surname_normalised, 
 employees_numbers.provider_number, 
 data_numbers_persons.prescriber_number, 
 employees_numbers.australian_business_number,
 data_numbers_persons.hpii
   FROM admin.staff staff
   JOIN admin.lu_staff_roles roles ON staff.fk_role = roles.pk
   JOIN contacts.data_persons persons ON staff.fk_person = persons.pk
   JOIN contacts.lu_title ON persons.fk_title = lu_title.pk
   LEFT JOIN contacts. data_numbers_persons ON staff.fk_person = data_numbers_persons.fk_person
  LEFT JOIN contacts.data_numbers employees_numbers ON staff.fk_person = employees_numbers.fk_person;
ALTER TABLE admin.vwstaff   OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO staff;

-- add in the two fixed number identifiers provider_number and hiii
-- alias for contacts.data_numbers as employee to get the employee''s provider number

 CREATE OR REPLACE VIEW admin.vwstaffinclinics AS 
 SELECT DISTINCT ON (staff.pk, clinics.pk) (staff.pk || '-'::text) || data_addresses.pk AS pk_view, 
 (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, staff.fk_person, staff.fk_role, 
 staff.fk_status, staff.logon_name, 
 employee_numbers.provider_number, 
 data_numbers_persons.prescriber_number, 
 staff.fk_lu_staff_type, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, 
 link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, 
 data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, 
 data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, 
 data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, 
 data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, 
 data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, 
 data_persons.fk_sex, data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, 
 data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_title.title, 
 lu_marital.marital, lu_sex.sex, lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, 
 images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, images.deleted AS image_deleted, 
 lu_staff_roles.role, lu_staff_type.type AS staff_type, lu_employee_status.status, data_organisations.organisation, 
 data_organisations.deleted AS organisation_deleted, data_addresses.street1, data_addresses.street2, data_addresses.fk_town,
 lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, 
 data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, 
 data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, 
 link_staff_clinics1.pk AS fk_link_staff_clinic, staff.qualifications, data_persons.surname_normalised,
 data_numbers_persons.hpii
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   JOIN admin.lu_staff_type ON staff.fk_lu_staff_type = lu_staff_type.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = staff.fk_person 
   LEFT JOIN contacts.data_numbers employee_numbers ON employee_numbers.fk_branch = clinics.fk_branch AND employee_numbers.fk_person =staff.fk_person
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN common.lu_ethnicity ON data_persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   JOIN contacts.lu_employee_status ON staff.fk_status = lu_employee_status.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk;

ALTER TABLE admin.vwstaffinclinics   OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstaffinclinics TO easygp;
GRANT ALL ON TABLE admin.vwstaffinclinics TO staff;

CREATE OR REPLACE VIEW contacts.vwpersons AS 
SELECT data_persons.pk AS fk_person, 
CASE
WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
ELSE data_persons.pk || '-0'::text
END AS pk_view, 
((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, 
data_persons.fk_ethnicity, data_persons.fk_language, data_persons.language_problems, data_persons.memo, 
data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, 
data_persons.fk_occupation, data_persons.retired, data_persons.deceased, data_persons.date_deceased, 
data_persons.deleted, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, lu_occupations.occupation, 
lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, 
links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, 
data_persons.country_code, "Addresses".street1, "Addresses".street2, "Addresses".fk_town, 
"Addresses".fk_lu_address_type, lu_address_types.type AS address_type, "Addresses".preferred_address, 
"Addresses".postal_address, "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, 
images.image, data_persons.surname_normalised,
data_numbers.provider_number, 
data_numbers_persons.hpii, 
data_numbers.hpio,
data_numbers.pk as pk_data_numbers,
data_numbers_persons.pk as pk_data_numbers_persons
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
LEFT JOIN contacts.data_numbers ON data_persons.pk = data_numbers.fk_person AND data_numbers.fk_branch is null
LEFT JOIN contacts.data_numbers_persons ON data_persons.pk = data_numbers_persons.fk_person 
ORDER BY data_persons.pk, links_persons_addresses.fk_address; 

ALTER TABLE contacts.vwpersons  OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO staff;


CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, 
vwpersons.surname, vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, 
vwpersons.fk_language, vwpersons.language_problems, vwpersons.memo, vwpersons.fk_marital, 
vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, 
vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, 
vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.language, vwpersons.country, 
vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, 
vwpersons.state, vwpersons.country_code, vwpersons.street1, vwpersons.street2, vwpersons.fk_town, 
vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, 
vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, 
vwpersons.deleted, vwpersons.surname_normalised,
vwpersons.pk_data_numbers, 
vwPersons.provider_number, 
vwPersons.hpii, 
vwPersons.hpio,
vwPersons.pk_data_numbers_persons
FROM contacts.vwpersons
LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
LEFT JOIN blobs.images ON vwpersons.fk_image = images.pk
WHERE data_patients.pk IS NULL
ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;


-- add the new epcehr columns to the employee's view, drop casade because only 1 view and I'm sick of thinking.
drop view contacts.vwemployees cascade;

--  view contacts.vwpersonsemployeesbyoccupation
create or replace view contacts.vwemployees as
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname,
		data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, 
		data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status,
		data_employees.fk_branch, data_branches.branch, data_organisations.organisation, 
		data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS fk_address_organisation,
		data_branches.fk_category AS fk_category_organisation, lu_categories.category AS category_organisation, 
		data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, 
		data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, 
		data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, 
		data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street1, 
		data_addresses.street2, data_addresses.fk_town, 
		data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office,
		lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted, 
		data_persons.surname_normalised, 
		employee_numbers.provider_number,
		employee_numbers.pk as employees_pk_data_numbers,
		data_numbers_persons.prescriber_number, 
		data_numbers_persons.hpii,
		data_numbers_persons.pk as pk_data_numbers_persons,
		organisations_numbers.australian_business_number, 
		organisations_numbers.hpio, 
		organisations_numbers.pk as organisations_pk_data_numbers
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
   left join contacts.data_numbers organisations_numbers on organisations_numbers.fk_person is null and organisations_numbers.fk_branch = data_employees.fk_branch
  WHERE NOT data_employees.deleted;

create or replace view admin.vwclinics as
SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, 
data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, 
data_addresses.street1, data_addresses.street2, data_addresses.fk_town, data_addresses.preferred_address, 
data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, 
data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, 
data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, 
data_organisations.deleted AS organisation_deleted, lu_categories.category, 
data_numbers.hpio as hpio
   FROM admin.clinics
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
   LEFT join contacts.data_numbers on data_numbers.fk_branch = data_branches.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk;

-- View: contacts.vworganisationsemployees
-- found an historical bug in this view, originally a person was allocated a category as well as an oocupation, now no longer, only an occupation
-- but in doing the new contacts found I needed the category field in the employee's row of the view where the fk_category is the organisations
-- also with the advent of the pcehr stuff need the hpii and hpio fields.

DROP VIEW contacts.vworganisationsemployees cascade;
-- view clin_history.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- view clin_mentalhealth.vwteamcaremembers depends on view contacts.vworganisationsemployees
-- view clin_referrals.vwreferrals depends on view contacts.vworganisationsemployees
-- view contacts.vwpersonsandemployeesaddresses
-- view contactsvwpersonsemployeesbyoccupation (already dropped above by dropping vwEmployees
-- modified the contacts.vworganisationsemployees to include the hpi-i/o stuff

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT (((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk AS pk_view, 
         clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, 
         branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, 
         branches.fk_address, employees.memo, branches.fk_category, categories.category, 
         addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
         addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, 
         towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, 
                employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, 
                persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, 
                persons.retired, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, 
                persons.fk_sex, sex.sex, title.title, persons.surname_normalised, 
                employee_numbers.provider_number,
                employee_numbers.pk as employees_pk_data_numbers,
                data_numbers_persons.prescriber_number, 
                data_numbers_persons.hpii,
                data_numbers_persons.pk as pk_data_numbers_persons,
                organisations_numbers.australian_business_number, 
                organisations_numbers.hpio, 
                organisations_numbers.pk as organisations_pk_data_numbers
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
   LEFT JOIN contacts.data_numbers_persons ON  employees.fk_person = data_numbers_persons.fk_person
   LEFT JOIN contacts.data_numbers organisations_numbers ON branches.pk= organisations_numbers.fk_branch AND  organisations_numbers.fk_person is null
  WHERE employees.fk_person IS NOT NULL
UNION 
         SELECT ((organisations.pk || '-'::text) || branches.pk) || '-0'::text AS pk_view, clinics.pk AS fk_clinic, 
         organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch,
          branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, 
          categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, 
          addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, 
          addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, 
          (organisations.organisation || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation, 0 AS fk_status,
           NULL::text AS employee_status, false AS employee_deleted, NULL::text AS occupation, 0 AS fk_person, 
           NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::date AS birthdate, false AS deceased, 
           NULL::date AS date_deceased, false AS retired, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, 
           NULL::text AS sex, NULL::text AS title, NULL::text AS surname_normalised, 
           NULL::text AS provider_number, 
           0 as employees_pk_data_numbers,
           NULL::text AS prescriber_number, 
           NULL::text AS  hpii,
		   0 as pk_data_numbers_persons,
           organisations_numbers.australian_business_number, 
           organisations_numbers.hpio, 
           organisations_numbers.pk as organisations_pk_data_numbers
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers organisations_numbers ON branches.pk = organisations_numbers.fk_branch and fk_person is null;

COMMENT ON VIEW contacts.vworganisationsemployees IS
'A view of all organisations and their employees including deleted data_addresses
 In the union query the emloyee data includes the organisations hpio, abn stuff as in the gui 
 the organisation/employee are shown side by side and both can be edited at the same time ';

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


-- View: contacts.vwpersonsemployeesbyoccupation, need the organissations hpio for display

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
         vwpersonscomms.value AS fax
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
         vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, vwemployees.fk_branch, 
         vwemployees.fk_address, vwemployees.fk_employee,
         vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode, 
        (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, vwemployees.surname_normalised, 
         vwemployees.provider_number, 
         vwemployees.prescriber_number, 
         vwemployees.hpii,
         vwemployees.hpio,
         vwemployees.australian_business_number,
         vwbranchescomms.value AS fax
         FROM contacts.vwemployees
        LEFT JOIN contacts.vwbranchescomms ON vwbranchescomms.fk_branch = vwemployees.fk_branch AND vwbranchescomms.fk_type = 2
       WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false 
       AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL) ;


ALTER TABLE contacts.vwpersonsemployeesbyoccupation   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

-- finally drop the old data_numbers prescriber_number field which is now in the fixed number table this field no longer referenced anywhere
alter table contacts.data_numbers drop column prescriber_number;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 295)
