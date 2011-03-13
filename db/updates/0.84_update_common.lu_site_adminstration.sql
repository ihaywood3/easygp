-- adds laterality to sites.


SET search_path = common, pg_catalog;

alter TABLE lu_site_administration add column
  has_laterality boolean DEFAULT true;

Delete from lu_site_administration;

SELECT pg_catalog.setval('lu_site_administration_pk_seq', 10, true);

INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (1, 'thigh (imi)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (2, 'deltoid (imi)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (3, 'ventrogluteal (imi)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (4, 'thigh (scut)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (6, 'ventrogluteal (scut)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (7, 'abdo wall  (scut)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (9, 'intra-nasal', false);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (5, 'deltoid (scut)', true);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (8, 'oral', false);
INSERT INTO lu_site_administration (pk, site, has_laterality) VALUES (10, 'unkown', false);


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 84);

