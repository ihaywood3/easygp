-- Set up tables for allowing staff to choose what toolbuttons show in Fclinical


CREATE TABLE "admin".clinical_modules
(
  pk serial primary key,
  "name" text NOT NULL,
  icon_path text);



ALTER TABLE "admin".clinical_modules OWNER TO easygp;
GRANT ALL ON TABLE "admin".clinical_modules TO easygp;
GRANT SELECT ON TABLE "admin".clinical_modules TO staff;

COMMENT ON TABLE "admin".clinical_modules IS 'modules which could be available clinically, may be set by user';



INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Health Issues', 'icons/16/pasthistory_1616.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Requests', 'icons/16/bloodtube16x16.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Referrals', 'icons/16/referrals_3_1616.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Scripts', 'icons/20/pill2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Recalls', 'icons/16/boomerang1616.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Travel', 'icons/16/airplane.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Mental Health', 'icons/20/smiley2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Workcover', 'icons/20/workcover2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Occupational History', 'icon:/small/tools');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Family History', 'icons/20/kde_family2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Vaccinations', 'icons/20/syringe2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Pregnancy', 'icons/20/pregnancy.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Allergy', 'icons/20/allergy2020.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Skin Excision', 'icons/24/glove-scalple_2424.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Diabetes Cycle of Care', 'icons/20/united_nations_diabetes_icon.png');
INSERT INTO "admin".clinical_modules (name, icon_path) VALUES ('Psycho-Social History', 'icons/misc/no_photo.png');


CREATE TABLE "admin".staff_clinical_toolbar
( pk serial primary key,
  fk_module integer NOT NULL,
  fk_staff integer NOT NULL,
  display_order integer NOT NULL
);

ALTER TABLE "admin".staff_clinical_toolbar OWNER TO easygp;
GRANT ALL ON TABLE "admin".staff_clinical_toolbar TO easygp;
GRANT SELECT ON TABLE "admin".staff_clinical_toolbar TO staff;

COMMENT ON TABLE "admin".staff_clinical_toolbar IS 'Links staff member to a toolbar button, allows staff to only put
  modules they want on the toolbar and in a particular order';

CREATE OR REPLACE VIEW "admin".vwstafftoolbarbuttons AS 
 SELECT clinical_modules.pk AS pk_module, staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar, staff_clinical_toolbar.display_order, clinical_modules.name, clinical_modules.icon_path, staff_clinical_toolbar.fk_staff
   FROM admin.staff_clinical_toolbar, admin.vwstaff, admin.clinical_modules
  WHERE staff_clinical_toolbar.fk_staff = vwstaff.fk_staff AND staff_clinical_toolbar.fk_module = clinical_modules.pk
  ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;

ALTER TABLE "admin".vwstafftoolbarbuttons OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwstafftoolbarbuttons TO easygp;
GRANT SELECT ON TABLE "admin".vwstafftoolbarbuttons TO staff;


truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 69);

