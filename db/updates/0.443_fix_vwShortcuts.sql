ALTER TABLE clin_consult.lu_shortcut ADD COLUMN deleted boolean default false;
update clin_consult.lu_shortcut set deleted = False;
ALTER TABLE clin_consult.shortcuts_user ADD COLUMN deleted boolean default false;
update clin_consult.shortcuts_user set deleted = False;

-- View: clin_consult.vwshortcuts
DROP VIEW clin_consult.vwshortcuts;

CREATE OR REPLACE VIEW clin_consult.vwshortcuts AS 
 SELECT 
    lu_shortcut.pk::text as pk_view,
    lu_shortcut.pk AS fk_shortcut,
    lu_shortcut.shared,
    lu_shortcut.shortcut,
    lu_shortcut.expanded,
    lu_shortcut.deleted,
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
    shortcuts_user.deleted,
    shortcuts_user.fk_lu_shortcut_category,
    lu_shortcut_category.category,
    shortcuts_user.fk_staff
   FROM clin_consult.shortcuts_user
     JOIN clin_consult.lu_shortcut_category ON lu_shortcut_category.pk = shortcuts_user.fk_lu_shortcut_category;

ALTER TABLE clin_consult.vwshortcuts   OWNER TO easygp;
GRANT SELECT ON TABLE clin_consult.vwshortcuts TO staff;

update db.lu_version set lu_minor = 443;