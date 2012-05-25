-- drop redundant view

drop view clin_requests.vwrequestsordered;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 154);

