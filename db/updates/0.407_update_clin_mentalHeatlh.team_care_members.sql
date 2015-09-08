-- bugfix where these fields were inadvertantly being set to 0 by the gambas code
-- this meant that on editing, persons where were not patients were not showing up in the gui.
ALTER TABLE clin_mentalhealth.team_care_members alter column fk_organisation set default null;
ALTER TABLE clin_mentalhealth.team_care_members alter column fk_branch set default null;
ALTER TABLE clin_mentalhealth.team_care_members alter column fk_employee set default null;

update clin_mentalhealth.team_care_members  set fk_organisation=null where fk_organisation=0;
update clin_mentalhealth.team_care_members  set fk_branch=null where fk_branch=0;
update clin_mentalhealth.team_care_members  set fk_employee=null where fk_employee=0;

update db.lu_version set lu_minor=407;