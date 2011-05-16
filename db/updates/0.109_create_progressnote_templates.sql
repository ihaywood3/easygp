-- table to allow staff to save templates for consulations

CREATE TABLE clin_consult.lu_progressnote_templates
(
  pk serial primary key,
  fk_staff integer not null,
  shared boolean default false,
  "name" text NOT NULL,
  deleted boolean DEFAULT false,
  "template" text NOT NULL);

  
ALTER TABLE clin_consult.lu_progressnote_templates OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.lu_progressnote_templates TO easygp;
GRANT ALL ON TABLE clin_consult.lu_progressnote_templates TO staff;
COMMENT ON TABLE clin_consult.lu_progressnote_templates IS 'Table to hold templates for progress notes';
COMMENT ON COLUMN clin_consult.lu_progressnote_templates."template" IS 'html for a letter template';
COMMENT ON COLUMN clin_consult.lu_progressnote_templates.shared is 'if true then anyone can access this template';
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 109);

