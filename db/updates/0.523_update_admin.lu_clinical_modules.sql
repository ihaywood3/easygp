-- expose ability to add skin module button (the module not yet re-written, won't work)
update admin.lu_clinical_modules set in_use=True where pk=14;

update db.lu_version set lu_minor=523;