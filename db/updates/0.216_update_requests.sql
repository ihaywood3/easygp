INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Perineal Swab c&s',0) ;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 216);
