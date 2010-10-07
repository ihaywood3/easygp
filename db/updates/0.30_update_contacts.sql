alter table contacts.data_addresses drop column address_type cascade;
alter table contacts.data_addresses rename column fk_type to fk_lu_address_type;

--note this drop cascades to cascades to:
-- admin.vwclinics 
-- admin.vwclinicrooms
-- clin_requests.vwrequestforms
-- contacts.vwpersonsaddresses 
-- clin_workcover.vwworkcover
-- contacts.vwpersons
-- contacts.vwpersonsexcludingpatients
-- contacts.vwpersonsincludingpatients
-- contacts.vworganisationsemployees
-- documents.vwsendingentities
-- clin_history.vwteamcaremembers 
-- clin_mentalhealth.vwteamcaremembers 
-- clin_requests.vwrequestproviderss
-- contacts.vwpatients 
--documents.vwdocuments 
-- clin_requests.vwforms 
-- admin.vwstaffinclinics
-- clerical.vwtaskscomponentsnotes
-- clerical.vwtaskscomponents
-- clin_certificates.vwmedicalcertificates
-- documents.vwinboxstaff



CREATE OR REPLACE VIEW "admin".vwclinics AS  -- checked, works ok
 SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, 
 data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, data_addresses.street,
  data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, 
  data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type,
  lu_address_types.type as address_type,
   data_addresses.deleted, 
  lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches,
   data_organisations.deleted AS organisation_deleted, lu_categories.category
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


CREATE OR REPLACE VIEW "admin".vwclinicrooms AS -- checked works ok
 SELECT clinic_rooms.pk, clinic_rooms.room_name, clinic_rooms.script_printer, clinic_rooms.default_printer,
  clinic_rooms.fk_clinic, vwclinics.organisation, vwclinics.branch, vwclinics.street, vwclinics.town
   FROM admin.clinic_rooms, admin.vwclinics
  WHERE clinic_rooms.fk_clinic = vwclinics.fk_clinic
  ORDER BY clinic_rooms.fk_clinic, clinic_rooms.room_name;

ALTER TABLE "admin".vwclinicrooms OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwclinicrooms TO easygp;


CREATE OR REPLACE VIEW clin_requests.vwrequestforms AS  -- checked works ok
 SELECT consult.consult_date, consult.fk_patient, data_persons1.firstname, data_persons1.surname, data_persons1.birthdate, 
 lu_sex.sex, forms.date AS request_date, forms.pk AS pk_form, forms.fk_consult, forms.fk_branch,
  forms.fk_lu_request_type AS fk_type, forms.requests_summary, forms.notes_summary,
   forms.medications_summary, forms.form_html, forms.deleted, forms.copyto_patient, 
   forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, 
   forms.copyto, lu_title.title AS staff_title, data_persons.surname AS staff_surname, 
   data_persons.firstname AS staff_firstname, data_branches.branch, 
   data_organisations.organisation, data_branches.fk_organisation, 
   data_addresses.pk AS fk_address, data_addresses.street, data_addresses.fk_town,
   lu_address_types.type as address_type, data_addresses.preferred_address, 
    data_addresses.postal_address, data_addresses.head_office,
     data_addresses.geolocation, data_addresses.country_code, lu_towns.postcode, 
     lu_towns.town, lu_towns.state, data_patients.fk_person, data_persons1.fk_sex
   FROM admin.staff
   LEFT JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   JOIN clin_consult.consult ON consult.fk_staff = staff.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN clin_requests.forms ON forms.fk_consult = consult.pk
   JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
   JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
   JOIN contacts.data_persons data_persons1 ON data_patients.fk_person = data_persons1.pk
   LEFT JOIN contacts.lu_sex ON data_persons1.fk_sex = lu_sex.pk
  WHERE forms.deleted = false
  ORDER BY consult.fk_patient, forms.date;

ALTER TABLE clin_requests.vwrequestforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;

CREATE OR REPLACE VIEW contacts.vwpersons AS   -- checked works ok
 SELECT data_persons.pk AS fk_person, 
        CASE
            WHEN "Addresses".pk > 0 THEN COALESCE((data_persons.pk || '-'::text) || "Addresses".pk)
            ELSE data_persons.pk || '-0'::text
        END AS pk_view,
         ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename, 
        data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, 
        data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, data_persons.fk_marital, 
        data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, data_persons.fk_occupation, 
        data_persons.fk_category, data_persons.retired, data_persons.deceased, data_persons.date_deceased, 
        lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, lu_occupations.occupation, 
        lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, 
        links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state,
         data_persons.country_code, lu_categories.category, "Addresses".street, "Addresses".fk_town, 
         "Addresses".fk_lu_address_type, lu_address_types.type as address_type,  
         "Addresses".preferred_address, "Addresses".postal_address, "Addresses".head_office, 
         "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image
   FROM contacts.data_persons
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN common.lu_occupations ON data_persons.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_categories ON data_persons.fk_category = lu_categories.pk
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


CREATE OR REPLACE VIEW contacts.vwpersonsaddresses AS -- checked, works ok.
 SELECT links_persons_addresses.fk_address AS pk_view, links_persons_addresses.fk_person, links_persons_addresses.fk_address,
  data_addresses.street, data_addresses.fk_town,lu_address_types.type as address_type, data_addresses.preferred_address,
   data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code,
    data_addresses.fk_lu_address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state
    FROM contacts.links_persons_addresses
   JOIN contacts.data_addresses ON links_persons_addresses.fk_address = data_addresses.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
  WHERE data_addresses.head_office = false AND data_addresses.deleted = false
  ORDER BY links_persons_addresses.fk_person;

ALTER TABLE contacts.vwpersonsaddresses OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsaddresses TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS  -- probably ok
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname,
  vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language,
   vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation,
    vwpersons.fk_category, vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex,
     vwpersons.sex_text, vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.category,
      vwpersons.language, vwpersons.country, vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode,
       vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street, vwpersons.fk_town,
        vwpersons.fk_lu_address_type, vwpersons.address_type,
         vwpersons.preferred_address, vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN all_images ON vwpersons.fk_image = all_images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

ALTER TABLE contacts.vwpersonsexcludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;

CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address,
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename,
         persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, 
         age(persons.birthdate::timestamp with time zone)) AS age, marital.marital, sex.sex, title.title, 
         countries.country, languages.language, ethnicity.ethnicity, addresses.street, towns.town, towns.state, 
         towns.postcode, addresses.fk_town, lu_address_types.type as address_type, addresses.preferred_address, addresses.postal_address, 
         addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, 
         addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital,
          persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, all_images.pk AS fk_image, 
          all_images.image
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
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = addresses.fk_lu_address_type
   JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk;

ALTER TABLE contacts.vwpersonsincludingpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients  TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';


CREATE OR REPLACE VIEW contacts.vworganisationsemployees AS 
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic,
         organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch,
          branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, 
          employees.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, 
         addresses.preferred_address, addresses.postal_address, addresses.head_office, 
          addresses.country_code, addresses.fk_lu_address_type, 

          addresses.deleted AS address_deleted, 
          towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, 
                CASE
                    WHEN employees.pk > 0 THEN ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text)
                    ELSE 'Nothing'::text
                END AS wholename, employees.fk_occupation, employees.fk_category AS fk_employee_category, employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title
           FROM contacts.data_employees employees
      JOIN contacts.data_branches branches ON employees.fk_branch = branches.pk
   LEFT JOIN contacts.lu_categories categories ON employees.fk_category = categories.pk
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
         SELECT nextval('contacts.vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic,
          organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch,
           branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, 
           branches.memo, branches.fk_category, categories.category, addresses.street, 
           addresses.fk_town, addresses.preferred_address, 
           addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, 
           addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, (organisations.organisation::text || ' '::text) || branches.branch AS wholename, 0 AS fk_occupation, 0 AS fk_employee_category, 0 AS fk_status, NULL::unknown AS employee_status, false AS employee_deleted, NULL::unknown AS occupation, 0 AS fk_person, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS salutation, NULL::unknown AS birthdate, false AS deceased, NULL::unknown AS date_deceased, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::unknown AS sex, NULL::unknown AS title
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

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, consult1.consult_date AS visit_date, consult.consult_date AS start_date, claims.identifier, claims.accepted, consult.fk_patient, visits.fk_claim, visits.fk_lu_visit_type, visits.diagnosis, visits.fk_coding_system, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.fk_progressnote, visits.management_plan, visits.review_date, visits.assessworkplace,
         visits.hours_capable, visits.days_capable, visits.restrictions, visits.capabilities, visits.fk_caused_by_employment,
          lu_caused_by_employment.caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from,
           visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from,
            visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult AS fk_consult_visit, 
            claims.fk_consult AS fk_consult_claim, claims.claim_number, claims.fk_occupation, claims.fk_branch,
            claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, 
            consult.fk_staff AS fk_doctor, lu_occupations.occupation, data_persons.firstname AS doctor_firstname,
             data_persons.surname AS doctor_surname, lu_title.title AS doctor_title, lu_sex.sex AS doctor_sex,
             lu_visit_type.type AS visit_type, data_branches.branch, lu_categories.category AS branch_category,
              data_organisations.organisation, data_organisations.pk AS fk_organisation, data_addresses.pk AS fk_address,
               data_addresses.street, data_addresses.fk_town,lu_address_types.type as address_type,
                data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office,
                 data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type,
                  data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_staff_roles.role AS staff_role
   FROM clin_workcover.claims
   JOIN clin_workcover.visits ON claims.pk = visits.fk_claim
   JOIN clin_consult.consult ON claims.fk_consult = consult.pk
   JOIN common.lu_occupations ON claims.fk_occupation = lu_occupations.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   JOIN clin_workcover.lu_visit_type ON visits.fk_lu_visit_type = lu_visit_type.pk
   JOIN clin_workcover.lu_caused_by_employment ON visits.fk_caused_by_employment = lu_caused_by_employment.pk
   JOIN contacts.data_branches ON claims.fk_branch = data_branches.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   JOIN clin_consult.consult consult1 ON visits.fk_consult = consult1.pk
   LEFT JOIN coding.lu_systems ON visits.fk_coding_system = lu_systems.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
    LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk
  ORDER BY consult.fk_patient, consult.consult_date, consult1.consult_date;

ALTER TABLE clin_workcover.vwworkcover OWNER TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';
 
 
 

CREATE OR REPLACE VIEW documents.vwsendingentities AS 
 SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_provider_type, lu_categories.category AS provider_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, sending_entities.exclude_ft_report, sending_entities.exclude_pit, lu_message_display_style.style, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.fk_address AS fk_address_organisation, vworganisationsemployees.fk_category AS fk_category_organisation, vworganisationsemployees.category AS organisation_category, vworganisationsemployees.street AS organisation_street, vworganisationsemployees.fk_town AS fk_town_organisation, vworganisationsemployees.postal_address AS organisation_postal_address, vworganisationsemployees.head_office AS organisation_head_office, vworganisationsemployees.postcode AS organisation_postcode, vworganisationsemployees.town AS organisation_town, vworganisationsemployees.state AS organisation_state, vworganisationsemployees.fk_organisation, vwpersons.firstname, vwpersons.surname, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_occupation, vwpersons.fk_category AS fk_category_person, vwpersons.category AS person_category, vwpersons.occupation AS person_occupation, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person
   FROM documents.sending_entities
   LEFT JOIN contacts.lu_categories ON sending_entities.fk_lu_provider_type = lu_categories.pk
   JOIN documents.lu_message_display_style ON sending_entities.fk_lu_message_display_style = lu_message_display_style.pk
   JOIN documents.lu_message_standard ON sending_entities.fk_lu_message_standard = lu_message_standard.pk
   LEFT JOIN contacts.vworganisationsemployees ON sending_entities.fk_branch = vworganisationsemployees.fk_branch
   LEFT JOIN contacts.vwpersons ON sending_entities.fk_person = vwpersons.fk_person
  ORDER BY sending_entities.msh_sending_entity;

ALTER TABLE documents.vwsendingentities OWNER TO easygp;
GRANT ALL ON TABLE documents.vwsendingentities TO easygp;
GRANT SELECT ON TABLE documents.vwsendingentities TO staff;
COMMENT ON VIEW documents.vwsendingentities IS 'View of the sending entities note:
  -  LEFT JOIN contacts.lu_categories as when a file is parsed fk_lu_provider type cannot exist
  -  ditto for the sending organisation, employee or person
  -  not employee not implemented';

CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_history.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_history.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcaremembers TO staff;

CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
         SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, 
                CASE
                    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
                    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
                END AS wholename, ((vworganisationsemployees.organisation::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
                    ELSE (((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
                END AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
     WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION 
         SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, (((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary, team_care_members.responsibility
           FROM clin_mentalhealth.team_care_members
      JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL
  ORDER BY 2;

ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;


CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
 SELECT lu_request_type.type, request_providers.fk_lu_request_type, request_providers.fk_person, request_providers.fk_employee, request_providers.fk_branch, request_providers.pk AS pk_request_provider, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.postcode, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.fk_organisation, vworganisationsemployees.category, vworganisationsemployees.street, vworganisationsemployees.head_office
   FROM clin_requests.request_providers
   JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.vworganisationsemployees ON request_providers.fk_branch = vworganisationsemployees.fk_branch
  ORDER BY request_providers.fk_lu_request_type, vworganisationsemployees.organisation;

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT 
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view, patients.pk AS fk_patient, addresses.pk AS fk_address,
         patients.fk_person, ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename,
          persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
          date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, marital.marital, 
          sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, 
          occupation.occupation, addresses.street, towns.town, towns.state, towns.postcode, addresses.fk_town,
          lu_address_types.type as address_type, addresses.fk_lu_address_type,
          addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, 
          addresses.country_code,  addresses.deleted AS address_deleted, 
          persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital, persons.fk_title, persons.fk_sex, 
          persons.fk_occupation, persons.retired, persons.deceased, persons.date_deceased, patients.fk_doctor, 
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



CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, vwsendingentities.fk_lu_provider_type, vwsendingentities.provider_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.organisation_category, vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number
   FROM documents.documents
   JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
   LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
   LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
   LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
   LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk
  ORDER BY documents.fk_patient, documents.date_created;

ALTER TABLE documents.vwdocuments OWNER TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO easygp;
GRANT ALL ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwforms AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type AS fk_lu_type, lu_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date AS request_date, forms_requests.request_result_html, forms.forms_results_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.form_html, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
   FROM clin_requests.forms
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.lu_type ON lu_requests.fk_type = lu_type.pk
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
   JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwforms TO staff;

CREATE OR REPLACE VIEW "admin".vwstaffinclinics AS 
 SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename,
  staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number,
   staff.prescriber_number, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff,
    link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, 
    data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category,
     data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, 
     data_employees.fk_category AS fk_employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted,
      data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate,
       data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital,
        data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, 
        data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased,
         data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_categories.category AS employee_category,
          lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, all_images.image, all_images.deleted AS image_deleted,
           lu_staff_roles.role, lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted,
            data_addresses.street, data_addresses.fk_town,lu_address_types.type as address_type,
             data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation,
              data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, 
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
   LEFT JOIN contacts.lu_categories ON data_employees.fk_category = lu_categories.pk
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

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_task_types.type AS task_type, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN clerical.lu_task_types ON task_components.fk_lu_task_type = lu_task_types.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;


CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;

CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificate.pk AS pk_medicalcertificate, medical_certificate.fk_patient, medical_certificate.fk_consult, medical_certificate.reason, medical_certificate.fk_coding_system, medical_certificate.fk_code, medical_certificate.fk_lu_illness_temporality, medical_certificate.from_date, medical_certificate.deleted, medical_certificate.to_date, consult.consult_date AS date_issued, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street AS staff_street, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality
   FROM clin_certificates.medical_certificate
   JOIN clin_consult.consult ON medical_certificate.fk_consult = consult.pk
   JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
   JOIN clin_certificates.lu_illness_temporality ON medical_certificate.fk_lu_illness_temporality = lu_illness_temporality.pk
  WHERE medical_certificate.deleted = false
  ORDER BY medical_certificate.fk_patient, consult.consult_date;

ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO staff;
COMMENT ON VIEW clin_certificates.vwmedicalcertificates IS 'A view of patients medical certificate history, includes written by which staff member and where';



CREATE OR REPLACE VIEW documents.vwinboxstaff AS 
         SELECT vwstaffinclinics.pk_view, vwstaffinclinics.title, vwstaffinclinics.fk_staff, vwstaffinclinics.wholename, vwstaffinclinics.surname, NULL::unknown AS fk_unmatched_staff
           FROM admin.vwstaffinclinics
UNION 
         SELECT (unmatched_staff.pk || '-'::text) || 'unmatched'::text AS pk_view, unmatched_staff.title, unmatched_staff.fk_real_staff AS fk_staff, (unmatched_staff.firstname || ' '::text) || (unmatched_staff.surname || ' [Unkown]'::text) AS wholename, unmatched_staff.surname, unmatched_staff.pk AS fk_unmatched_staff
           FROM documents.unmatched_staff
          WHERE unmatched_staff.fk_real_staff IS NULL
  ORDER BY 5;

ALTER TABLE documents.vwinboxstaff OWNER TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO easygp;
GRANT ALL ON TABLE documents.vwinboxstaff TO staff;
COMMENT ON VIEW documents.vwinboxstaff IS 'All staff with an inbox. If the staff member is unknown, they will still
 appear, once matched to a real staff member they are not pulled from
 the unmatched table ie fk_real_staff <> null then';
 
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 30);