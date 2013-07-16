-- added the practices hpio field

CREATE OR REPLACE VIEW admin.vwstaffinclinics AS 
 SELECT DISTINCT ON (staff.pk, clinics.pk) (staff.pk || '-'::text) || data_addresses.pk AS pk_view, 
(data_persons.firstname || ' '::text) || data_persons.surname AS wholename, 
staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, employee_numbers.provider_number,
data_numbers_persons.prescriber_number, staff.fk_lu_staff_type, staff.logon_date_from, staff.logon_date_to,
link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch,
data_branches.branch, data_branches.fk_organisation, data_branches.fk_address,
data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category,
data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee,
data_employees.fk_occupation, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted,
data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate,
data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo,
data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code,
data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased,
data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_occupations.occupation,
lu_ethnicity.ethnicity, lu_languages.language, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image,
images.deleted AS image_deleted, lu_staff_roles.role, lu_staff_type.type AS staff_type, lu_employee_status.status,
data_organisations.organisation, data_organisations.deleted AS organisation_deleted, data_addresses.street1, data_addresses.street2, 
data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, 
data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, 
data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, 
link_staff_clinics1.pk AS fk_link_staff_clinic, staff.qualifications, data_persons.surname_normalised, data_numbers_persons.hpii,
 org_numbers.hpio 
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   JOIN admin.lu_staff_type ON staff.fk_lu_staff_type = lu_staff_type.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = staff.fk_person 
   LEFT JOIN contacts.data_numbers employee_numbers ON employee_numbers.fk_branch = clinics.fk_branch AND employee_numbers.fk_person = staff.fk_person 
   LEFT JOIN contacts.data_numbers org_numbers ON org_numbers.fk_person IS NULL AND clinics.fk_branch = org_numbers.fk_branch 
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

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 303)

