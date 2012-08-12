Update clin_requests.lu_requests set item = 'CA 19-9' where item='CA 19.9';
Update clin_requests.lu_requests set item = 'CA 19-9 tumour marker' where item ='CA19.9 tumour marker'; 
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Timed Urine Microalbumin',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Influenza A IgA (EIA)',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Influenza B IgA (EIA)',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'VLDL Cholesterol',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'High Vaginal swab c&s',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Lipids & HDL Cholesterol',0) ;
INSERT INTO clin_requests.lu_requests (fk_lu_request_type,item,fk_laterality) VALUES (1,E'Red blood cell antibody screen',0) ;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 209);

