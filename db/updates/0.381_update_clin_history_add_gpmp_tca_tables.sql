CREATE TABLE clin_history.lu_allied_health_care_types
(
  pk serial primary key,
  type text NOT NULL
 )
 ;
ALTER TABLE clin_history.lu_allied_health_care_types   OWNER TO easygp;
grant USAGE on SEQUENCE clin_history.lu_allied_health_care_types_pk_seq to staff;
GRANT ALL ON TABLE clin_history.lu_allied_health_care_types TO staff;

COMMENT ON TABLE clin_history.lu_allied_health_care_types
  IS 'The types of allied health care involed e.g in TCA eg dietitian, audiologist';
  
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Aboriginal TSI Worker/Practitioner');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Audiologist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Chiropractor');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Diabetes Educator');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Dietitian');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ('Exercise Physiologist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Mental Health Worker');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Occupational Therapist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Osteopath');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Physiotherapist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Podiatrist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Psychologist');
INSERT INTO clin_history.lu_allied_health_care_types (type) VALUES ( 'Speech Pathologist');

CREATE TABLE clin_history.link_pasthistory_providers
(
  pk serial primary key,
  fk_pasthistory integer NOT NULL,
  fk_branch integer,
  fk_employee integer,
  fk_person integer,
  deleted boolean DEFAULT false,
  contribution_to_plan text,
  CONSTRAINT link_pasthistory_providers_fk_branch_fkey FOREIGN KEY (fk_branch)
      REFERENCES contacts.data_branches (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT link_pasthistory_providers_fk_employee_fkey FOREIGN KEY (fk_employee)
      REFERENCES contacts.data_employees (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT link_pasthistory_providers_fk_pasthistory_fkey FOREIGN KEY (fk_pasthistory)
      REFERENCES clin_history.past_history (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT link_pasthistory_providers_fk_person_fkey FOREIGN KEY (fk_person)
      REFERENCES contacts.data_persons (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_history.link_pasthistory_providers   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.link_pasthistory_providers TO staff;
GRANT ALL ON SEQUENCE clin_history.link_pasthistory_providers_pk_seq to staff;

COMMENT ON TABLE clin_history.link_pasthistory_providers
  IS 'links a past history item to any providers (organisations, employees or persons) 
  who provider services/care to the patient - excluding the GP practice) 
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan or team care arrangements.';

 drop view  clin_history.vwprovidersofcare;
 
CREATE OR REPLACE VIEW clin_history.vwprovidersofcare AS 
         SELECT vwpersonsemployeesbyoccupation.wholename, vwpersonsemployeesbyoccupation.firstname,
         vwpersonsemployeesbyoccupation.street1, vwpersonsemployeesbyoccupation.street2, 
         vwpersonsemployeesbyoccupation.town, vwpersonsemployeesbyoccupation.state, vwpersonsemployeesbyoccupation.postcode, 
         vwpersonsemployeesbyoccupation.occupation, vwpersonsemployeesbyoccupation.organisation, vwpersonsemployeesbyoccupation.branch, 
         link_pasthistory_providers.pk, link_pasthistory_providers.pk AS fk_provider_of_care, link_pasthistory_providers.fk_pasthistory, 
         link_pasthistory_providers.fk_branch, link_pasthistory_providers.fk_employee, link_pasthistory_providers.fk_person,
          link_pasthistory_providers.contribution_to_plan, link_pasthistory_providers.deleted AS provider_deleted, consult.fk_patient
           FROM clin_history.link_pasthistory_providers, contacts.vwpersonsemployeesbyoccupation, clin_history.past_history, clin_consult.consult
          WHERE link_pasthistory_providers.fk_person = vwpersonsemployeesbyoccupation.fk_person 
          AND link_pasthistory_providers.fk_branch IS NULL 
          AND past_history.pk = link_pasthistory_providers.fk_pasthistory 
          AND past_history.fk_consult = consult.pk
UNION 
         SELECT vwpersonsemployeesbyoccupation.wholename, vwpersonsemployeesbyoccupation.firstname, vwpersonsemployeesbyoccupation.street1,
         vwpersonsemployeesbyoccupation.street2, vwpersonsemployeesbyoccupation.town, vwpersonsemployeesbyoccupation.state, 
         vwpersonsemployeesbyoccupation.postcode, vwpersonsemployeesbyoccupation.occupation, vwpersonsemployeesbyoccupation.organisation, 
         vwpersonsemployeesbyoccupation.branch, link_pasthistory_providers.pk, link_pasthistory_providers.pk AS fk_provider_of_care, 
         link_pasthistory_providers.fk_pasthistory, link_pasthistory_providers.fk_branch, link_pasthistory_providers.fk_employee, link_pasthistory_providers.fk_person, 
         link_pasthistory_providers.contribution_to_plan, link_pasthistory_providers.deleted AS provider_deleted, consult.fk_patient
           FROM clin_history.link_pasthistory_providers, contacts.vwpersonsemployeesbyoccupation, clin_history.past_history, clin_consult.consult
          WHERE link_pasthistory_providers.fk_branch = vwpersonsemployeesbyoccupation.fk_branch 
          AND link_pasthistory_providers.fk_employee = vwpersonsemployeesbyoccupation.fk_employee 
          AND past_history.pk = link_pasthistory_providers.fk_pasthistory 
          AND past_history.fk_consult = consult.pk;

ALTER TABLE clin_history.vwprovidersofcare   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwprovidersofcare TO staff;
COMMENT ON VIEW clin_history.vwprovidersofcare
  IS 'A view of all persons or organisations involved in patient care (sans=/minus the GP)';


CREATE TABLE clin_history.gp_management_plans
(
  pk serial primary key,
  fk_consult integer NOT NULL, -- key to cin_consult.consult points to the fk_patient and fk_staff who signed off...
  date_claimed timestamp without time zone NOT NULL, -- the actual date the item number claimed
  explained_steps_involved boolean DEFAULT false,
  patient_agrees_to_plan_and_goals boolean DEFAULT false,
  patient_has_carer boolean DEFAULT false,
  copy_offered_to_patient boolean DEFAULT false,
  patient_permits_carer_to_have_copy boolean DEFAULT false,
  copy_offered_to_carer boolean DEFAULT false,
  review_date date DEFAULT NULL,
  fk_document integer NOT NULL, -- When a General Practitioner management plan is saved, a copy of the LaTeX is kept as...
  latex text DEFAULT NULL, -- copy of the LaTeX of the plan
  deleted boolean DEFAULT false,
  exceptional_circumstances_reason text, -- if not null, then the reason the plan is being done within 12 months must be documented
  fk_progressnote integer default null,
  item_number integer default null,
  CONSTRAINT gp_management_plans_fk_consult_fkey FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT gp_management_plans_fk_document_fkey FOREIGN KEY (fk_document)
      REFERENCES documents.documents (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT gp_management_plans_fk_progressnotes_fkey FOREIGN KEY (fk_progressnote)
      REFERENCES clin_consult.progressnotes (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE clin_history.gp_management_plans   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.gp_management_plans TO staff;
GRANT ALL on SEQUENCE clin_history.gp_management_plans_pk_seq to STAFF;

COMMENT ON TABLE clin_history.gp_management_plans
  IS 'table containing details of AU GP Management Plans 
 These must conform to legislative requirements for item numbers eg 721 and 723';
COMMENT ON COLUMN clin_history.gp_management_plans.fk_consult IS ' key to cin_consult.consult points to the fk_patient and fk_staff who signed off
    the GPMP';
COMMENT ON COLUMN clin_history.gp_management_plans.date_claimed IS 'the actual date the item number claimed can be null if being prepared and not yet finalised (Claimed)';
COMMENT ON COLUMN clin_history.gp_management_plans.fk_document IS 'When a General Practitioner management plan is saved, a copy of the LaTeX is kept as
  a permanant copy in the documents table, i.e a GPMP ''frozen in time''';
COMMENT ON COLUMN clin_history.gp_management_plans.latex IS ' copy of the LaTeX of the plan can be null if not claimed';
COMMENT ON COLUMN clin_history.gp_management_plans.exceptional_circumstances_reason IS 'if not null, then the reason the plan is being done within 12 months must be documented';

comment on column clin_history.gp_management_plans.item_number is 
'the item number, either 721 as initial gpmp or 732 as a review';

CREATE OR REPLACE VIEW clin_history.vwgpmanagementplans AS 
 SELECT consult.consult_date, consult.fk_patient, vwstaff.wholename AS staff_wholename, 
 gp_management_plans.pk, gp_management_plans.pk AS fk_gp_management_plan, gp_management_plans.fk_consult, 
 gp_management_plans.date_claimed, gp_management_plans.explained_steps_involved,
 gp_management_plans.patient_agrees_to_plan_and_goals, gp_management_plans.patient_has_carer, 
 gp_management_plans.copy_offered_to_patient, gp_management_plans.patient_permits_carer_to_have_copy, 
 gp_management_plans.copy_offered_to_carer, gp_management_plans.review_date, gp_management_plans.fk_document, 
 gp_management_plans.latex, gp_management_plans.deleted, gp_management_plans.exceptional_circumstances_reason,
 gp_management_plans.fk_progressnote, gp_management_plans.item_number,
 consult.fk_staff
   FROM clin_history.gp_management_plans, clin_consult.consult, admin.vwstaff
  WHERE gp_management_plans.fk_consult = consult.pk 
  AND consult.fk_staff = vwstaff.fk_staff;

ALTER TABLE clin_history.vwgpmanagementplans   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwgpmanagementplans TO staff;

--drop table clin_history.team_care_arrangements;

CREATE TABLE clin_history.team_care_arrangements
(
  pk serial NOT NULL,
  fk_consult integer NOT NULL,
  date_claimed timestamp without time zone, -- if is null, then the team care arrangment is prepared but not claimed.
  explained_steps_involved boolean DEFAULT false,
  discussed_providers boolean DEFAULT false, -- If True then the GP discussed with the patient who the providers on the team are and their responsibilities
  patient_agrees boolean DEFAULT false, -- If True the the patient agree's to their team care arrangements
  patient_has_carer boolean DEFAULT false,
  copy_offered_to_patient boolean DEFAULT false,
  patient_permits_carer_to_have_copy boolean DEFAULT false,
  copy_offered_to_carer boolean DEFAULT false,
  copy_sent_to_providers boolean DEFAULT false,
  review_date date,
  fk_progressnote integer NOT NULL,
  item_number integer default null,
  CONSTRAINT team_care_arrangements_pkey PRIMARY KEY (pk ),
  CONSTRAINT team_care_arrangements_fk_consult_fkey FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT team_care_arrangements_fk_progressnote_fkey FOREIGN KEY (fk_progressnote)
      REFERENCES clin_consult.progressnotes (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


COMMENT ON TABLE clin_history.team_care_arrangements
  IS 'the team care arrangments for a single episode of 
 claiming Item 721. The LaTex of associated documents is kept in documents.documents
 as well as  copies of the EPC referral form(s) used.
 Note that as a TCA can be a document in progress - nurses could help (heaven forbid) 
 then no field is manditory until the gui enforces a final claim.';
 COMMENT ON COLUMN clin_history.team_care_arrangements.item_number is 
 'if not null is the item number claimed either 723 (new) or 732(review)';
 
COMMENT ON COLUMN clin_history.team_care_arrangements.date_claimed IS 'if is null, then the team care arrangment is prepared but not claimed.';
COMMENT ON COLUMN clin_history.team_care_arrangements.discussed_providers IS 'If True then the GP discussed with the patient who the providers on the team are and their responsibilities';
COMMENT ON COLUMN clin_history.team_care_arrangements.patient_agrees IS 'If True the the patient agree''s to their team care arrangements';

ALTER TABLE clin_history.team_care_arrangements OWNER TO easygp;
GRANT ALL ON TABLE clin_history.team_care_arrangements TO staff;
GRANT ALL ON SEQUENCE  clin_history.team_care_arrangements_pk_seq to staff;

--DROP TABLE clin_history.team_care_members;

CREATE TABLE clin_history.team_care_members
(
  pk serial NOT NULL,
  fk_team_care_arrangement integer NOT NULL,
  fk_branch integer,
  fk_employee integer,
  fk_person integer,
  fk_document_tca integer, -- if not null, then the team_care_arrangement has been finalised and this points to a row in...
  health_issue_keys text, -- the keys of any health issues aka historically as past history or problems...
  family_history_keys text, -- the keys of any family members medical history i.e vwFamilyHistory.pk_view ...
  fk_provider_of_care integer NOT NULL,
  num_epc_sessions integer, -- The number of epc sessions out of 5 available allocated at time of completing the TCA....
  fk_lu_allied_health_care_type integer, -- key to clin_history.lu_allied_health_care_type
  fk_document_allied_health_form integer, -- key to document.documents where link to filename on the filesystem is used for display purposes ...
  latex_allied_health_form text, -- LaTex definition including overpic of the allied health form - kept as a backup as the important...
  fk_document_gp_management_plan integer default null,
  special_note text default null,
  deleted boolean default false,
  CONSTRAINT team_care_members_pkey PRIMARY KEY (pk ),
  CONSTRAINT team_care_members_fk_document_tca_fkey FOREIGN KEY (fk_document_tca)
      REFERENCES documents.documents (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT team_care_members_fk_document_gp_management_plan_fkey FOREIGN KEY (fk_document_gp_management_plan)
      REFERENCES documents.documents (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT team_care_members_fk_lu_allied_health_service_type_fkey FOREIGN KEY (fk_lu_allied_health_care_type)
      REFERENCES clin_history.lu_allied_health_care_types (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT team_care_members_fk_provider_of_care_fkey FOREIGN KEY (fk_provider_of_care)
      REFERENCES clin_history.link_pasthistory_providers (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE clin_history.team_care_members   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.team_care_members TO staff;
GRANT ALL ON SEQUENCE clin_history.team_care_members_pk_seq to staff;

COMMENT ON TABLE clin_history.team_care_members
  IS 'links a team care arrangements with a team care member (aka provider) 
  and the document linked to that team care member';
COMMENT ON COLUMN clin_history.team_care_members.fk_document_tca IS ' if not null, then the team_care_arrangement has been finalised and this points to a row in
  documents.documents containing the latex of the TCA for that member';
COMMENT ON COLUMN clin_history.team_care_members.health_issue_keys IS 'the keys of any health issues aka historically as past history or problems
 the keys correspond to clin_history.past_history.
 As these pipe | delimited keys are only used to reload the listviews in
 FTeamCareMember whilst the team care arrangement is being prepared, they are
 not kept in a form to link to the actual table';
COMMENT ON COLUMN clin_history.team_care_members.family_history_keys IS 'the keys of any family members medical history i.e vwFamilyHistory.pk_view 
 which is actually clin_history.family_conditions.pk
 As these pipe | delimited keys are only used to reload the listviews in
 FTeamCareMember whilst the team care arrangement is being prepared, they are
 not kept in a form to link to the actual table';
COMMENT ON COLUMN clin_history.team_care_members.num_epc_sessions IS ' The number of epc sessions out of 5 available allocated at time of completing the TCA.
  This can be changed by the patient without doing the TCA/EPC form.';
COMMENT ON COLUMN clin_history.team_care_members.fk_lu_allied_health_care_type IS 'key to clin_history.lu_allied_health_care_type';
COMMENT ON COLUMN clin_history.team_care_members.fk_document_allied_health_form IS '
 key to document.documents where link to filename on the filesystem is used for display purposes 
 of the allied health care form, this will be null if there were no epc sessions for that team care member';
COMMENT ON COLUMN clin_history.team_care_members.latex_allied_health_form IS 'LaTex definition including overpic of the allied health form - kept as a backup as the important
 audit document created as a pdf is kept in the filesystem';
comment on column clin_history.team_care_members.fk_document_gp_management_plan is 
'if not null, then the team care member was sent a copy of the gp management plan this field
 being the key to documents.documents hence the LaTex of the plan at the time of the TCA';
COMMENT ON COLUMN clin_history.team_care_members.special_note is 
'any extra comments or special notes user may want to convey to the team care member will be include  in the letter';


CREATE OR REPLACE VIEW clin_history.vwteamcarearrangements AS 
 SELECT consult.fk_patient, team_care_arrangements.pk, team_care_arrangements.pk AS fk_team_care_arrangement, 
 team_care_arrangements.fk_consult, team_care_arrangements.date_claimed, team_care_arrangements.explained_steps_involved,
 team_care_arrangements.discussed_providers, team_care_arrangements.patient_agrees, team_care_arrangements.patient_has_carer, 
 team_care_arrangements.copy_offered_to_patient, team_care_arrangements.patient_permits_carer_to_have_copy, 
 team_care_arrangements.copy_offered_to_carer, team_care_arrangements.copy_sent_to_providers, 
 team_care_arrangements.review_date, team_care_arrangements.fk_progressnote, team_care_arrangements.item_number,
 vwstaff.wholename, vwstaff.title
   FROM clin_history.team_care_arrangements
   JOIN clin_consult.consult ON consult.pk = team_care_arrangements.fk_consult
   JOIN admin.vwstaff ON vwstaff.fk_staff = consult.fk_staff;

ALTER TABLE clin_history.vwteamcarearrangements
  OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwteamcarearrangements TO easygp;
GRANT SELECT ON TABLE clin_history.vwteamcarearrangements TO staff;


 
 
 CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
 SELECT team_care_members.fk_team_care_arrangement, team_care_members.pk, team_care_members.pk AS fk_team_care_member,
 team_care_members.fk_branch, 
 team_care_members.fk_employee, team_care_members.fk_person, team_care_members.fk_document_tca, team_care_members.health_issue_keys, 
 team_care_members.family_history_keys, team_care_members.fk_provider_of_care, team_care_members.num_epc_sessions, 
 team_care_members.fk_lu_allied_health_care_type, team_care_members.fk_document_allied_health_form, 
 team_care_members.latex_allied_health_form,team_care_members.fk_document_gp_management_plan, 
 team_care_members.special_note, team_care_members.deleted,
 lu_allied_health_care_types.type AS allied_health_care_type, 
 documents.source_file AS filename
   FROM clin_history.team_care_members
   LEFT JOIN clin_history.lu_allied_health_care_types ON team_care_members.fk_lu_allied_health_care_type = lu_allied_health_care_types.pk
   LEFT JOIN documents.documents ON team_care_members.fk_document_allied_health_form = documents.pk;

ALTER TABLE clin_history.vwteamcaremembers   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwteamcaremembers TO staff;

update db.lu_version set lu_minor=381;
