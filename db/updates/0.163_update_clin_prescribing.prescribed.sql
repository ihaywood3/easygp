alter table clin_prescribing.prescribed add column printed boolean default true;

COMMENT ON COLUMN 	clin_prescribing.prescribed.printed is 
'if the script was actually printed then printed is true, i.e when the menu option saved no print is used field is false';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 163);
