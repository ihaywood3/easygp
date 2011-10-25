-- after much deliberation I decided this needs a unique category

insert into clin_requests.lu_request_type(type) values ('Exercise Physiology');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 131);
