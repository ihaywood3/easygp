GRANT ALL ON TABLE clin_measurements.lu_reason_anticoagulant_use TO staff;
GRANT ALL ON TABLE clin_measurements.inr_plan TO staff;
GRANT ALL ON TABLE clin_measurements.inr_dose_management TO staff;
GRANT ALL ON TABLE documents.observations TO staff;


-- Table: clin_consult.lu_shortcut

-- DROP TABLE clin_consult.lu_shortcut;

CREATE TABLE clin_consult.lu_shortcut
(
  pk serial NOT NULL,
  fk_staff integer default NULL,
  shared boolean default False,
  shortcut text, -- the shortcut that triggers the text expansion
  expanded text, -- the text the shortcut will get expanded to. Any htnl code is valid, including embedded images
  CONSTRAINT lu_shortcut_pkey PRIMARY KEY (pk),
  CONSTRAINT lu_shortcut_shortcut_key UNIQUE (shortcut)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_consult.lu_shortcut
  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.lu_shortcut TO easygp;
GRANT ALL ON TABLE clin_consult.lu_shortcut TO staff;
COMMENT ON TABLE clin_consult.lu_shortcut
  IS 'System wide shortcuts that the editor will expand to a longer text sequence';
COMMENT ON COLUMN clin_consult.lu_shortcut.fk_staff IS 'Use only in inherited table - necessary to allow exporting lu_* data without contaminatin from user data';
COMMENT ON COLUMN clin_consult.lu_shortcut.shortcut IS 'the shortcut that triggers the text expansion';
COMMENT ON COLUMN clin_consult.lu_shortcut.expanded IS 'the text the shortcut will get expanded to. Any htnl code is valid, including embedded images';


INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.sr','<b>System Review:<b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.ps','<b>Presenting Symptoms:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.oe','<b>On Examination:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.dx','<b>Diagnosis:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.pl','<b>Plan</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.pc','<b>Patient Concerns:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.rx','<b>Scripts:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.wc','<b>Workcover Notes:</b><br>');
INSERT INTO clin_consult.lu_shortcut(shortcut, expanded) values('.rr','<b>Review of Results:</b><br>');



-- Table: clin_consult.shortcuts_user

-- DROP TABLE clin_consult.shortcuts_user;

CREATE TABLE clin_consult.shortcuts_user
(
  CONSTRAINT shortcuts_user_fk_staff_fkey FOREIGN KEY (fk_staff)
      REFERENCES admin.staff (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT shortcuts_user_shortcut_fk_staff_key UNIQUE (shortcut, fk_staff)
)
INHERITS (clin_consult.lu_shortcut)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_consult.shortcuts_user
  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.shortcuts_user TO easygp;
GRANT ALL ON TABLE clin_consult.shortcuts_user TO staff;
COMMENT ON TABLE clin_consult.shortcuts_user
  IS 'User specific editable shortcuts that the editor will expand to a longer text sequence';
COMMENT ON COLUMN clin_consult.shortcuts_user.fk_staff IS 'if true, the shortcut will be shared with other users';

truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 323);