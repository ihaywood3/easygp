--drop table clin_history.health_issue_templates;

Create table clin_history.health_issue_templates
(pk serial primary key,
 fk_staff integer not null,
 shared boolean default false,	
 keywords text not null,
 fk_code text not null,
  deleted boolean DEFAULT false,
  risk_factor boolean DEFAULT false,
  aim_of_plan text,
  plan_contribution_gp text,
  plan_contribution_patient text,
 CONSTRAINT health_issue_templates_fk_staff_fkey FOREIGN KEY(fk_staff)
	REFERENCES admin.staff (pk) 	MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
  --CONSTRAINT health_issue_templates_fk_code_exists FOREIGN KEY (fk_code)
  --CHECK(fk_code = coding.generic_terms.code)
  
);

alter table clin_history.health_issue_templates owner to EasyGP;
grant all on table clin_history.health_issue_templates to staff;
grant all on sequence clin_history.health_issue_templates_pk_seq to staff;

COMMENT ON TABLE clin_history.health_issue_templates IS
'A table which links either a coded term or a keyword to information needed in care planning e.g
 a GP Management Plan
 e.g keywords = diabetes|niddm|adult onset diabetes
     code =  T90002 (Diabetes mellitus)';
 COMMENT ON COLUMN clin_history.health_issue_templates.fk_staff is
 'key to admin.staff table = staff member who has created this template';
 COMMENT ON COLUMN clin_history.health_issue_templates.fk_code is
 'key to coding.generic_terms, the code could be icd10 or icpc2Plus';
 COMMENT ON COLUMN clin_history.health_issue_templates.deleted is 
 'If true then this template is marked as deleted';
 COMMENT ON COLUMN clin_history.health_issue_templates.aim_of_plan is 
 'The aim or goals for any plan which is looking after the patient';
 
update db.lu_version set lu_minor=386; 