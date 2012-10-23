alter table contacts.data_numbers add column pk serial primary key;
alter table contacts.data_numbers alter column fk_person drop not null;

COMMENT ON TABLE contacts.data_numbers
  IS 'table for various types of numbers for persons or organisations
      e.g Medicare provider numbers and prescriber numbers, australian business numbers.
      Used to be in admin.staff, but now here because we need to record provider numbers 
      for external contacts too.';

alter table contacts.data_numbers alter column provider_number drop not null;

COMMENT ON COLUMN contacts.data_numbers.provider_number IS 
'the Medicare Australia alphanumeric provider number. ';

CREATE OR REPLACE VIEW contacts.vworganisations AS 
 SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, 
 organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, 
 branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, 
 branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town, 
 addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, 
 addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state,
 data_numbers.australian_business_number
   FROM contacts.data_branches branches
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers on branches.pk= data_numbers.fk_branch
   
  ORDER BY nextval('contacts.vworganisations_pk_seq'::regclass), organisations.organisation, organisations.deleted;

ALTER TABLE contacts.vworganisations   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisations TO easygp;
GRANT ALL ON TABLE contacts.vworganisations TO staff;

CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT (((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk AS pk_view, clinics.pk AS fk_clinic, 
         organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, 
         branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, 
         employees.memo, branches.fk_category, NULL::character varying AS category, addresses.street1, 
         addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, 
         addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, 
         towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, 
                employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, 
                persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, 
                persons.retired, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, 
                persons.fk_sex, sex.sex, title.title, persons.surname_normalised, data_numbers.provider_number, 
                data_numbers.prescriber_number, data_numbers.australian_business_number
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
   LEFT JOIN contacts.data_numbers ON employees.fk_person = data_numbers.fk_person AND branches.pk = data_numbers.fk_branch
  WHERE employees.fk_person IS NOT NULL
UNION 
         SELECT ((organisations.pk || '-'::text) || branches.pk) || '-0'::text AS pk_view, clinics.pk AS fk_clinic, 
         organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, 
         branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, 
         branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town, 
         addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, 
         addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, 
         towns.state, 0 AS fk_employee, (organisations.organisation || ' '::text) || branches.branch AS wholename, 
         0 AS fk_occupation, 0 AS fk_status, NULL::text AS employee_status, false AS employee_deleted, 
         NULL::text AS occupation, 0 AS fk_person, NULL::text AS firstname, NULL::text AS surname, 
         NULL::text AS salutation, NULL::date AS birthdate, false AS deceased, NULL::date AS date_deceased, 
         false AS retired, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, 
         NULL::text AS sex, NULL::text AS title, NULL::text AS surname_normalised, NULL::text AS provider_number, 
         NULL::text AS prescriber_number, data_numbers.australian_business_number
           FROM contacts.data_branches branches
      JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers  on branches.pk = data_numbers.fk_branch;
   
ALTER TABLE contacts.vworganisationsemployees   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO easygp;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 236);

