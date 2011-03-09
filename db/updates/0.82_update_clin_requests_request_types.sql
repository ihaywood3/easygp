insert into clin_requests.lu_request_type (type) values ('ophthalmology');


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 82);
