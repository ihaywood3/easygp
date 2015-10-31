-- Workcover has now been moved to the Certificates tab so this is no longer a optional button
 update admin.lu_clinical_modules set in_use = False where pk= 8;
 update admin.staff_clinical_toolbar set deleted = True where fk_module = 8;

update db.lu_version set lu_minor=418;