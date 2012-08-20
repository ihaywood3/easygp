INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Kryptopyrroles Urine',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Urine Copper/Creatinine Ratio',0) ;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 214);

