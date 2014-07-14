-- renamed this old table because once started doing team care arrangements
-- the meaning was wrong. Patient could have many providers of care but
-- not all in this table are involved in team care arrangements so I later
-- constructed a totally new table of the same name clin_history.team_care_members
alter table clin_history.team_care_members rename to providers_of_care;
alter table clin_history.providers_of_care drop constraint team_care_members_pkey;
alter sequence clin_history.team_care_members_pk_seq rename to providers_of_care_pk_seq;
alter table clin_history.providers_of_care add constraint  providers_of_care_pkey PRIMARY KEY (pk);
-- fix me drop all the other named constraints

alter table clin_history.providers_of_care drop constraint  team_care_members_fk_branch_fkey;
alter table clin_history.providers_of_care 
ADD CONSTRAINT providers_of_care_fk_branch_fkey FOREIGN KEY (fk_branch)
      REFERENCES contacts.data_branches (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
alter table clin_history.providers_of_care drop constraint    team_care_members_fk_employee_fkey;  
alter table clin_history.providers_of_care 
ADD   CONSTRAINT providers_of_care_fk_employee_fkey FOREIGN KEY (fk_employee)
      REFERENCES contacts.data_employees (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
 alter table clin_history.providers_of_care drop constraint  team_care_members_fk_person_fkey; 
alter table clin_history.providers_of_care 
ADD   CONSTRAINT providers_of_care_fk_person_fkey FOREIGN KEY (fk_person)
      REFERENCES contacts.data_persons (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table clin_history.providers_of_care drop constraint  team_care_members_fk_pasthistory_fkey;
alter table clin_history.providers_of_care 
ADD CONSTRAINT providers_of_care_fk_pasthistory_fkey FOREIGN KEY (fk_pasthistory)
      REFERENCES clin_history.past_history (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
COMMENT ON TABLE clin_history.providers_of_care
  IS 'links a past history item to any providers (organisations, employees or persons) 
  who provider services/care to the patient - excluding the GP practice) 
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan or team care arrangements.';


CREATE OR REPLACE VIEW clin_history.vwProvidersOfCare AS 
         SELECT vwpersonsemployeesbyoccupation.wholename, vwpersonsemployeesbyoccupation.street1, 
         vwpersonsemployeesbyoccupation.street2, vwpersonsemployeesbyoccupation.town, 
         vwpersonsemployeesbyoccupation.state, vwpersonsemployeesbyoccupation.postcode, 
         vwpersonsemployeesbyoccupation.occupation, vwpersonsemployeesbyoccupation.organisation, 
         vwpersonsemployeesbyoccupation.branch, 
         providers_of_care.pk, providers_of_care.pk AS fk_provider_of_care, 
         providers_of_care.fk_pasthistory, providers_of_care.fk_branch, 
         providers_of_care.fk_employee, providers_of_care.fk_person, providers_of_care.contribution_to_plan, 
         consult.fk_patient
           FROM clin_history.providers_of_care, contacts.vwpersonsemployeesbyoccupation, clin_history.past_history, clin_consult.consult
          WHERE providers_of_care.fk_person = vwpersonsemployeesbyoccupation.fk_person AND 
          providers_of_care.fk_branch IS NULL AND 
          past_history.pk = providers_of_care.fk_pasthistory AND
          past_history.fk_consult = consult.pk
UNION 
         SELECT vwpersonsemployeesbyoccupation.wholename, vwpersonsemployeesbyoccupation.street1, 
         vwpersonsemployeesbyoccupation.street2, vwpersonsemployeesbyoccupation.town, 
         vwpersonsemployeesbyoccupation.state, vwpersonsemployeesbyoccupation.postcode, 
         vwpersonsemployeesbyoccupation.occupation, vwpersonsemployeesbyoccupation.organisation, 
         vwpersonsemployeesbyoccupation.branch, 
         providers_of_care.pk, providers_of_care.pk AS fk_provider_of_care, 
         providers_of_care.fk_pasthistory, providers_of_care.fk_branch, providers_of_care.fk_employee, 
         providers_of_care.fk_person, providers_of_care.contribution_to_plan, consult.fk_patient
           FROM clin_history.providers_of_care, contacts.vwpersonsemployeesbyoccupation, clin_history.past_history, clin_consult.consult
          WHERE providers_of_care.fk_branch = vwpersonsemployeesbyoccupation.fk_branch AND
           providers_of_care.fk_employee = vwpersonsemployeesbyoccupation.fk_employee AND
            past_history.pk = providers_of_care.fk_pasthistory AND 
            past_history.fk_consult = consult.pk;

ALTER TABLE clin_history.vwProvidersOfCare   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwProvidersOfCare TO easygp;
GRANT SELECT ON TABLE clin_history.vwProvidersOfCare TO staff;

COMMENT ON VIEW clin_history.vwProvidersOfCare is 'A view of all persons or organisations involved in patient care (sans/minus the GP)';

-- clean up historical tables and views no longer used
DROP VIEW clin_history.vwteamcaremembers;
DROP VIEW clin_history.vwcareplancomponents;
DROP VIEW clin_history.vwcareplancomponentsdue;
DROP TABLE clin_history.care_plan_components;
DROP TABLE clin_history.care_plan_components_due;
DROP TABLE clin_history.lu_careplan_components;

update db.lu_version set lu_minor=380;