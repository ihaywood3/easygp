-- new request names
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Vitamin B6',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Vulval swab c&s',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Low vaginal swab c&s',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Sweat conductivity',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'RAST - Latex',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Virus Culture',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Red Cell Antibody Screen',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Parvovirus',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'EBV',0) ;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 213);

