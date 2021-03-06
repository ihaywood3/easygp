
ALTER TABLE "admin".global_preferences OWNER TO easygp;
GRANT SELECT ON TABLE  "admin".global_preferences TO staff;
GRANT ALL ON TABLE "admin".global_preferences TO easygp;

GRANT ALL ON SCHEMA import_export TO easygp;
GRANT USAGE ON SCHEMA import_export TO staff;

ALTER TABLE import_export.vwdemographictemplates OWNER TO easygp;
GRANT ALL ON import_export.vwdemographictemplates to easygp;
GRANT ALL ON import_export.vwdemographictemplates to staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 45);