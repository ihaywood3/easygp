-- changed the name of this because I realised a database dump will then not get the lookup table data.
-- all lookup tables must start with lu_name

drop  TABLE "admin".clinical_modules cascade;
-- cascades to vwStafftoolbarButtons

SET search_path = admin, pg_catalog;

CREATE TABLE "admin".lu_clinical_modules
(
  pk serial primary key,
  "name" text NOT NULL,
  icon_path text not null
);
ALTER TABLE "admin".lu_clinical_modules OWNER TO easygp;
GRANT ALL ON TABLE "admin".lu_clinical_modules TO easygp;
GRANT ALL ON TABLE "admin".lu_clinical_modules TO staff;
COMMENT ON TABLE "admin".lu_clinical_modules IS 'modules which could be available clinically';

SELECT pg_catalog.setval('lu_clinical_modules_pk_seq', 17, true);

INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (1, 'Health Issues', 'icons/16/pasthistory_1616.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (2, 'Requests', 'icons/16/bloodtube16x16.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (3, 'Referrals', 'icons/16/referrals_3_1616.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (4, 'Scripts', 'icons/20/pill2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (5, 'Recalls', 'icons/16/boomerang1616.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (6, 'Travel', 'icons/16/airplane.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (7, 'Mental Health', 'icons/20/smiley2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (8, 'Workcover', 'icons/20/workcover2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (9, 'Occupational History', 'icon:/small/tools');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (10, 'Family History', 'icons/20/kde_family2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (11, 'Vaccinations', 'icons/20/syringe2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (12, 'Pregnancy', 'icons/20/pregnancy.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (13, 'Allergy', 'icons/20/allergy2020.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (14, 'Skin Excision', 'icons/24/glove-scalple_2424.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (15, 'Diabetes Cycle of Care', 'icons/20/united_nations_diabetes_icon.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (16, 'Psycho-Social History', 'icons/misc/no_photo.png');
INSERT INTO lu_clinical_modules (pk, name, icon_path) VALUES (17, 'Care Planning', 'icons/20/careplan2020_1.png');


CREATE OR REPLACE VIEW "admin".vwstafftoolbarbuttons AS 
 SELECT lu_clinical_modules.pk AS pk_module, staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar, staff_clinical_toolbar.display_order, 
 lu_clinical_modules.name,  lu_clinical_modules.icon_path, staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.deleted
   FROM admin.staff_clinical_toolbar, admin.vwstaff, admin.lu_clinical_modules
  WHERE staff_clinical_toolbar.fk_staff = vwstaff.fk_staff AND staff_clinical_toolbar.fk_module = lu_clinical_modules.pk
  ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;

ALTER TABLE "admin".vwstafftoolbarbuttons OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwstafftoolbarbuttons TO easygp;
GRANT ALL ON TABLE "admin".vwstafftoolbarbuttons TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 105)
