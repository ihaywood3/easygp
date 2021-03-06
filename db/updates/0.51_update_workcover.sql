-- I found that I needed to be able to date a workcover cerficate <> now()
-- so needed another textbox and database field

Alter table  clin_workcover.visits add column certificate_date date;

Comment on column clin_workcover.visits.certificate_date is
'The certificate date, usually now() but sometimes needs to be backdated, for example if
 replacing a paper certificate with an electronic one when copy needed';
 
 -- update the data fields
 
update clin_workcover.visits set certificate_date = (select visit_date from clin_workcover.vwWorkcover
where clin_workcover.vwWorkcover.fk_visit = clin_workcover.visits.pk);

drop view clin_workcover.vwWorkcover;

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, 
 consult.consult_date AS visit_date, 
 consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, consult.fk_staff, consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, vwstaff.provider_number, lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, vworganisations.street AS branch_street, vworganisations.town AS branch_town, vworganisations.branch_deleted, vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, vwpersons.town AS soletrader_town, vwpersons.street AS soletrader_street, vwpersons.postcode AS soletrader_postcode, vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, 
  visits.certificate_date,
        visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, lu_caused_by_employment.caused_by_employment
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_workcover.visits ON visits.fk_consult = consult.pk
   JOIN clin_workcover.claims ON claims.pk = visits.fk_claim
   JOIN common.lu_occupations ON claims.fk_occupation = lu_occupations.pk
   LEFT JOIN coding.lu_systems ON visits.fk_coding_system = lu_systems.pk
   LEFT JOIN contacts.vworganisations ON claims.fk_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersons ON claims.fk_person = vwpersons.fk_person
   JOIN clin_workcover.lu_visit_type ON visits.fk_lu_visit_type = lu_visit_type.pk
   JOIN clin_workcover.lu_caused_by_employment ON visits.fk_caused_by_employment = lu_caused_by_employment.pk
   JOIN clin_consult.consult consult1 ON claims.fk_consult = consult1.pk
  ORDER BY visits.fk_claim, visits.pk;

GRANT select ON TABLE clin_workcover.vwworkcover TO staff;
COMMENT ON VIEW clin_workcover.vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';

  truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 51)
