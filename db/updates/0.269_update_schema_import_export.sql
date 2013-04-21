-- add table containing mis-spelt occupations

SET search_path = import_export, pg_catalog;

Create table import_export.lu_misspelt_occupations 
(pk serial primary key,
 occupation text  not null,
 misspelt_occupation text not null)
 ;
 
ALTER TABLE import_export.lu_misspelt_occupations OWNER TO easygp;
GRANT ALL ON TABLE import_export.lu_misspelt_occupations  TO easygp;
GRANT SELECT, INSERT ON TABLE import_export.lu_misspelt_occupations  TO staff;

INSERT INTO lu_misspelt_occupations VALUES (1, 'orthopaedic surgeon - upper limb', 'orthpaedic surgeon - upper limb');
INSERT INTO lu_misspelt_occupations VALUES (2, 'physical education teacher', 'pe teacher');
INSERT INTO lu_misspelt_occupations VALUES (3, 'clinical psychologist', 'clnical psychologist');
INSERT INTO lu_misspelt_occupations VALUES (4, 'clinical psychologist', 'clincal psychologist');
INSERT INTO lu_misspelt_occupations VALUES (5, 'palliative care registrar', 'paliative care registrar');
INSERT INTO lu_misspelt_occupations VALUES (6, 'house wife', 'housewife');
INSERT INTO lu_misspelt_occupations VALUES (8, 'electrician''s labourer', 'electrian labouer');
INSERT INTO lu_misspelt_occupations VALUES (9, 'disability pensioner', 'disability pension');
INSERT INTO lu_misspelt_occupations VALUES (10, 'administrator', 'adminstrator');
INSERT INTO lu_misspelt_occupations VALUES (7, 'concretor', 'concreter');
INSERT INTO lu_misspelt_occupations VALUES (11, 'draftsman', 'tracer drawing plans');
INSERT INTO lu_misspelt_occupations VALUES (12, 'engineering surveyor', 'engineering survyor');
INSERT INTO lu_misspelt_occupations VALUES (13, 'laboratory analyst', 'laboritory analyst');
INSERT INTO lu_misspelt_occupations VALUES (14, 'physiotherapist', 'physiotherapy');
INSERT INTO lu_misspelt_occupations VALUES (15, 'police officer', 'policer officer');
INSERT INTO lu_misspelt_occupations VALUES (16, 'insurance underwriter', 'insurance under writer');
INSERT INTO lu_misspelt_occupations VALUES (17, 'storeman', 'raaf - stores');
INSERT INTO lu_misspelt_occupations VALUES (18, 'telephonist', 'telphonist');
INSERT INTO lu_misspelt_occupations VALUES (19, 'finance broker', 'finance broker property care');
INSERT INTO lu_misspelt_occupations VALUES (20, 'manufacturer', 'manfacturer');
INSERT INTO lu_misspelt_occupations VALUES (21, 'legal clerk', 'solicitor clerk');
INSERT INTO lu_misspelt_occupations VALUES (22, 'distribution manager', 'distrubution manager');
INSERT INTO lu_misspelt_occupations VALUES (23, 'computer technician', 'pc technician');
INSERT INTO lu_misspelt_occupations VALUES (24, 'fitter and machinist', 'fitter and machinest');
INSERT INTO lu_misspelt_occupations VALUES (25, 'fitter machinist', 'machinist fitter');
INSERT INTO lu_misspelt_occupations VALUES (26, 'special education teacher', 'special ed teacher');
INSERT INTO lu_misspelt_occupations VALUES (27, 'meat salesman', 'meat saleman');
INSERT INTO lu_misspelt_occupations VALUES (28, 'administration manager', 'administrtion manager');
INSERT INTO lu_misspelt_occupations VALUES (29, 'electrician', 'electricion');
INSERT INTO lu_misspelt_occupations VALUES (30, 'project officer', 'natural resource project offic');
INSERT INTO lu_misspelt_occupations VALUES (31, 'office worker', 'part time office work');
INSERT INTO lu_misspelt_occupations VALUES (32, 'post office licensee', 'post office liscencee');
INSERT INTO lu_misspelt_occupations VALUES (33, 'drug representative', 'drug rep');
INSERT INTO lu_misspelt_occupations VALUES (34, 'disability pensioner', 'diability pension');
INSERT INTO lu_misspelt_occupations VALUES (35, 'police officer', 'policer officer security');
INSERT INTO lu_misspelt_occupations VALUES (36, 'medical practitioner', 'medical practioner');
INSERT INTO lu_misspelt_occupations VALUES (37, 'tafe teacher - science', 'teacher - science tafe');
INSERT INTO lu_misspelt_occupations VALUES (38, 'sole parent pensioner', 'sole parent pension');
INSERT INTO lu_misspelt_occupations VALUES (39, 'home duties', 'home duties invalid pension');
INSERT INTO lu_misspelt_occupations VALUES (40, 'school administrator', 'school adminstration');
INSERT INTO lu_misspelt_occupations VALUES (41, 'cartoon character', 'cartton character');
INSERT INTO lu_misspelt_occupations VALUES (42, 'rehabilitation consultant', 'rehab consultant');
INSERT INTO lu_misspelt_occupations VALUES (43, 'forklift driver', 'fork lift driver');
INSERT INTO lu_misspelt_occupations VALUES (44, 'asphalt contractor', 'asphelt contractor');
INSERT INTO lu_misspelt_occupations VALUES (45, 'tyre retailer', 'tyre retailor');
INSERT INTO lu_misspelt_occupations VALUES (46, 'trainer advisor', 'tainer advisor');
INSERT INTO lu_misspelt_occupations VALUES (47, 'ambulance officer', 'amblance officer');
INSERT INTO lu_misspelt_occupations VALUES (48, 'machinist', 'machinest');
INSERT INTO lu_misspelt_occupations VALUES (49, 'clerk', 'clerk at bhp');
INSERT INTO lu_misspelt_occupations VALUES (50, 'restaurant worker', 'part time restuarant worker');
INSERT INTO lu_misspelt_occupations VALUES (51, 'maintenence supervisor', 'maintainence supervisor');
INSERT INTO lu_misspelt_occupations VALUES (52, 'window dresser', 'window dressor');
INSERT INTO lu_misspelt_occupations VALUES (53, 'teacher - high school', 'teacher- high school');
INSERT INTO lu_misspelt_occupations VALUES (54, 'gardener', 'gardiner');

SELECT pg_catalog.setval('lu_misspelt_occupations_pk_seq', 54, true);

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 269);

