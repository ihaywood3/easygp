-- add a delete field so staff can mark a toolbutton as deleted

alter table admin.staff_clinical_toolbar add column deleted boolean default false;

CREATE OR REPLACE VIEW "admin".vwstafftoolbarbuttons AS 
 SELECT clinical_modules.pk AS pk_module, staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar,
 staff_clinical_toolbar.display_order, clinical_modules.name,
 clinical_modules.icon_path, staff_clinical_toolbar.fk_staff,
 staff_clinical_toolbar.deleted

   FROM admin.staff_clinical_toolbar, admin.vwstaff, admin.clinical_modules
  WHERE staff_clinical_toolbar.fk_staff = vwstaff.fk_staff AND staff_clinical_toolbar.fk_module = clinical_modules.pk
  ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;

ALTER TABLE "admin".vwstafftoolbarbuttons OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwstafftoolbarbuttons TO easygp;
GRANT ALL ON TABLE "admin".vwstafftoolbarbuttons TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 95);



