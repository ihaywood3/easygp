-- hid the excision button as I never got around to finishing this lu_clinical_module
-- added the 'in_use' field to the query, this is a programmers field in essence

update admin.lu_clinical_modules set in_use = False where name ='Skin Excision';

DROP VIEW admin.vwstafftoolbarbuttons;

CREATE OR REPLACE VIEW admin.vwstafftoolbarbuttons AS 
 SELECT lu_clinical_modules.pk AS pk_module,
    staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar,
    staff_clinical_toolbar.display_order,
    lu_clinical_modules.name,
    lu_clinical_modules.icon_path,
    lu_clinical_modules.in_use,
    staff_clinical_toolbar.fk_staff,
    staff_clinical_toolbar.deleted
   FROM admin.staff_clinical_toolbar,
    admin.vwstaff,
    admin.lu_clinical_modules
  WHERE staff_clinical_toolbar.fk_staff = vwstaff.fk_staff AND staff_clinical_toolbar.fk_module = lu_clinical_modules.pk
  ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;

ALTER TABLE admin.vwstafftoolbarbuttons   OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstafftoolbarbuttons TO easygp;
GRANT ALL ON TABLE admin.vwstafftoolbarbuttons TO staff;


update db.lu_version set lu_minor = 534

