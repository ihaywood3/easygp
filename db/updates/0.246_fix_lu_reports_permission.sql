ALTER TABLE billing.lu_reports OWNER TO easygp;
GRANT ALL ON TABLE billing.lu_reports TO easygp;
GRANT ALL ON TABLE billing.lu_reports TO STAFF;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 246);

