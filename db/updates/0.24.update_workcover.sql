--modifications to view as result of now using latex.
--no longer need form_html
--design change included new field to visits 'capabilities' include this in view

ALTER TABLE clin_workcover.visits add column capabilities text  default null;
ALTER TABLE clin_workcover.visits DROP COLUMN form_html;

DROP VIEW clin_workcover.vwworkcover;

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_visit, consult1.consult_date AS visit_date, consult.consult_date AS start_date, 
 claims.identifier, claims.accepted, consult.fk_patient, visits.fk_claim, visits.fk_lu_visit_type, 
 visits.diagnosis, visits.fk_coding_system, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.fk_progressnote, visits.management_plan, visits.review_date, 
        visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.capabilities, visits.fk_caused_by_employment, 
        lu_caused_by_employment.caused_by_employment, visits.doctor_consented, visits.worker_consented, 
        visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, 
        visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult AS fk_consult_visit, 
        claims.fk_consult AS fk_consult_claim, claims.claim_number, claims.fk_occupation, claims.fk_branch, 
        claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, 
        claims.memo, consult.fk_staff AS fk_doctor, lu_occupations.occupation, data_persons.firstname AS doctor_firstname, data_persons.surname AS doctor_surname, lu_title.title AS doctor_title, lu_sex.sex AS doctor_sex, lu_visit_type.type AS visit_type, data_branches.branch, lu_categories.category AS branch_category, data_organisations.organisation, data_organisations.pk AS fk_organisation, data_addresses.pk AS fk_address, data_addresses.street, data_addresses.fk_town, data_addresses.address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_staff_roles.role AS staff_role
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
  ORDER BY consult.fk_patient, consult.consult_date, consult1.consult_date;

GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 24);

