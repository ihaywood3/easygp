-- Ian and I made an executive decision that files would never be saved in the database.
delete from admin.global_preferences where name='document_save_to_database';
-- the default options icon on some linux system is almost un-intelligable (on mine was like tools/spanner so I'd used it for occupation' put mine now into svn.
UPDATE admin.lu_clinical_modules set icon_path = 'icons/22/occupation22x22.png' where pk=9; 
update admin.lu_clinical_modules set name = 'Allergies' where pk=13;

update db.lu_version set lu_minor=345;