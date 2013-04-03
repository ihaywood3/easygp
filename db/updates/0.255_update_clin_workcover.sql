
alter table clin_workcover.claims add column date_first_seen date default null;
comment on column clin_workcover.claims.date_first_seen is
'the day on which the patient was first seen for this workcover injury';
alter table clin_workcover.visits add column review_comments text default null;
comment on column clin_workcover.visits.review_comments is
'If the review date is over 28 days must describe why';

alter table clin_workcover.claims  add column preexisting_factors text default null;
comment on column clin_workcover.claims.preexisting_factors is
'any  pre-existing factors relevant to this workcover injury';

alter table clin_workcover.visits  add column referrals_other_providers text default null;
comment on column clin_workcover.visits.referrals_other_providers is
'details of referrals to other health providers including
 provider details, service requested, duration and frequency of service';

alter table clin_workcover.visits add column time_return_any_duties text default null;
alter table clin_workcover.visits add column factors_delaying_return text default null;

alter table clin_workcover.visits add column copy_of_duties boolean default false;

alter table clin_workcover.visits add column refer_rehab_provider boolean default false;
comment on column clin_workcover.visits.refer_rehab_provider is
'If true then the patient on this visit needs referral to a rehabilitation provider';

alter table clin_workcover.visits add column capacity_lifting_carrying text default null;
alter table clin_workcover.visits add column capacity_sitting_tolerance text default null;
alter table clin_workcover.visits add column capacity_standing_tolerance text default null;
alter table clin_workcover.visits add column capacity_pushing_pulling text default null;
alter table clin_workcover.visits add column capacity_bend_twist_squat text default null;
alter table clin_workcover.visits add column capacity_driving text default null;
alter table clin_workcover.visits add column capacity_other text default null;

alter table clin_workcover.claims add column consistant_with_cause integer default 0;
comment on column clin_workcover.claims.consistant_with_cause is
'0=consistant 1=not consistant 2=uncertain';
update clin_workcover.claims set consistant_with_cause = 0;

drop view clin_workcover.vwWorkcover;

CREATE OR REPLACE VIEW clin_workcover.vwworkcover AS 
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, 
 consult1.consult_date AS start_date, consult.consult_date AS visit_date, 
 consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, 
 claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, 
 claims.contact_person, claims.memo, claims.identifier, claims.fk_person, 
 claims.accepted, claims.deleted AS claim_deleted, claims.date_first_seen, 
 claims.preexisting_factors, claims.consistant_with_cause, consult.fk_staff, 
 consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, 
 vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, 
 vwstaff.title AS staff_title, lu_occupations.occupation, vworganisations.branch, 
 vworganisations.fk_organisation, vworganisations.organisation, 
 vworganisations.street1 AS branch_street1, vworganisations.street2 AS branch_street2, 
 vworganisations.town AS branch_town, vworganisations.branch_deleted, 
 vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, 
 vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, 
 vwpersons.town AS soletrader_town, vwpersons.street1 AS soletrader_street1, 
 vwpersons.street2 AS soletrader_street2, vwpersons.postcode AS soletrader_postcode, 
 vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, 
 visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.certificate_date, visits.management_plan, visits.review_date, 
visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, 
visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, 
visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, 
visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, 
visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, 
visits.latex, visits.deleted AS visit_deleted, visits.time_return_any_duties, 
visits.factors_delaying_return, visits.referrals_other_providers, visits.copy_of_duties, 
visits.refer_rehab_provider, visits.capacity_lifting_carrying, visits.capacity_sitting_tolerance, 
visits.capacity_standing_tolerance, visits.capacity_pushing_pulling, visits.capacity_bend_twist_squat, 
visits.capacity_driving, visits.capacity_other, lu_caused_by_employment.caused_by_employment, 
visits.review_comments,
consult1.pk AS fk_consult_claim
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
   JOIN clin_consult.consult consult1 ON claims.fk_consult = consult1.pk;

ALTER TABLE clin_workcover.vwworkcover OWNER TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO easygp;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 255);

