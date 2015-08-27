alter table clin_consult.lu_progressnote_templates add column code text default null;
COMMENT ON COLUMN clin_consult.lu_progressnote_templates.code is
	'if not null, key to coding.generic_terms table. This code can be used to auto-code consultations where a template is used
	 for example annual checkup > check up;adult health complete';
	 
alter table clin_consult.lu_progressnote_templates add column auto_code_consult boolean default false;
COMMENT ON COLUMN clin_consult.lu_progressnote_templates.auto_code_consult is 
	'if True then when a template is chosen the consultation will be auto coded if a template is coded (has an fk_code)';
	
Create or replace view clin_consult.vwProgressNotesTemplates as
SELECT 
  lu_progressnote_templates.pk, 
  lu_progressnote_templates.fk_staff, 
  lu_progressnote_templates.shared, 
  lu_progressnote_templates.name, 
  lu_progressnote_templates.deleted, 
  lu_progressnote_templates.template, 
  lu_progressnote_templates.code, 
  lu_progressnote_templates.auto_code_consult, 
  generic_terms.term,
  generic_terms.fk_coding_system
  FROM clin_consult.lu_progressnote_templates
  LEFT JOIN   coding.generic_terms ON  lu_progressnote_templates.code = generic_terms.code
  ;
  
  ALTER TABLE clin_consult.vwProgressNotesTemplates OWNER TO easygp;
  GRANT SELECT ON clin_consult.vwProgressNotesTemplates to staff;

  update db.lu_version set lu_minor=405;