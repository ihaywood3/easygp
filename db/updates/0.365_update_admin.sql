-- add a new icon for clinical users to get a patients demographic database panel on their toolbar.
insert into admin.lu_clinical_modules("name",icon_path,in_use) values ('Patients','icons/32/open_icon_library_view-pim-contacts32x32.png',True);


update db.lu_version set lu_minor=365;