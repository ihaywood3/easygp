-- update various permissions
GRANT SElECT ON common.vwrecreationaldrugs TO Staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 272);

