-- adds new column to allow comment on progress towards the goal when reviewing a TCA

Alter table  clin_history.team_care_members add column progress_towards_goals text default  null;
comment on column clin_history.team_care_members.progress_towards_goals is
 'If not null then this is a TCA_Review and this is the progress towards achieving the goals set out for
  the management of this health issue when patient has been referred to another provider as part of
  their team care arrangements';
  
DROP VIEW  clin_history.vwteamcaremembers;

 CREATE OR REPLACE VIEW clin_history.vwteamcaremembers AS 
 SELECT team_care_members.fk_team_care_arrangement, team_care_members.pk, team_care_members.pk AS fk_team_care_member, 
 team_care_members.fk_branch, team_care_members.fk_employee, team_care_members.fk_person, team_care_members.fk_document_tca, 
 team_care_members.health_issue_keys, team_care_members.family_history_keys, team_care_members.fk_provider_of_care, 
 team_care_members.num_epc_sessions, team_care_members.fk_lu_allied_health_care_type, team_care_members.fk_document_allied_health_form, 
 team_care_members.latex_allied_health_form, team_care_members.fk_document_gp_management_plan, team_care_members.special_note, 
 team_care_members.progress_towards_goals,
 team_care_members.deleted, lu_allied_health_care_types.type AS allied_health_care_type, documents.source_file AS filename
   FROM clin_history.team_care_members
   LEFT JOIN clin_history.lu_allied_health_care_types ON team_care_members.fk_lu_allied_health_care_type = lu_allied_health_care_types.pk
   LEFT JOIN documents.documents ON team_care_members.fk_document_allied_health_form = documents.pk;

ALTER TABLE clin_history.vwteamcaremembers   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwteamcaremembers TO staff;

ALTER TABLE clin_history.vwgpmanagementplans   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwgpmanagementplans TO easygp;
GRANT SELECT ON TABLE clin_history.vwgpmanagementplans TO staff;

update db.lu_version set lu_minor=389;
