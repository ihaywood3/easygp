-- initial interim work in modifying clin history in preparation for GPMP + TCA
-- transfers existing data from management_summary field to plan_contribution_gp
-- you'll need to manually fix up each PH item for each Patient before doing care plans
-- the team_care_memers table becomes renames in later sqls as providers_of_care and much laters in another query to  link_pasthistory_providers
alter table clin_history.team_care_members drop column fk_organisation;

alter table clin_history.team_care_members rename column responsibility to contribution_to_plan;

alter table clin_history.team_care_members 
add constraint team_care_members_fk_pasthistory_fkey FOREIGN KEY (fk_pasthistory)
      REFERENCES clin_history.past_history (pk) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table clin_history.team_care_members
 ADD CONSTRAINT team_care_members_fk_branch_fkey FOREIGN KEY (fk_branch)
      REFERENCES contacts.data_branches (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table clin_history.team_care_members
 ADD CONSTRAINT team_care_members_fk_employee_fkey FOREIGN KEY (fk_employee)
      REFERENCES contacts.data_employees (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table clin_history.team_care_members
 ADD CONSTRAINT team_care_members_fk_person_fkey FOREIGN KEY (fk_person)
      REFERENCES contacts.data_persons (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

Alter table clin_history.past_history add column plan_contribution_gp text default null;
Alter table clin_history.past_history add column plan_contribution_patient text default null;
Alter table clin_history.past_history add column plan_contribution_others text default null;

update clin_history.past_history set plan_contribution_gp = management_summary;  --transfer all old data into the new field
-- drop the old field cascades to the clin_history.vwhealthissues
alter table clin_history.past_history drop column management_summary cascade;    


CREATE OR REPLACE VIEW clin_history.vwhealthissues AS 
 SELECT consult.fk_patient, past_history.pk AS pk_pasthistory, past_history.age_onset, 
 past_history.age_onset_units, past_history.description, past_history.fk_laterality, 
 past_history.year_onset, past_history.active, past_history.operation, past_history.cause_of_death,
  past_history.confidential, past_history.major, past_history.deleted, past_history.year_onset_uncertain, 
  past_history.condition_summary, past_history.aim_of_plan, 
  past_history.plan_contribution_gp,past_history.plan_contribution_patient, past_history.plan_contribution_others,
  past_history.risk_factor, past_history.fk_coding_system, past_history.fk_code, past_history.fk_progressnote, 
  lu_systems.system, generic_terms.term, 
  ((generic_terms.term || ' ('::text) || generic_terms.code) || ')'::text AS combined_term_code, 
  generic_terms.active AS code_active, consult.pk AS fk_consult, consult.fk_staff, consult.consult_date AS date_noted,
   data_persons.firstname AS staff_firstname, data_persons.surname AS staff_surname, lu_title.title AS staff_title
   FROM clin_history.past_history
   JOIN clin_consult.consult ON past_history.fk_consult = consult.pk
   LEFT JOIN common.lu_laterality ON past_history.fk_laterality = lu_laterality.pk
   LEFT JOIN coding.lu_systems ON past_history.fk_coding_system = lu_systems.pk
   LEFT JOIN coding.generic_terms ON past_history.fk_code = generic_terms.code
   JOIN admin.staff ON consult.fk_staff = staff.pk
   JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  WHERE past_history.deleted = false
  ORDER BY consult.fk_patient;

ALTER TABLE clin_history.vwhealthissues   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwhealthissues TO easygp;
GRANT SELECT ON TABLE clin_history.vwhealthissues TO staff;

drop view clin_history.vwTeamCareMembers;
Create or replace view clin_history.vwTeamCareMembers as

SELECT 
  vwpersonsemployeesbyoccupation.wholename, 
  vwpersonsemployeesbyoccupation.street1, 
  vwpersonsemployeesbyoccupation.street2, 
  vwpersonsemployeesbyoccupation.town, 
  vwpersonsemployeesbyoccupation.state, 
  vwpersonsemployeesbyoccupation.postcode, 
  vwpersonsemployeesbyoccupation.occupation, 
  vwpersonsemployeesbyoccupation.organisation, 
  vwpersonsemployeesbyoccupation.branch,
  team_care_members.pk,
  team_care_members.pk as fk_team_care_member,
  team_care_members.fk_pasthistory, 
  team_care_members.fk_branch, 
  team_care_members.fk_employee, 
  team_care_members.fk_person, 
  team_care_members.contribution_to_plan,
  consult.fk_patient
FROM 
  clin_history.team_care_members, 
  contacts.vwpersonsemployeesbyoccupation, 
  clin_history.past_history, 
  clin_consult.consult
WHERE 
  team_care_members.fk_person = vwpersonsemployeesbyoccupation.fk_person AND
  team_care_members.fk_branch is null AND
  past_history.pk = team_care_members.fk_pasthistory AND
  past_history.fk_consult = consult.pk
  

  union

  SELECT 
  vwpersonsemployeesbyoccupation.wholename, 
  vwpersonsemployeesbyoccupation.street1, 
  vwpersonsemployeesbyoccupation.street2, 
  vwpersonsemployeesbyoccupation.town, 
  vwpersonsemployeesbyoccupation.state, 
  vwpersonsemployeesbyoccupation.postcode, 
  vwpersonsemployeesbyoccupation.occupation, 
  vwpersonsemployeesbyoccupation.organisation, 
  vwpersonsemployeesbyoccupation.branch,
  team_care_members.pk,
  team_care_members.pk as fk_team_care_member,
  team_care_members.fk_pasthistory, 
  team_care_members.fk_branch, 
  team_care_members.fk_employee, 
  team_care_members.fk_person, 
  team_care_members.contribution_to_plan, 
  consult.fk_patient
FROM 
  clin_history.team_care_members, 
  contacts.vwpersonsemployeesbyoccupation, 
  clin_history.past_history, 
  clin_consult.consult
WHERE 
  team_care_members.fk_branch = vwpersonsemployeesbyoccupation.fk_branch AND
  team_care_members.fk_employee = vwpersonsemployeesbyoccupation.fk_employee AND
  past_history.pk = team_care_members.fk_pasthistory AND
  past_history.fk_consult = consult.pk;


 alter table clin_history.vwTeamCareMembers owner to easygp;
 grant select on clin_history.vwTeamCareMembers to staff;

update db.lu_version set lu_minor=379;
