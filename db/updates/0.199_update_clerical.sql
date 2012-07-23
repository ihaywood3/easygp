-- As per Horsts suggestion add a column to make seaching on odd surnames easier eg McBeth

alter table contacts.data_persons add column surname_normalised text default null;

CREATE OR REPLACE VIEW contacts.vwpersons AS 
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view, ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
        data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, 
        data_persons.fk_ethnicity, data_persons.fk_language, data_persons.language_problems, data_persons.memo, 
        data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, 
        data_persons.fk_occupation, data_persons.retired, data_persons.deceased, data_persons.date_deceased, 
        data_persons.deleted, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, 
        lu_occupations.occupation, lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, 
        links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, 
        "Addresses".street1, "Addresses".street2, "Addresses".fk_town, "Addresses".fk_lu_address_type, 
        lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, 
        "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image,
        data_persons.surname_normalised
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

ALTER TABLE contacts.vwpersons   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO easygp;
GRANT ALL ON TABLE contacts.vwpersons TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, 
        persons.birthdate, date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
        marital.marital, sex.sex, title.title, countries.country, languages.language, countries1.country AS country_birth, 
        ethnicity.ethnicity, addresses.street1, addresses.street2, towns.town, towns.state, towns.postcode, 
        addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, 
        addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, 
        addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, 
        persons.language_problems, persons.memo, persons.fk_marital, persons.country_code AS country_birth_country_code, 
        persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, 
        images.pk AS fk_image, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, persons.surname_normalised
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
   LEFT JOIN common.lu_countries countries1 ON addresses.country_code = countries1.country_code;

ALTER TABLE contacts.vwpersonsincludingpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients
  IS 'temporary view until I fix it, a view of all persons including those who are patients';

CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, 
 vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.language_problems, 
 vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, 
 vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, vwpersons.title, 
 vwpersons.marital, vwpersons.occupation, vwpersons.language, vwpersons.country, vwpersons.fk_link_address, 
 vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street1, 
 vwpersons.street2, vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, 
 vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, vwpersons.deleted,
 vwPersons.surname_normalised
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN blobs.images ON vwpersons.fk_image = images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;

CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, 
 data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, 
 data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, 
 data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, 
 data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, 
 lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, 
 data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, 
 data_persons.country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, 
 data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street1, data_addresses.street2, 
 data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, 
 data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted,
 data_persons.surname_normalised
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

ALTER TABLE contacts.vwemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO easygp;
GRANT ALL ON TABLE contacts.vwemployees TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
         vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, 
         vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, 
         vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.salutation, NULL::text AS organisation, 
         NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, vwpersonsexcludingpatients.fk_address, 
         0 AS fk_employee, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, 
         vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, 
         vwpersonsexcludingpatients.wholename,vwpersonsexcludingpatients.surname_normalised
FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.retired IS FALSE AND vwpersonsexcludingpatients.deceased IS FALSE AND vwpersonsexcludingpatients.fk_address IS NOT NULL AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, 
         vwemployees.fk_person, vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, 
         vwemployees.sex, vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, 
         vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street1, vwemployees.street2, 
         vwemployees.town, vwemployees.state, vwemployees.postcode, 
         (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename,
         vwemployees.surname_normalised
           FROM contacts.vwemployees
          WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false AND vwemployees.deceased = false AND vwemployees.retired = false AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL) AND vwemployees.fk_status <> 2
  ORDER BY 6, 4, 5;

ALTER TABLE contacts.vwpersonsemployeesbyoccupation   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;
COMMENT ON VIEW contacts.vwpersonsemployeesbyoccupation
  IS 'A view of all people in the database and their occupations, listed by their addresses, whether in organisations or sole traders
 Persons who are retired, deceased or left the organisation (if an employee) are excluded.';

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, 
         organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, 
         branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, NULL::character varying AS category, 
         addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
         addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, 
         towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, 
                employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, 
                persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, 
                persons.date_deceased, persons.retired, persons.fk_ethnicity, persons.fk_language, 
                persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title,persons.surname_normalised
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
         categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, 
         addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, 
         addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 
         0 AS fk_employee, (organisations.organisation || ' '::text) || branches.branch AS wholename, 
         0 AS fk_occupation, 0 AS fk_status, NULL::text AS employee_status, false AS employee_deleted, 
         NULL::text AS occupation, 0 AS fk_person, NULL::text AS firstname, NULL::text AS surname, 
         NULL::text AS salutation, NULL::date AS birthdate, false AS deceased, NULL::date AS date_deceased, 
         false AS retired, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, 
         NULL::text AS sex, NULL::text AS title, Null::text as surname_normalised
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
  ORDER BY 1, 3, 4, 29, 28;

ALTER TABLE contacts.vworganisationsemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;
COMMENT ON VIEW contacts.vworganisationsemployees
  IS 'a heirachical view of organisations and their employees e.g:
   John Hunter Hospital  HEAD OFFICE
   John Hunter Hopsital  Surgical Dept
   John Hunter Hospital  Dr The Best Surgeon
   John Hunter Hospital  Urology Dept
   John Hunter Hospital  Dr Ima Urologist etc
   This view **includes** persons who are dead, retired or left the organisation';

CREATE OR REPLACE VIEW admin.vwstaff AS 
 SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, staff.pk, staff.pk AS fk_staff, staff.provider_number, 
 staff.prescriber_number, persons.firstname, persons.surname, 
 (persons.firstname || ' '::text) || persons.surname AS wholename, 
 persons.salutation, persons.fk_title, lu_title.title, staff.qualifications, persons.surname_normalised
   FROM admin.staff staff
   JOIN admin.lu_staff_roles roles ON staff.fk_role = roles.pk
   JOIN contacts.data_persons persons ON staff.fk_person = persons.pk
   JOIN contacts.lu_title ON persons.fk_title = lu_title.pk;

ALTER TABLE admin.vwstaff   OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO staff;

CREATE OR REPLACE VIEW admin.vwstaffinclinics AS 
 SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
 staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number, staff.prescriber_number, 
 staff.fk_lu_staff_type, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, 
 link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, 
 data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, 
 data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, 
 data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, 
 data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, 
 data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, 
 data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, 
 data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, 
 data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_occupations.occupation, 
 lu_ethnicity.ethnicity, lu_languages.language, images.image, images.md5sum, images.tag, 
 images.fk_consult AS fk_consult_image, images.deleted AS image_deleted, lu_staff_roles.role, 
 lu_staff_type.type AS staff_type, lu_employee_status.status, data_organisations.organisation, 
 data_organisations.deleted AS organisation_deleted, data_addresses.street1, data_addresses.street2, 
 data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, 
 data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, 
 data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, 
 lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic, staff.qualifications,
 data_persons.surname_normalised
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   JOIN admin.lu_staff_type ON staff.fk_lu_staff_type = lu_staff_type.pk
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
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
  ORDER BY data_branches.branch, data_persons.surname;

ALTER TABLE admin.vwstaffinclinics  OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstaffinclinics TO easygp;
GRANT ALL ON TABLE admin.vwstaffinclinics TO staff;



-- some stuff for billing.
Create table clerical.lu_active_status
(pk serial primary key,
 status text)
;
Insert into clerical.lu_active_status(status) values ('active');
Insert into clerical.lu_active_status(status) values ('inactive');

comment on table clerical.lu_active_status is
'determines if the patient is an active patient or not 1- active 2 - inactive';

alter table clerical.lu_active_status owner to easygp;
grant all on table clerical.lu_active_status to easygp;
grant all on table clerical.lu_active_status to staff;

create table clerical.lu_veteran_card_type
(pk serial primary key,
type text not null);

alter table clerical.lu_veteran_card_type owner to easygp;
grant all on table clerical.lu_veteran_card_type to easygp;
grant all on table clerical.lu_veteran_card_type to staff;

insert into clerical.lu_veteran_card_type(type) values ('Gold - full entitlement');
insert into clerical.lu_veteran_card_type(type) values ('White - specific entitlement');
insert into clerical.lu_veteran_card_type(type) values ('Lilac - war-widow');

Comment on table clerical.lu_veteran_card_type is 'The different types of veteran entitlement cards';

create table clerical.lu_centrelink_card_type
(pk serial primary key,
type text not null);

alter table clerical.lu_centrelink_card_type owner to easygp;
grant all on table clerical.lu_centrelink_card_type to easygp;
grant all on table clerical.lu_centrelink_card_type to staff;

insert into clerical.lu_centrelink_card_type(type) values ('Commonwealth Seniors Health Card');
insert into clerical.lu_centrelink_card_type(type) values ('Health Care Card');
insert into clerical.lu_centrelink_card_type(type) values ('Pensioner Concession Card');

Comment on table clerical.lu_centrelink_card_type is 'The different types of australian government centrelink entitlement cards';


Create table clerical.lu_private_health_funds 
(pk serial primary key,
fund text not null,
name_abbrev text not null,
availability text not null,
states_available text not null
);

alter table clerical.lu_private_health_funds owner to easygp;
grant all on table clerical.lu_private_health_funds to easygp;
grant all on table clerical.lu_private_health_funds to staff;

Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('No Fund', 'No Fund','Open', 'ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('ACA Health Benefits Fund','ACA','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('ahm Health Insurance','AHM','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Australian Unity Health Limited','AUF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Bupa Australia Pty Ltd','BUP','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('CBHS Health Fund Limited','CBH','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('CDH Benefits Fund','CDH','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Central West Health Cover','CWH','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('CUA Health Limited','CPS','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Defence Health Limited','AHB','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('GMF Health','GMF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('GMHBA Limited','GMH','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Grand United Corporate Health','FAI','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('HBF Health Limited','HBF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('HCF','HCF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Health Care Insurance Limited','HCI','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Health Insurance Fund of Australia Limited','HIF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Health Partners','SPS','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('health.com.au','HEA','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Latrobe Health Services','LHS','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Medibank Private Limited','MBP','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Mildura District Hospital Fund Ltd','MDH','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('National Health Benefits Australia Pty Ltd (onemedifund)','OMF','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Navy Health Ltd','NHB','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('NIB Health Funds Ltd','NIB','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Peoplecare Health Insurance','LHM','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Phoenix Health Fund Limited','PWA','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Police Health','SPE','Restricted','QLD, SA, TAS, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Queensland Country Health Fund Ltd','QCH','Open','QLD');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Railway and Transport Health Fund Limited','RTE','Restricted', 'ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Reserve Bank Health Society Ltd','RBH','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('St.Lukes Health','SLM','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Teachers Health Fund','NTF','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Teachers Union Health','QTU','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('The Doctors Health Fund', 'AMA','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Transport Health Pty Ltd','TFS','Restricted','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');
Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Westfund Ltd','WFD','Open','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');

comment on table clerical.lu_private_health_funds is
'a listing of private health funds available in australila http://www.privatehealth.gov.au/dynamic/healthfundlist.aspx accurate as of 22July12';



-- Now to make some alterations to patients table to normalise it
-- use proper integer value for lu_veteran_card_type
alter table clerical.data_patients add column fk_lu_veteran_card_type integer  default null references clerical.lu_veteran_card_type;
-- ditto for active_status becomes lu_active_status
-- fix me change the below to not null later.
alter table clerical.data_patients add column fk_lu_active_status integer references clerical.lu_active_status;
-- just in case Ian has patients in this table
update clerical.data_patients set active_status = 'a' where active_status is null;
-- transfer over the data and drop the old column 
update clerical.data_patients set fk_lu_active_status = 1 where active_status ='a';
update clerical.data_patients set fk_lu_active_status = 2 where active_status ='i';
alter table clerical.data_patients drop column active_status cascade;
-- now for the fun - one massive cascade, there is nothing in this column
-- view contacts.vwpatients - done
-- view clerical.vwtaskscomponents -done
-- view clerical.vwtaskscomponentsandnotes -done
-- view clin_consult.vwpatientconsults - done
-- view clin_recalls.vwrecallsdue -done 
-- view documents.vwdocuments - done
-- view clin_requests.vwrequestsordered -done
-- view documents.vwhl7filesimported - done
-- view research.vwmostrecenteyerelateddocuments - done
-- view research.diabetes_patients_latest_hba1c - done
-- view research.diabetes_patients_with_hba1c - done
-- view research.patientsnameshba1cover75 - done
-- view research.vwdiabetes_patients_with_hba1c - done
-- view research.vwdiabetics_with_ldlcholesterol - done
-- view research.vwdiabetics_with_microalbumins - done
-- view research.vwdiabeticsegfr depends on view - done
-- view research.vwldh depends on view contacts.vwpatients

-- now update the concession columns - no-one at this point as data in these
alter table clerical.data_patients drop column concession_card_name;
alter table clerical.data_patients drop column concession_type;
alter table clerical.data_patients add column fk_lu_centrelink_card_type integer default null 
references clerical.lu_centrelink_card_type;
alter table clerical.data_patients rename column concession_number to concession_card_number;
alter table clerical.data_patients rename column concession_expiry_date to concession_card_expiry_date;
alter table clerical.data_patients drop column veteran_card_type;
alter table clerical.data_patients drop column file_paper_number;
alter table clerical.data_patients drop column file_racgp_format;
alter table clerical.data_patients drop column file_chart_status;
alter table clerical.data_patients drop column private_billing_concession;
alter table clerical.data_patients add column fk_lu_billing_type integer ;
update clerical.data_patients set fk_lu_billing_type = 1;
alter table clerical.data_patients add column fk_lu_private_health_fund integer default null;
alter table  clerical.data_patients drop column private_insurance;
alter table clerical.data_patients add column private_insurance boolean default null;
comment on column clerical.data_patients.fk_next_of_kin is
'if not null points to person in the database who is the next of kin';
comment on column clerical.data_patients.fk_doctor  is
'if not null this is the patients perferred doctor' ;
comment on column clerical.data_patients.fk_person   is
'foreign key to contacts.data_persons table' ;
comment on column clerical.data_patients.fk_payer   is
'foreign key to data_patients ie he or she who pays the bill' ;
comment on column clerical.data_patients.fk_family is  
'foriegn key to clerical.data_families - links patients to a family unit' ;
comment on column clerical.data_patients.veteran_specific_condition    is
'the condition the veteran is entitled to if limited benefit' ;
comment on column clerical.data_patients.fk_lu_veteran_card_type  is
'the type of card 1 = full (gold) 2= specific entitlement (white)  3=war widow (lilac)' ;
comment on column clerical.data_patients.fk_lu_active_status  is
'key to clerical.lu_active_status 1= active 2 = inactive';
comment on column clerical.data_patients.fk_lu_centrelink_card_type  is
'key to clerial.lu_centrelink_card_type - the 3 card types in Australia';
comment on column clerical.data_patients.fk_lu_billing_type    is
'the billing level eg 1 = standard';
comment on column clerical.data_patients.private_insurance   is
'boolean value if true the patient has private insurance';
comment on column clerical.data_patients.fk_lu_private_health_fund is
'foreign key to clerical.lu_private_health_fund table listing nearly 40 private health funds';

-- ok, now to re-create the patient's view.

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
       CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, 
 patients.pk AS fk_patient, link_person_address.fk_address, patients.fk_person, 
 ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
 patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer, patients.fk_family, patients.medicare_number, 
 patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, 
 patients.veteran_specific_condition, patients.concession_card_number, patients.concession_card_expiry_date, 
 patients.memo AS patient_memo, patients.pk_legacy, patients.atsi, patients.fk_lu_veteran_card_type, 
 patients.fk_lu_active_status, patients.fk_lu_centrelink_card_type, patients.fk_lu_billing_type, patients.fk_lu_private_health_fund, 
 patients.private_insurance, lu_active_status.status AS active_status, lu_veteran_card_type.type AS veteran_card_type, 
 lu_centrelink_card_type.type AS concession_card_type, lu_private_health_funds.fund, persons.firstname, persons.surname, 
 persons.salutation, persons.birthdate, age_display(age(persons.birthdate::timestamp with time zone)) AS age_display, 
 date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric, persons.fk_ethnicity, 
 persons.fk_language, persons.memo AS person_memo, persons.fk_marital, persons.fk_title, persons.fk_sex, 
 persons.country_code AS country_birth_country_code, persons.fk_image, persons.retired, persons.fk_occupation,
 persons.deleted AS person_deleted, persons.deceased, persons.date_deceased, persons.language_problems, 
 persons.surname_normalised,
 country_birth.country AS country_birth, lu_ethnicity.ethnicity, lu_languages.language, lu_occupations.occupation, 
 lu_marital.marital, title.title, lu_sex.sex, lu_sex.sex_text, 
 images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, 
 link_person_address.pk AS fk_link_persons_address, addresses.street1, addresses.fk_town, 
 addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, 
 addresses.country_code, addresses.fk_lu_address_type, addresses.deleted, addresses.street2, 
 address_country.country AS country, link_person_address.deleted AS address_deleted, 
 lu_address_types.type AS address_type, lu_towns.postcode, lu_towns.town, lu_towns.state
   FROM clerical.data_patients patients
   JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
   LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
   LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
   LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
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


ALTER TABLE contacts.vwpatients  OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, 
 tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, 
 vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
 vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
 vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
 task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
 task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
 task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, 
 task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, 
 vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, 
 vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, 
 vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename,
 vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
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

ALTER TABLE clerical.vwtaskscomponents   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;



CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task,
        tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, tasks.deleted AS task_deleted, 
        tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
        vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
        vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
        task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
        task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, 
        task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
        vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, 
        vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, 
        vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, 
        vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, 
        lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note
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

ALTER TABLE clerical.vwtaskscomponentsandnotes   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;



CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view, vwprogressnotes.fk_patient, 
 vwprogressnotes.consult_date, vwprogressnotes.consult_type, vwprogressnotes.fk_staff, 
 vwprogressnotes.title AS staff_title, vwprogressnotes.surname AS staff_surname, vwprogressnotes.firstname AS staff_firstname, 
 vwprogressnotes.linked_table, vwprogressnotes.fk_type, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, 
 vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, 
 vwpatients.deceased, vwpatients.sex, vwpatients.title, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.age_display
   FROM clin_consult.vwprogressnotes, contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;


CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, 
 recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, 
 recalls.active, recalls.additional_text, recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_progressnote, 
 recalls.fk_pasthistory, recalls.fk_sent, recalls.num_reminders, sent.latex, sent.date AS date_reminder_sent, 
 lu_units.abbrev_text, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, 
 vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.sex, vwpatients.title, vwpatients.street1, 
 vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, vwpatients.language_problems, 
 vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, 
 vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, 
 lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, 
 consult.consult_date, recalls.fk_template, lu_appointment_length1.length, lu_templates.name, lu_templates.template
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
   LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue   OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, 
 documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, 
 documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, 
 documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, 
 documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user,
 documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, 
 documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type,
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
 unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate,
 unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, 
 unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town,
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

ALTER TABLE documents.vwdocuments   OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, 
 forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, 
 data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, 
 lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, 
 forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, 
 forms.fk_request_provider AS fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, 
 forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, 
 forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, 
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

ALTER TABLE clin_requests.vwrequestsordered   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsordered TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported   OWNER TO easygp;
GRANT ALL ON TABLE documents.vwhl7filesimported TO easygp;
GRANT SELECT ON TABLE documents.vwhl7filesimported TO staff;


CREATE OR REPLACE VIEW research.vwmostrecenteyerelateddocuments AS 
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, vwdocuments.fk_patient, 
 vwdocuments.pk_document AS fk_document, vwdocuments.date_created, vwdocuments.deleted
   FROM documents.vwdocuments
  WHERE (vwdocuments.organisation_category::text ~~* '%ophthal%'::text OR vwdocuments.organisation_category::text ~~* '%optom%'::text 
  OR vwdocuments.person_occupation ~~* '%ophthal%'::text OR vwdocuments.person_occupation ~~* '%optom%'::text) AND vwdocuments.deleted = false
  ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;

ALTER TABLE research.vwmostrecenteyerelateddocuments   OWNER TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO staff;
COMMENT ON VIEW research.vwmostrecenteyerelateddocuments
  IS '
This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient
';

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

ALTER TABLE research.diabetes_patients_latest_hba1c  OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;

CREATE OR REPLACE VIEW research.diabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.observation_date, vwgraphableobservations.loinc, 
 vwgraphableobservations.value_numeric, vwpatients.firstname, vwpatients.wholename, vwpatients.age_display, 
 vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, 
 vwpatients.occupation, vwpatients.postcode, vwpatients.surname, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.marital
   FROM contacts.vwpatients, documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.diabetes_patients_with_hba1c   OWNER TO easygp;
GRANT ALL ON TABLE research.diabetes_patients_latest_hba1c TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;

CREATE OR REPLACE VIEW research.patientsnameshba1cover75 AS 
 SELECT DISTINCT vwpatients.wholename, vwpatients.age_display, vwpatients.sex
   FROM contacts.vwpatients, documents.patientshba1cover75
  WHERE patientshba1cover75.fk_patient = vwpatients.fk_patient;

ALTER TABLE research.patientsnameshba1cover75   OWNER TO easygp;
GRANT ALL ON TABLE research.patientsnameshba1cover75 TO easygp;
GRANT SELECT ON TABLE research.patientsnameshba1cover75 TO staff;

CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations, vwgraphableobservations.observation_date, vwgraphableobservations.loinc, 
 vwgraphableobservations.value_numeric, vwpatients.fk_patient, vwpatients.firstname, vwpatients.surname, vwpatients.wholename, 
 vwpatients.age_display, vwpatients.sex, vwpatients.title, vwpatients.occupation, vwpatients.fk_image, vwpatients.birthdate, 
 vwpatients.age_numeric, vwpatients.marital, vwpatients.fk_person, vwpatients.deceased, vwpatients.active_status, vwpatients.street1,
 vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode
   FROM contacts.vwpatients, documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;
COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c
  IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


 CREATE OR REPLACE VIEW research.vwdiabetics_with_ldlcholesterol AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, 
 vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, 
 vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, 
 vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '22748-8'::text;

ALTER TABLE research.vwdiabetics_with_ldlcholesterol  OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_ldlcholesterol TO easygp;
GRANT SELECT ON TABLE research.vwdiabetics_with_ldlcholesterol TO staff;

COMMENT ON VIEW research.vwdiabetics_with_ldlcholesterol
  IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwdiabetics_with_microalbumins AS 
 SELECT vwmicroalbuminuria.identifier, vwmicroalbuminuria.observation_date, vwmicroalbuminuria.value_numeric, vwmicroalbuminuria.value_numeric_qualifier, vwmicroalbuminuria.units, vwmicroalbuminuria.reference_range, vwmicroalbuminuria.abnormal, vwmicroalbuminuria.loinc, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status
   FROM research.vwmicroalbuminuria, research.vwdiabetes_patients_with_hba1c
  WHERE vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient
  ORDER BY vwdiabetes_patients_with_hba1c.fk_patient, vwmicroalbuminuria.observation_date;

ALTER TABLE research.vwdiabetics_with_microalbumins   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO staff;
COMMENT ON VIEW research.vwdiabetics_with_microalbumins
  IS 'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';


CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '33914-3'::text;

ALTER TABLE research.vwdiabeticsegfr   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabeticsegfr TO easygp;
GRANT SELECT ON TABLE research.vwdiabeticsegfr TO staff;
COMMENT ON VIEW research.vwdiabeticsegfr
  IS 'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwldh AS 
 SELECT vwpatients.wholename, vwpatients.fk_patient, vwobservations.value_numeric, vwobservations.abnormal
   FROM contacts.vwpatients, documents.vwobservations
  WHERE vwobservations.identifier ~~* '%LDH%'::text AND vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.abnormal IS NOT NULL
  ORDER BY vwobservations.value_numeric;

ALTER TABLE research.vwldh   OWNER TO easygp;
GRANT ALL ON TABLE research.vwldh TO easygp;
GRANT ALL ON TABLE research.vwldh TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 199);

