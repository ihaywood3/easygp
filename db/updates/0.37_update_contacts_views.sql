-- added some new views to contacts to assist in letter writing

-- added the data_person.deleted field to this view:


DROP VIEW contacts.vwpersonsexcludingpatients cascade;

CREATE OR REPLACE VIEW contacts.vwpersonsexcludingpatients AS 
 SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, 
 vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.memo, vwpersons.fk_marital, 
 vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.fk_category, 
 vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, vwpersons.title, 
 vwpersons.marital, vwpersons.occupation, vwpersons.category, vwpersons.language, vwpersons.country, vwpersons.fk_link_address, 
 vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street, 
 vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, vwpersons.postal_address, 
 vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, vwPersons.deleted
   FROM contacts.vwpersons
   LEFT JOIN clerical.data_patients ON vwpersons.fk_person = data_patients.fk_person
   LEFT JOIN all_images ON vwpersons.fk_image = all_images.pk
  WHERE data_patients.pk IS NULL
  ORDER BY vwpersons.fk_person, vwpersons.fk_address;

GRANT ALL ON TABLE contacts.vwpersonsexcludingpatients TO staff;

-- add person_deleted field to this view:

DROP VIEW contacts.vwemployees  ;

CREATE OR REPLACE VIEW contacts.vwemployees AS 
 SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, data_persons.surname, 
 data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, data_employees.fk_category AS fk_category_employee, 
 lu_categories1.category AS employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted,
  data_employees.fk_status, data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, 
  data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, 
  lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, 
  data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code,
   data_persons.fk_image, data_persons.retired, data_persons.deleted as person_deleted, data_persons.deceased, data_persons.date_deceased,
    lu_sex.sex, data_addresses.street, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted
   FROM contacts.data_employees
   JOIN contacts.data_branches ON data_employees.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.lu_categories lu_categories1 ON data_employees.fk_category = lu_categories1.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
  WHERE data_employees.deleted = false
  ORDER BY data_persons.surname, data_persons.firstname;

GRANT ALL ON TABLE contacts.vwemployees TO staff;


Create or replace view contacts.vwPersonsOrEmployees_By_Occupation as

Select distinct fk_person as pk_view, fk_person, surname, firstname, title || ' ' || firstname || ' ' || surname as wholename, 

occupation from contacts.vwEmployees 
where  person_deleted = false 
UNION

Select distinct fk_person as pk_view, fk_person, surname, firstname, 
title || ' ' || firstname || ' ' || surname as wholename, 
occupation from contacts.vwPersonsExcludingPatients where 
 retired = false and deceased = false and deleted = false and occupation is not null 

ORDER BY surname, firstname ASC;

GRANT ALL ON TABLE contacts.vwPersonsOrEmployees_By_Occupation TO staff;

COMMENT ON VIEW contacts.vwPersonsOrEmployees_By_Occupation IS
  'a view of all people in the database, either employees in companies or sole traders';

-- re-insert skin procedures view which somehow got dropped and not replaced during a previous update

set search_path = 'clin_procedures';

CREATE VIEW clin_procedures.vwskinprocedures AS
    SELECT skin_procedures.pk AS pk_view, skin_procedures.pk AS fk_skin_procedure, skin_procedures.fk_consult,
     skin_procedures.date, skin_procedures.explained_procedure, skin_procedures.obtained_consent, 
     skin_procedures.detailed_complications, skin_procedures.fk_lu_site, skin_procedures.lesion_notes, 
     skin_procedures.dermoscopy_notes, skin_procedures.fk_lu_lateralisation, skin_procedures.fk_lu_anterior_posterior, 
     skin_procedures.localisation, skin_procedures.surgical_pack_identifier, skin_procedures.fk_lu_skin_preparation, 
     skin_procedures.fk_lu_anaesthetic_agent, skin_procedures.fk_lu_procedure_type, skin_procedures.fk_lu_repair_type, 
     skin_procedures.fk_subcutaneous_suture, skin_procedures.fk_skin_suture, skin_procedures.average_diameter_cm, 
     skin_procedures.fk_provisional_diagnosis, generic_terms.term AS provisional_diagnosis, skin_procedures.fk_document, 
     skin_procedures.fk_actual_diagnosis, generic_terms1.term AS actual_diagnosis, skin_procedures.fk_pasthistory, 
     skin_procedures.referred, skin_procedures.review_months, skin_procedures.fk_branch, skin_procedures.fk_form, 
     skin_procedures.complications, skin_procedures.fk_progressnote_auto, progressnotes.notes AS progressnote_auto, 
     skin_procedures.fk_progressnote_user, progressnotes1.notes AS progressnote_user, consult.consult_date, 
     consult.fk_staff, consult.fk_patient, lu_anatomical_site.site, lu_anterior_posterior.anterior_posterior, 
     lu_laterality.laterality, lu_skin_preparation.preparation, lu_anaesthetic_agent.agent, 
     lu_anaesthetic_agent.fk_lu_route_administration, lu_procedure_type.type AS procedure_type, 
     lu_repair_type.type AS repair_type, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, 
     data_organisations.organisation, vwstaff.wholename, vwstaff.title
     FROM ((((((((((((((((((clin_procedures.skin_procedures JOIN clin_consult.consult ON ((skin_procedures.fk_consult = consult.pk))) 
     JOIN common.lu_anatomical_site ON ((skin_procedures.fk_lu_site = lu_anatomical_site.pk))) 
     LEFT JOIN common.lu_anterior_posterior ON ((skin_procedures.fk_lu_anterior_posterior = lu_anterior_posterior.pk))) 
     LEFT JOIN common.lu_laterality ON ((skin_procedures.fk_lu_lateralisation = lu_laterality.pk))) 
     LEFT JOIN lu_skin_preparation ON ((skin_procedures.fk_lu_skin_preparation = lu_skin_preparation.pk))) 
     LEFT JOIN coding.generic_terms ON ((skin_procedures.fk_provisional_diagnosis = generic_terms.code))) 
     JOIN lu_anaesthetic_agent ON ((skin_procedures.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk))) 
     JOIN lu_procedure_type ON ((skin_procedures.fk_lu_procedure_type = lu_procedure_type.pk))) 
     JOIN lu_repair_type ON ((skin_procedures.fk_lu_repair_type = lu_repair_type.pk))) 
     JOIN lu_suture_type ON ((skin_procedures.fk_skin_suture = lu_suture_type.pk))) 
     JOIN lu_suture_type lu_suture_type1 ON ((skin_procedures.fk_subcutaneous_suture = lu_suture_type1.pk))) 
     LEFT JOIN coding.generic_terms generic_terms1 ON ((skin_procedures.fk_actual_diagnosis = generic_terms1.code))) 
     LEFT JOIN contacts.data_branches ON ((skin_procedures.fk_branch = data_branches.pk))) 
     LEFT JOIN clin_requests.forms ON ((skin_procedures.fk_form = forms.pk)))
      LEFT JOIN clin_consult.progressnotes progressnotes1 ON ((skin_procedures.fk_progressnote_user = progressnotes1.pk))) 
      JOIN clin_consult.progressnotes ON ((skin_procedures.fk_progressnote_auto = progressnotes.pk))) 
      JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) 
      JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) ORDER BY consult.fk_patient;
      
GRANT ALL ON TABLE clin_procedures.vwskinprocedures TO staff;




drop view Contacts.vwOrganisationsByCategory;

create or replace view Contacts.vwOrganisationsByCategory as 
SELECT DISTINCT
  contacts.data_organisations.organisation,
  contacts.data_branches.branch,
  contacts.data_branches.pk AS pk_branch,
  contacts.lu_categories.category,
  contacts.data_branches.fk_organisation
FROM
  contacts.data_branches
  INNER JOIN contacts.data_organisations ON (contacts.data_branches.fk_organisation = contacts.data_organisations.pk)
  INNER JOIN contacts.lu_categories ON (contacts.data_branches.fk_category = contacts.lu_categories.pk)

WHERE data_organisations.deleted = false and data_branches.deleted = false 
  order by category, organisation, branch ;


GRANT ALL ON TABLE Contacts.vwOrganisationsByCategory TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 37);
