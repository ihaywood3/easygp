GRANT ALL ON TABLE clin_measurements.lu_reason_anticoagulant_use TO staff;
GRANT ALL ON TABLE clin_measurements.inr_plan TO staff;
GRANT ALL ON TABLE clin_measurements.inr_dose_management TO staff;
GRANT ALL ON TABLE documents.observations TO staff;


-- Table: clin_consult.lu_shortcut

-- DROP TABLE clin_consult.lu_shortcut;

CREATE TABLE clin_consult.lu_shortcut
(
  pk serial NOT NULL,
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
COMMENT ON COLUMN clin_consult.lu_shortcut.shortcut IS 'the shortcut that triggers the text expansion';
COMMENT ON COLUMN clin_consult.lu_shortcut.expanded IS 'the text the shortcut will get expanded to. Any htnl code is valid, including embedded images';



-- Table: clin_consult.shortcuts_user

-- DROP TABLE clin_consult.shortcuts_user;

CREATE TABLE clin_consult.shortcuts_user
(
-- Inherited from table clin_consult.lu_shortcut:  pk integer NOT NULL DEFAULT nextval('clin_consult.lu_shortcut_pk_seq'::regclass),
-- Inherited from table clin_consult.lu_shortcut:  shortcut text,
-- Inherited from table clin_consult.lu_shortcut:  expanded text,
  fk_staff integer, -- if true, the shortcut will be shared with other users
  shared boolean DEFAULT false,
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