-- drop table chronic_disease_management.diabetes_group_allied_health_services cascade;

Create table chronic_disease_management.diabetes_group_allied_health_services
(pk serial primary key,
 fk_consult integer not null,
 confirm_diabetic boolean default false,
 gpmp_new  boolean default false,
 gpmp_review  boolean default false,
 age_care_plan_review  boolean default false,
 latex_form text not null,
 latex_history_items text not null,
 fk_progressnote integer not null,
 fk_document_history_items  integer not null,
 fk_document_form  integer not null,
 health_issue_keys text default null, 
 fk_branch integer default null,
 fk_employee integer default null,
 fk_person integer default null,
 sessions_dietitian integer default null,
 sessions_exercise integer default null,
 sessions_education integer default null,
 include_allergies boolean default true,
 include_medications boolean default true,
 special_notes text default null,
 deleted boolean default false,
CONSTRAINT diabetes_group_allied_health_services_fk_progressnote_fkey FOREIGN KEY (fk_progressnote)
	REFERENCES  clin_consult.progressnotes (pk) MATCH SIMPLE
	 ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT diabetes_group_allied_health_services_fk_consult_fkey FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
      );
      
COMMENT ON TABLE chronic_disease_management.diabetes_group_allied_health_services is
' Contains information about which patient was referred to what provider (organisation/branch or person)
  for what type of service(s)';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.health_issue_keys IS 
'If not null, this field contains | (pipe) delimited keys to a patient''s relevant health issues';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.latex_form is 
'the LaTeX definition of the group alllied  health services form, this is kept as a ''backup'' strictly not needed';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.confirm_diabetic is 
'user has positively affirmed that this patient is diabetic, a medicare requirement';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.gpmp_new  is 
'the doctor has  referred the patient whilst doing a new gp management plan';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.gpmp_review  is 
'the doctor has referred the patient whilst claiming a gp management plan review';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.age_care_plan_review  is 
'the doctor has contributed to or reviewed an aged care facility management plan';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.fk_branch  is 
'key to contacts.data_branches if not null then points to the branch hence the organisation';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.fk_person  is 
'key to contacts.data_persons if not null then points to the person who is a sole trader';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.fk_employee  is 
'key to contacts.data_employees if not null then points to the employee in the branch/organisation who is a sole trader';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.sessions_dietitian  is 
'the number of group sessions allocated to the dietitian';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.sessions_exercise  is 
'the number of group sessions allocated to the exercise physiologist';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.sessions_education  is 
'the number of group sessions allocated to the diabetic educator';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.special_notes  is 
'any extra information to pass on to the provider(s) of diabetic group services';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.include_allergies  is 
'if true then the allergies are included on the information sent to the provider';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.include_medications is 
'if true then the patient''s medications are included on the information sent to the provider';
COMMENT ON COLUMN chronic_disease_management.diabetes_group_allied_health_services.fk_progressnote IS 
'key to clin_consult.progress notes table - points to the progress note summarising the generation of this form during the
 consultation it was written in - used for editing/auditing';

ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services OWNER to easygp;
GRANT ALL ON TABLE chronic_disease_management.diabetes_group_allied_health_services to staff;
update db.lu_version set lu_minor=408;



