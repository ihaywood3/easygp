insert into clin_requests.lu_request_type (type) values('gastroenterology');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 110);