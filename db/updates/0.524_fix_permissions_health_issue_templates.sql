ALTER TABLE clin_history.health_issue_templates   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.health_issue_templates TO easygp;
GRANT ALL ON TABLE clin_history.health_issue_templates TO staff;

update db.lu_version set lu_minor=524;