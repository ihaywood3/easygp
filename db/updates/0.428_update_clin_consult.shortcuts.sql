-- delete shortcut user

-- drop table clin_consult.shortcuts_user cascade;

CREATE TABLE clin_consult.shortcuts_user_temp
(
  pk serial primary key,
  fk_staff integer not null references admin.staff (pk),
  shared boolean   DEFAULT false,
  shortcut text not null, -- the shortcut that triggers the text expansion
  expanded text not null, -- the text the shortcut will get expanded to. Any htnl code is valid, including embedded images
  fk_lu_shortcut_category integer NOT NULL references clin_consult.lu_shortcut_category
 )
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_consult.shortcuts_user_temp   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.shortcuts_user_temp TO staff;

COMMENT ON TABLE clin_consult.shortcuts_user_temp   IS 'user unique shortcuts that the editor will expand to a longer text sequence';
COMMENT ON COLUMN clin_consult.shortcuts_user_temp.shortcut IS 'the shortcut that triggers the text expansion';
COMMENT ON COLUMN clin_consult.shortcuts_user_temp.expanded IS 'the text the shortcut will get expanded to. Any htnl code is valid, including embedded images';


--insert into clin_consult.shortcuts_user_temp (fk_staff, shared, shortcut, expanded, fk_lu_shortcut_category) 
-- select fk_staff, shared, shortcut, expanded, fk_lu_shortcut_category from clin_consult.lu_shortcut where fk_staff is not null;

--delete from  clin_consult.lu_shortcut where fk_staff is not null;

--alter table clin_consult.lu_shortcut drop column fk_staff cascade;

drop table clin_consult.shortcuts_user cascade;

alter table clin_consult.shortcuts_user_temp rename to   shortcuts_user;


DROP VIEW clin_consult.vwshortcuts;

CREATE OR REPLACE VIEW clin_consult.vwshortcuts AS 
 SELECT 
    lu_shortcut.pk::text as pk_view,
    lu_shortcut.pk AS fk_shortcut,
    lu_shortcut.shared,
    lu_shortcut.shortcut,
    lu_shortcut.expanded,
    lu_shortcut.fk_lu_shortcut_category,
    lu_shortcut_category.category,
    NULL::integer AS fk_staff
   FROM clin_consult.lu_shortcut
     JOIN clin_consult.lu_shortcut_category ON lu_shortcut_category.pk = lu_shortcut.fk_lu_shortcut_category
UNION
 SELECT 
    (shortcuts_user.pk || '-'::text) || fk_staff as pk_view,
    shortcuts_user.pk AS fk_shortcut,
    shortcuts_user.shared,
    shortcuts_user.shortcut,
    shortcuts_user.expanded,
    shortcuts_user.fk_lu_shortcut_category,
    lu_shortcut_category.category,
    shortcuts_user.fk_staff
   FROM clin_consult.shortcuts_user
     JOIN clin_consult.lu_shortcut_category ON lu_shortcut_category.pk = shortcuts_user.fk_lu_shortcut_category;

ALTER TABLE clin_consult.vwshortcuts   OWNER TO easygp;
GRANT SELECT ON TABLE clin_consult.vwshortcuts TO staff;

--update db.lu_version set lu_minor=428;
