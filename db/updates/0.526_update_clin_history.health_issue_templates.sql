-- added a new column as I've shifted the labels in the gui
alter table clin_history.health_issue_templates add column plan text;

comment on column clin_history.health_issue_templates.plan is
'a skeletal plan for a health issue, for example in a patient with solar skin damage it could be for example:
 - To review skin at annual checkups and treat lesions appropriately 
 this was  added as headings in the gui past history/health issues have been  changed';

 update db.lu_version set lu_minor=526;
  