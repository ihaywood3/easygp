alter table clerical.data_patients drop constraint "data_patients_pcehr_consent_check";
alter table clerical.data_patients add constraint "data_patients_pcehr_consent_check" CHECK (pcehr_consent = ANY (ARRAY['n'::bpchar, 'c'::bpchar, 'e'::bpchar, 'r'::bpchar, 'x'::bpchar, 'h'::bpchar, 'd'::bpchar, 'v'::bpchar]));

comment on column clerical.data_patients.pcehr_consent is 'consent status. n=not asked yet, c=consented, v=validated, x=not eligible (tourist, asylum-seeker, etc), r=refused, e=error, h=details cHange,d=deceased';


CREATE OR REPLACE FUNCTION clerical.create_patient_new_ihi() RETURNS trigger AS $new_ihi$
BEGIN
	EXECUTE 'NOTIFY newihi';
	RETURN NEW;
END;
$new_ihi$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION clerical.person_death() RETURNS trigger AS $x$
BEGIN
	EXECUTE 'NOTIFY death';
	RETURN NEW;
END;
$x$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION clerical.updated_patient_new_ihi() RETURNS trigger AS $new_ihi$
BEGIN
	NEW.pcehr_consent := 'h';
	EXECUTE 'NOTIFY newihi';
	RETURN NEW;
END;
$new_ihi$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION clerical.updated_person_new_ihi() RETURNS trigger AS $xyz$
BEGIN
  UPDATE clerical.data_patients SET pcehr_consent ='h' WHERE fk_person = NEW.pk AND pcehr_consent IN ('e','c');
  EXECUTE 'NOTIFY newihi';
  RETURN NEW;
END;
$xyz$ LANGUAGE plpgsql;

CREATE TRIGGER ihi_new BEFORE INSERT ON clerical.data_patients
    FOR EACH ROW 
    WHEN (NEW.pcehr_consent = 'c' AND NEW.ihi IS NULL)
    EXECUTE PROCEDURE clerical.create_patient_new_ihi();

CREATE TRIGGER ihi_new_provided BEFORE INSERT ON clerical.data_patients
    FOR EACH ROW 
    WHEN (NEW.pcehr_consent IN ('c','h') AND NEW.ihi IS NOT NULL)
    EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

CREATE TRIGGER ihi_update BEFORE UPDATE ON clerical.data_patients
    FOR EACH ROW 
    WHEN (NEW.pcehr_consent IN ('c','h','e') AND (
    	 		     NEW.ihi IS NULL OR
			     (NEW.ihi <> OLD.ihi) OR  
    	 		     (NEW.medicare_number <> OLD.medicare_number AND NEW.medicare_number IS NOT NULL) OR
			     (NEW.veteran_number <> OLD.veteran_number AND NEW.veteran_number IS NOT NULL)))
    EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

CREATE TRIGGER persons_ihi_update BEFORE UPDATE ON contacts.data_persons
       FOR EACH ROW
       WHEN (NEW.firstname <> OLD.surname OR NEW.surname <> OLD.surname OR NEW.birthdate <> OLD.birthdate)
       EXECUTE PROCEDURE clerical.updated_person_new_ihi();

CREATE TRIGGER "death" BEFORE UPDATE ON contacts.data_persons 
       	 FOR EACH ROW
	 WHEN (NEW.deceased AND OLD.deceased IS NOT TRUE)
	 EXECUTE PROCEDURE clerical.person_death();

alter table contacts.data_numbers add column (hic_location_id char(8) check hic_location_id ~ '[A-Z]{3}[0-9]{5}');
comment on column contacts.data_numbers.hic_location_id is 'the HIC Location ID, a legacy of HIC Online billing system, now also used for e-scripts. Consists of a 3-letter prefix assigned to the vendor by Medicare, and a 5-digit site code issued by the vendor to each user.';

create or replace view admin.vwclinics as 
SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, data_organisations.deleted AS organisation_deleted, lu_categories.category, data_numbers.hpio, data_numbers.hic_location_id
   FROM admin.clinics
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.data_numbers ON (data_numbers.fk_branch = data_branches.pk AND data_numbers.fk_person IS NULL)
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk;
 

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
 org_numbers.hpio , org_numbers.hic_location_id
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

alter TABLE contacts.data_numbers drop COLUMN prescriber_number;

alter table clin_prescribing.prescribed add column medisecure_uuid uuid default uuid_generate_v4() ;
alter table clin_prescribing.prescribed add column medisecure_barcode char(16) check (medisecure_barcode ~ '[A-Z]{3}[0-9]{13}');
alter table clin_prescribing.prescribed add column escript_uploaded boolean;
comment on column clin_prescribing.prescribed.medisecure_uuid is 'UUID for each script, for MediSecure''s XML';
comment on column clin_prescribing.prescribed.medisecure_barcode is 'the barcode printed on the script';
comment on column clin_prescribing.prescribed.escript_uploaded is 'false=not uploaded yet, true=uploaded, NULL=not an e-script';

create or replace view clin_prescribing.vwprescribeditems as
 SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, product.generic, brand.brand, product.strength, brand.product_information_filename, form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, prescribed.authority_reason, prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, vwstaff.title AS staff_prescribed_title, product.atccode, product.salt, product.fk_form, product.fk_schedule, product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.restriction_code, prescribed.fk_code, prescribed.reg24, lu_pbs_script_type.type AS pbs_script_type, restriction.streamlined, restriction.restriction, restriction.restriction_type, schedules.schedule, drugs.format_strength(product.strength) AS display_strength, drugs.format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack, prescribed.medisecure_uuid, prescribed.medisecure_barcode, prescribed.escript_uploaded
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_prescribing.prescribed ON consult.pk = prescribed.fk_consult
   JOIN clin_prescribing.medications medications ON prescribed.fk_medication = medications.pk
   JOIN clin_prescribing.prescribed_for ON prescribed.fk_prescribed_for = prescribed_for.pk
   JOIN clin_prescribing.instructions ON prescribed.fk_instruction = instructions.pk
   JOIN clin_prescribing.lu_pbs_script_type ON prescribed.fk_lu_pbs_script_type = lu_pbs_script_type.pk
   LEFT JOIN drugs.restriction ON prescribed.pbscode = restriction.pbscode::text AND prescribed.restriction_code = restriction.code::text
   LEFT JOIN drugs.brand ON prescribed.fk_brand = brand.pk
   JOIN drugs.product ON medications.fk_generic_product = product.pk
   LEFT JOIN drugs.schedules ON product.fk_schedule = schedules.pk
   JOIN drugs.form ON product.fk_form = form.pk;
